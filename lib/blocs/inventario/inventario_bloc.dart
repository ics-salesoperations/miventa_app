import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:miventa_app/global/environment.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/services.dart';

part 'inventario_event.dart';
part 'inventario_state.dart';

class InventarioBloc extends Bloc<InventarioEvent, InventarioState> {
  InventarioBloc() : super(const InventarioState()) {
    on<OnActualizarInventarioEvent>((event, emit) {
      emit(
        state.copyWith(
          cargando: event.cargando,
        ),
      );
    });
    on<OnCargarInventarioEvent>((event, emit) {
      emit(
        state.copyWith(
            cargando: event.cargando,
            tipos: event.tipos,
            inventario: event.inventario,
            inventarioFiltrado: event.inventario,
            tipoSeleccionado: '',
            modeloSeleccionado: ''),
      );
    });
    on<OnFiltrarTipoEvent>((event, emit) {
      emit(
        state.copyWith(
            cargando: event.cargando,
            tipoSeleccionado: event.tipoSeleccionado,
            inventarioFiltrado: event.inventarioFiltrado,
            tipoInfo: event.tipoInfo,
            modeloSeleccionado: event.modeloSeleccionado),
      );
    });
  }

  final AuthService _authService = AuthService();
  final DBService _dbService = DBService();
  final UsuarioService _userService = UsuarioService();

  Future<void> actualiarInventario() async {
    add(const OnActualizarInventarioEvent(cargando: true));

    try {
      final token = await _authService.getToken();
      final usuario = await _userService.getInfoUsuario();

      final resp = await http.get(
          Uri.parse('${Environment.apiURL}/appmiventa/tangibles_vendedor/' +
              usuario.idDms.toString()),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          }).timeout(
        const Duration(
          minutes: 10,
        ),
      );

      final productoResponse = productoTangibleResponseFromJson(
        utf8.decode(resp.bodyBytes),
      );

      //guardar en base de datos local
      await _dbService.guardarTangibles(productoResponse.tangiblesAsignados);
      await _dbService.updateTabla(tbl: 'tangible');
    } catch (e) {
      null;
    }

    add(const OnActualizarInventarioEvent(cargando: false));
  }

  Future<void> cargarInventario() async {
    add(
      const OnCargarInventarioEvent(
        cargando: true,
        tipos: [],
        inventario: [],
      ),
    );

    final tipo = await _dbService.leerTiposDB();
    final inv = await _dbService.leerInventarioDB();

    add(
      OnCargarInventarioEvent(
        cargando: false,
        tipos: tipo,
        inventario: inv,
      ),
    );
  }

  Future<void> filtrarInventario(
      {required String tipoSeleccionado, String? modeloSeleccionado}) async {
    add(
      OnFiltrarTipoEvent(
          cargando: true,
          tipoSeleccionado: tipoSeleccionado,
          inventarioFiltrado: const [],
          tipoInfo: const [],
          modeloSeleccionado: modeloSeleccionado ?? ''),
    );

    final filtrado = state.inventario
        .where((element) =>
            element.producto.toString() == tipoSeleccionado &&
            (modeloSeleccionado == null ||
                element.descModelo.toString() == modeloSeleccionado))
        .toList();

    final modelo =
        await _dbService.leerDescripcionModelos(tangible: tipoSeleccionado);

    add(
      OnFiltrarTipoEvent(
          cargando: false,
          tipoSeleccionado: tipoSeleccionado,
          inventarioFiltrado: filtrado,
          tipoInfo: modelo,
          modeloSeleccionado: modeloSeleccionado),
    );
  }

  Future<void> actualizarTangible() async {
    add(
      const OnCargarInventarioEvent(
        cargando: true,
        tipos: [],
        inventario: [],
      ),
    );

    try {
      final token = await _authService.getToken();
      final usuario = await _userService.getInfoUsuario();

      final tangibleConfirmado = await _dbService.getTangibleConfirmado();

      if (tangibleConfirmado.isNotEmpty) {
        add(
          OnCargarInventarioEvent(
            cargando: false,
            tipos: state.tipos,
            inventario: state.inventario,
          ),
        );

        return;
      }

      final resp = await http.get(
          Uri.parse('${Environment.apiURL}/appmiventa/tangibles_vendedor/' +
              usuario.idDms.toString()),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          }).timeout(
        const Duration(
          minutes: 10,
        ),
      );

      final productoResponse = productoTangibleResponseFromJson(
        utf8.decode(resp.bodyBytes),
      );

      //guardar en base de datos local
      await _dbService.guardarTangibles(productoResponse.tangiblesAsignados);
      await _dbService.updateTabla(tbl: 'tangible');
   
    } catch (e) {
      null;
    } finally {
      final tipo = await _dbService.leerTiposDB();
      final inv = await _dbService.leerInventarioDB();

      add(
        OnCargarInventarioEvent(
          cargando: false,
          tipos: tipo,
          inventario: inv,
        ),
      );
    }
  }
}
