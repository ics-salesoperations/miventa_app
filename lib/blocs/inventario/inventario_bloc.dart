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
        ),
      );
    });
    on<OnFiltrarTipoEvent>((event, emit) {
      emit(
        state.copyWith(
          cargando: event.cargando,
          tipoSeleccionado: event.tipoSeleccionado,
          inventarioFiltrado: event.inventarioFiltrado,
        ),
      );
    });
  }

  final AuthService _authService = AuthService();
  final DBService _dbService = DBService();
  final UsuarioService _userService = UsuarioService();

  Future<void> actualiarInventario() async {
    add(OnActualizarInventarioEvent(cargando: true));

    try {
      final token = await _authService.getToken();
      final usuario = await _userService.getInfoUsuario();

      print("antes de petición");

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
    } catch (e) {}

    add(OnActualizarInventarioEvent(cargando: false));
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

  Future<void> filtrarInventario({
    required String tipoSeleccionado,
  }) async {
    add(
      OnFiltrarTipoEvent(
        cargando: true,
        tipoSeleccionado: tipoSeleccionado,
        inventarioFiltrado: const [],
      ),
    );

    final filtrado = state.inventario
        .where(
          (element) => element.producto.toString() == tipoSeleccionado,
        )
        .toList();

    add(
      OnFiltrarTipoEvent(
        cargando: false,
        tipoSeleccionado: tipoSeleccionado,
        inventarioFiltrado: filtrado,
      ),
    );
  }
}
