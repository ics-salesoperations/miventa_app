import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:miventa_app/global/environment.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/services.dart';

part 'inventario_reasignado_event.dart';
part 'inventario_reasignado_state.dart';

class InventarioReasignadoBloc
    extends Bloc<InventarioReasignadoEvent, InventarioReasignadoState> {
  InventarioReasignadoBloc() : super(const InventarioReasignadoState()) {
    on<OnActualizarInventarioReasignadoEvent>((event, emit) {
      emit(
        state.copyWith(
          cargando: event.cargando,
        ),
      );
    });
    on<OnCargarInventarioReasignadoEvent>((event, emit) {
      emit(
        state.copyWith(
            cargando: event.cargando,
            tipos: event.tipos,
            inventarioReasignado: event.inventarioReasignado,
            inventarioReasignadoFiltrado: event.inventarioReasignado,
            tipoSeleccionado: '',
            modeloSeleccionado: ''),
      );
    });
    on<OnFiltrarTipoReasignacionEvent>((event, emit) {
      emit(
        state.copyWith(
            cargando: event.cargando,
            tipoSeleccionado: event.tipoSeleccionado,
            inventarioReasignadoFiltrado: event.inventarioReasignadoFiltrado,
            tipoInfoReasignacion: event.tipoInfoReasignacion,
            modeloSeleccionado: event.modeloSeleccionado),
      );
    });
  }

  final AuthService _authService = AuthService();
  final DBService _dbService = DBService();

  Future<void> init(idPdv) async {
    await actualizarInventarioReasignado(idPdv);
  }

  Future<void> actualizarInventarioReasignado(idPdv) async {
    add(const OnActualizarInventarioReasignadoEvent(cargando: true));

    try {
      final token = await _authService.getToken();

      final resp = await http.get(
          Uri.parse('${Environment.apiURL}/appmiventa/tangibles_pdv/' + idPdv),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          }).timeout(
        const Duration(
          minutes: 10,
        ),
      );

      final productoResponse = productoTangibleReasignacionResponseFromJson(
        utf8.decode(resp.bodyBytes),
      );

      //guardar en base de datos local
      await _dbService
          .guardarTangiblesReasignado(productoResponse.tangiblesReasignados);
      await _dbService.updateTabla(tbl: 'tangible_reasignacion');
      // ignore: empty_catches
    } catch (e) {}

    add(const OnActualizarInventarioReasignadoEvent(cargando: false));
  }

  Future<void> cargarInventarioReasignado() async {
    add(
      const OnCargarInventarioReasignadoEvent(
        cargando: true,
        tipos: [],
        inventarioReasignado: [],
      ),
    );

    final tipo = await _dbService.leerTiposReasignacionDB();
    final inv = await _dbService.leerInventarioReasignadoDB();

    add(
      OnCargarInventarioReasignadoEvent(
        cargando: false,
        tipos: tipo,
        inventarioReasignado: inv,
      ),
    );
  }

  Future<void> filtrarInventarioReasignado(
      {required String tipoSeleccionado, String? modeloSeleccionado}) async {
    add(
      OnFiltrarTipoReasignacionEvent(
          cargando: true,
          tipoSeleccionado: tipoSeleccionado,
          inventarioReasignadoFiltrado: const [],
          tipoInfoReasignacion: const [],
          modeloSeleccionado: modeloSeleccionado ?? ''),
    );

    final filtrado = state.inventarioReasignado
        .where((element) =>
            element.producto.toString() == tipoSeleccionado &&
            (modeloSeleccionado == null ||
                element.descModelo.toString() == modeloSeleccionado))
        .toList();

    final modelo = await _dbService.leerDescripcionModelosReasignacion(
        tangible: tipoSeleccionado);

    add(
      OnFiltrarTipoReasignacionEvent(
          cargando: false,
          tipoSeleccionado: tipoSeleccionado,
          inventarioReasignadoFiltrado: filtrado,
          tipoInfoReasignacion: modelo,
          modeloSeleccionado: modeloSeleccionado),
    );
  }

  Future<void> actualizarTangibleReasinado(idPdv) async {
    add(
      const OnCargarInventarioReasignadoEvent(
        cargando: true,
        tipos: [],
        inventarioReasignado: [],
      ),
    );

    try {
      final token = await _authService.getToken();

      final tangibleReasignacion =
          await _dbService.getTangibleReasingacion(idPdv);

      if (tangibleReasignacion.isNotEmpty) {
        add(
          OnCargarInventarioReasignadoEvent(
            cargando: false,
            tipos: state.tipos,
            inventarioReasignado: state.inventarioReasignado,
          ),
        );

        return;
      }

      final resp = await http.get(
          Uri.parse('${Environment.apiURL}/appmiventa/tangibles_pdv/' + idPdv),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          }).timeout(
        const Duration(
          minutes: 10,
        ),
      );

      final productoResponse = productoTangibleReasignacionResponseFromJson(
        utf8.decode(resp.bodyBytes),
      );

      //guardar en base de datos local
      await _dbService
          .guardarTangiblesReasignado(productoResponse.tangiblesReasignados);
      await _dbService.updateTabla(tbl: 'tangible_reasignacion');
    } catch (e) {
      null;
    } finally {
      final tipo = await _dbService.leerTiposReasignacionDB();
      final inv = await _dbService.leerInventarioReasignadoDB();

      add(
        OnCargarInventarioReasignadoEvent(
          cargando: false,
          tipos: tipo,
          inventarioReasignado: inv,
        ),
      );
    }
  }
}
