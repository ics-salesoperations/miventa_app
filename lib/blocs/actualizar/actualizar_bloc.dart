import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:miventa_app/global/environment.dart';
import 'package:miventa_app/models/form_response.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/models/planning_response.dart';
import 'package:miventa_app/services/services.dart';

part 'actualizar_event.dart';
part 'actualizar_state.dart';

class ActualizarBloc extends Bloc<ActualizarEvent, ActualizarState> {
  final DBService _dbService = DBService();
  final AuthService _authService = AuthService();
  final UsuarioService _userService = UsuarioService();

  ActualizarBloc() : super(const ActualizarState()) {
    on<OnActualizarFormulariosEvent>((event, emit) {
      emit(
        state.copyWith(
          mensaje: event.mensaje,
          actualizandoForms: event.actualizandoForms,
          tablas: event.tablas,
        ),
      );
    });
    on<OnGetTablasEvent>((event, emit) {
      emit(
        state.copyWith(
          tablas: event.tablas,
        ),
      );
    });
    on<OnActualizarPlanningEvent>((event, emit) {
      emit(
        state.copyWith(
          mensaje: event.mensaje,
          actualizandoPlanning: event.actualizandoPlanning,
          tablas: event.tablas,
        ),
      );
    });
    on<OnActualizarSolicitudesEvent>((event, emit) {
      emit(
        state.copyWith(
          mensaje: event.mensaje,
          actualizandoSolicitudes: event.actualizandoSolicitudes,
        ),
      );
    });
    on<OnActualizarIncentivosPdvEvent>((event, emit) {
      emit(
        state.copyWith(
          mensaje: event.mensaje,
          actualizandoIncentivosPdv: event.actualizandoIncentivosPdv,
        ),
      );
    });
    on<OnActualizarModelosEvent>((event, emit) {
      emit(
        state.copyWith(
          mensaje: event.mensaje,
          actualizandoModelos: event.actualizandoModelos,
          tablas: event.tablas,
        ),
      );
    });
    on<OnActualizarTangiblesEvent>((event, emit) {
      emit(
        state.copyWith(
          mensaje: event.mensaje,
          actualizandoTangible: event.actualizandoTangible,
          tablas: event.tablas,
        ),
      );
    });
    on<OnActualizarTangiblesReasignacionEvent>((event, emit) {
      emit(
        state.copyWith(
          mensaje: event.mensaje,
          actualizandoTangible: event.actualizandoTangible,
          tabla: event.tabla,
        ),
      );
    });
  }

  Future<void> actualizarTodo({required List<Tabla> currentTablas}) async {
    await actualizarFormularios(currentTablas: currentTablas);
    await actualizarPlanning(currentTablas: currentTablas);
  }

  Future<void> init() async {
    final tablas = await getTablas();
    add(OnGetTablasEvent(
      tablas: tablas,
    ));
  }

  Future<List<Tabla>> getTablas() async {
    final tablas = await _dbService.leerListadoTablas();

    return tablas;
  }

  Future<List<IncentivoPdv>> getIncentivosPdv(idPdv) async {
    List<IncentivoPdv> incentivoPdv;
    await actualizarIncentivosPdv(idPdv);
    incentivoPdv = await _dbService.leerIncentivosPorPdv(idPdv);

    return incentivoPdv;
  }

  Future<void> actualizarPlanning({required List<Tabla> currentTablas}) async {
    add(
      OnActualizarPlanningEvent(
        actualizandoPlanning: true,
        mensaje: "Espere un momento, estamos actualizando tu planificación.",
        tablas: currentTablas,
      ),
    );

    try {
      final token = await _authService.getToken();
      Usuario usuario = await _userService.getInfoUsuario();

      if (usuario.perfil == 1) {
        usuario = usuario.copyWith(idDms: '3768');
      }

      final resp = await http.get(
          Uri.parse(
            '${Environment.apiURL}/appmiventa/planificacion_ven2/' +
                usuario.idDms.toString(),
          ),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          }).timeout(const Duration(minutes: 10));

      final planningResponse = planningResponseFromJson(
        utf8.decode(resp.bodyBytes),
      );

      //guardar en base de datos local

      if (planningResponse.planning.isNotEmpty) {
        await _dbService.crearDetallePdv(planningResponse.planning);

        await _dbService.updateTabla(tbl: 'planning');
        final tablas = await _dbService.leerListadoTablas();
        add(OnActualizarPlanningEvent(
          actualizandoPlanning: false,
          mensaje: "Planificación actualizada exitosamente",
          tablas: tablas,
        ));
      } else {
        final tablas = await _dbService.leerListadoTablas();
        add(OnActualizarPlanningEvent(
          actualizandoPlanning: false,
          mensaje:
              "No se encontraron datos. Favor intenta nuevamente en un momento.",
          tablas: tablas,
        ));
      }
    } on TimeoutException catch (_) {
      add(OnActualizarPlanningEvent(
        actualizandoPlanning: false,
        mensaje: "Ocurrió un error al actualizar tu planificación.",
        tablas: currentTablas,
      ));
    } catch (e) {
      add(OnActualizarPlanningEvent(
        actualizandoPlanning: false,
        mensaje: "Ocurrió un error al actualizar tu planificación.",
        tablas: currentTablas,
      ));
    }
  }

  Future<void> actualizarPlanningSup(
      {required List<Tabla> currentTablas}) async {
    add(
      OnActualizarPlanningEvent(
        actualizandoPlanning: true,
        mensaje: "Espere un momento, estamos actualizando tu planificación.",
        tablas: currentTablas,
      ),
    );

    try {
      final token = await _authService.getToken();
      Usuario usuario = await _userService.getInfoUsuario();

      if (usuario.perfil == 1) {
        usuario = usuario.copyWith(idDms: '23');
      }

      final resp = await http.get(
          Uri.parse(
            '${Environment.apiURL}/appmiventa/planificacion_sup/' +
                usuario.idDms.toString(),
          ),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          }).timeout(const Duration(minutes: 10));

      final planningResponse = planningResponseFromJson(
        utf8.decode(resp.bodyBytes),
      );

      //guardar en base de datos local
      await _dbService.crearDetallePdv(planningResponse.planning);

      await _dbService.updateTabla(tbl: 'planning');
      final tablas = await _dbService.leerListadoTablas();
      add(OnActualizarPlanningEvent(
        actualizandoPlanning: false,
        mensaje: "Planificación actualizada exitosamente",
        tablas: tablas,
      ));
    } on TimeoutException catch (_) {
      add(OnActualizarPlanningEvent(
        actualizandoPlanning: false,
        mensaje: "Error: Tiempo de conexion excedido.",
        tablas: currentTablas,
      ));
    } catch (e) {
      add(OnActualizarPlanningEvent(
        actualizandoPlanning: false,
        mensaje:
            'Ocurrió un error al actualizar tu planificación', //"Ocurrio un error al actualizar tu planificacion ",
        tablas: currentTablas,
      ));
    }
  }

// planning gerencia
  Future<void> actualizarPlanningGer(
      {required List<Tabla> currentTablas}) async {
    add(
      OnActualizarPlanningEvent(
        actualizandoPlanning: true,
        mensaje: "Espere un momento, estamos actualizando tu planificación.",
        tablas: currentTablas,
      ),
    );

    try {
      final token = await _authService.getToken();
      Usuario usuario = await _userService.getInfoUsuario();

      if (usuario.perfil == 1) {
        usuario = usuario.copyWith(idDms: '23');
      }

      final resp = await http.get(
          Uri.parse(
            '${Environment.apiURL}/appmiventa/planificacion_ger/' +
                usuario.usuario.toString(),
          ),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          }).timeout(const Duration(minutes: 10));

      final planningResponse = planningResponseFromJson(
        utf8.decode(resp.bodyBytes),
      );

      //guardar en base de datos local
      await _dbService.crearDetallePdv(planningResponse.planning);

      await _dbService.updateTabla(tbl: 'planning');
      final tablas = await _dbService.leerListadoTablas();
      add(OnActualizarPlanningEvent(
        actualizandoPlanning: false,
        mensaje: "Planificación actualizada exitosamente",
        tablas: tablas,
      ));
    } on TimeoutException catch (_) {
      add(OnActualizarPlanningEvent(
        actualizandoPlanning: false,
        mensaje: "Error: Tiempo de conexion excedido.",
        tablas: currentTablas,
      ));
    } catch (e) {
      add(OnActualizarPlanningEvent(
        actualizandoPlanning: false,
        mensaje:
            'Ocurrió un error al actualizar tu planificación', //"Ocurrio un error al actualizar tu planificacion ",
        tablas: currentTablas,
      ));
    }
  }

  Future<void> actualizarModelos({required List<Tabla> currentTablas}) async {
    add(
      OnActualizarModelosEvent(
        actualizandoModelos: true,
        mensaje: "Espere un momento, estamos actualizando los modelos.",
        tablas: currentTablas,
      ),
    );

    try {
      final token = await _authService.getToken();

      final resp = await http.get(
          Uri.parse('${Environment.apiURL}/appmiventa/catalogo_modelos/' // +
              //usuario.idDms.toString(),
              ),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          }).timeout(const Duration(seconds: 360));

      final modeloTangibleResponse = modeloTangibleResponseFromJson(
        utf8.decode(resp.bodyBytes),
      );

      //guardar en base de datos local
      await _dbService.guardarModelos(modeloTangibleResponse.catalogoModelos);

      await _dbService.updateTabla(tbl: 'modelo');
      final tablas = await _dbService.leerListadoTablas();
      add(OnActualizarModelosEvent(
        actualizandoModelos: false,
        mensaje: "Modelos actualizados exitosamente.",
        tablas: tablas,
      ));
    } on TimeoutException catch (_) {
      add(OnActualizarModelosEvent(
        actualizandoModelos: false,
        mensaje: "Ocurrió un error al actualizar los modelos.",
        tablas: currentTablas,
      ));
    } catch (e) {
      add(OnActualizarModelosEvent(
        actualizandoModelos: false,
        mensaje: "Ocurrió un error al actualizar los modelos.",
        tablas: currentTablas,
      ));
    }
  }

  Future<void> actualizarFormularios(
      {required List<Tabla> currentTablas}) async {
    add(OnActualizarFormulariosEvent(
      actualizandoForms: true,
      mensaje: "Espere un momento, estamos actualizando los formularios.",
      tablas: currentTablas,
    ));

    try {
      final token = await _authService.getToken();
      final resp = await http.get(
          Uri.parse('${Environment.apiURL}/appdms/estructura_form/300'),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          }).timeout(
        const Duration(
          seconds: 30,
        ),
      );

      final formsResponse = formResponseFromMap(
        utf8.decode(resp.bodyBytes),
      );

      //guardar en base de datos local
      await _dbService.crearFormularios(formsResponse.detalleFormulario);
      await _dbService.updateTabla(tbl: 'formulario');
      final tablas = await _dbService.leerListadoTablas();
      add(OnActualizarFormulariosEvent(
        actualizandoForms: false,
        mensaje: "Formularios actualizados exitosamente",
        tablas: tablas,
      ));
    } on TimeoutException catch (_) {
      add(OnActualizarFormulariosEvent(
        actualizandoForms: false,
        mensaje: "Ocurrió un error al actualizar los formularios",
        tablas: currentTablas,
      ));
    } catch (e) {
      add(OnActualizarFormulariosEvent(
        actualizandoForms: false,
        mensaje: "Ocurrió un error al actualizar los formularios",
        tablas: currentTablas,
      ));
    }
  }

  Future<void> actualizarTangible({required List<Tabla> currentTablas}) async {
    add(OnActualizarTangiblesEvent(
      actualizandoTangible: true,
      mensaje: "Espere un momento, estamos actualizando los tangibles.",
      tablas: currentTablas,
    ));

    try {
      final token = await _authService.getToken();
      final usuario = await _userService.getInfoUsuario();

      final tangibleConfirmado = await _dbService.getTangibleConfirmado();

      if (tangibleConfirmado.isNotEmpty) {
        add(OnActualizarTangiblesEvent(
          actualizandoTangible: false,
          mensaje: "[ERROR]. Tienes producto pendiente de sincronizar.",
          tablas: currentTablas,
        ));
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
      final tablas = await _dbService.leerListadoTablas();
      add(OnActualizarTangiblesEvent(
        actualizandoTangible: false,
        mensaje: "Producto asignado actualizado exitosamente.",
        tablas: tablas,
      ));
    } catch (e) {
      add(OnActualizarTangiblesEvent(
        actualizandoTangible: false,
        mensaje: "Ocurrió un error al actualizar el producto asignado",
        tablas: currentTablas,
      ));
    }
  }

  Future<void> actualizarTangibleReasignacion({required int idPdv}) async {
    add(const OnActualizarTangiblesReasignacionEvent(
      actualizandoTangible: true,
      mensaje: "Espere un momento, estamos actualizando los tangibles.",
      tabla: 'tangible_reasignacion',
    ));

    try {
      final token = await _authService.getToken();

      final tangibleConfirmado =
          await _dbService.getTangibleReasingacion(idPdv);

      if (tangibleConfirmado.isNotEmpty) {
        add(const OnActualizarTangiblesReasignacionEvent(
          actualizandoTangible: false,
          mensaje: "[ERROR]. Tienes producto pendiente de sincronizar.",
          tabla: 'tangible_reasignacion',
        ));
        return;
      }
    
      final resp = await http.get(
          Uri.parse('${Environment.apiURL}/appmiventa/tangibles_pdv/' +
              idPdv.toString()),
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
      final tablas = await _dbService.leerListadoTablas();
      add(const OnActualizarTangiblesReasignacionEvent(
        actualizandoTangible: false,
        mensaje: "Producto asignado actualizado exitosamente.",
        tabla: 'tangible_reasignacion',
      ));
    } catch (e) {
      add(const OnActualizarTangiblesReasignacionEvent(
        actualizandoTangible: false,
        mensaje: "Ocurrió un error al actualizar el producto asignado",
        tabla: 'tangible_reasignacion',
      ));
    }
  }

  Future<void> actualizarSolicitudes() async {
    add(
      const OnActualizarSolicitudesEvent(
        actualizandoSolicitudes: true,
        mensaje: "Espere un momento, estamos actualizando las solicitudes.",
      ),
    );

    try {
      final token = await _authService.getToken();
      final usuario = await _userService.getInfoUsuario();

      final resp = await http.get(
          Uri.parse(
            '${Environment.apiURL}/appmiventa/solicitudes/' +
                usuario.usuario.toString(),
          ),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          }).timeout(const Duration(
        minutes: 5,
      ));

      final solicitudesResponse = solicitudesResponseFromJson(
        utf8.decode(resp.bodyBytes),
      );
      //guardar en base de datos local

      if (solicitudesResponse.data.isNotEmpty) {
        await _dbService.crearDetalleSolicitudes(solicitudesResponse.data);
        add(const OnActualizarSolicitudesEvent(
          actualizandoSolicitudes: false,
          mensaje: "Solicitudes actualizadas exitosamente.",
        ));
      } else {
        add(const OnActualizarSolicitudesEvent(
          actualizandoSolicitudes: false,
          mensaje: "Ocurrió un error al actualizar sus solicitudes.",
        ));
      }
    } on TimeoutException catch (_) {
      add(const OnActualizarSolicitudesEvent(
        actualizandoSolicitudes: false,
        mensaje: "Ocurrió un error al actualizar sus solicitudes.",
      ));
    } catch (e) {
      add(const OnActualizarSolicitudesEvent(
        actualizandoSolicitudes: false,
        mensaje: "Ocurrió un error al actualizar sus solicitudes.",
      ));
    }
  }

  Future<void> actualizarSolicitudesSup() async {
    add(
      const OnActualizarSolicitudesEvent(
        actualizandoSolicitudes: true,
        mensaje: "Espere un momento, estamos actualizando las solicitudes.",
      ),
    );

    try {
      final token = await _authService.getToken();
      Usuario usuario = await _userService.getInfoUsuario();

      if (usuario.perfil == 1) {
        usuario = usuario.copyWith(idDms: '23');
      }

      final resp = await http.get(
          Uri.parse(
            '${Environment.apiURL}/appmiventa/solicitudes/supervisor/' +
                usuario.idDms.toString(),
          ),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          }).timeout(const Duration(
        minutes: 5,
      ));

      final solicitudesResponse = solicitudesResponseFromJson(
        utf8.decode(resp.bodyBytes),
      );
      //guardar en base de datos local

      if (solicitudesResponse.data.isNotEmpty) {
        await _dbService.crearDetalleSolicitudes(solicitudesResponse.data);
        add(const OnActualizarSolicitudesEvent(
          actualizandoSolicitudes: false,
          mensaje: "Solicitudes actualizadas exitosamente.",
        ));
      } else {
        add(const OnActualizarSolicitudesEvent(
          actualizandoSolicitudes: false,
          mensaje: "Ocurrió un error al actualizar sus solicitudes.",
        ));
      }
    } on TimeoutException catch (_) {
      add(const OnActualizarSolicitudesEvent(
        actualizandoSolicitudes: false,
        mensaje: "Ocurrió un error al actualizar sus solicitudes.",
      ));
    } catch (e) {
      add(const OnActualizarSolicitudesEvent(
        actualizandoSolicitudes: false,
        mensaje: "Ocurrió un error al actualizar sus solicitudes.",
      ));
    }
  }

  Future<void> actualizarIncentivosPdv(idPdv) async {
    add(
      const OnActualizarIncentivosPdvEvent(
        actualizandoIncentivosPdv: true,
        mensaje: "Espere un momento, estamos actualizando las IncentivosPdv.",
      ),
    );

    try {
      final token = await _authService.getToken();
      final resp = await http.get(
          Uri.parse(
            '${Environment.apiURL}/appmiventa/incentivos_pdv/' +
                idPdv.toString(),
          ),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          }).timeout(const Duration(
        minutes: 5,
      ));
      final incentivosPdvResponse = IncentivoPdvResponseFromJson(
        utf8.decode(resp.bodyBytes),
      );
      //guardar en base de datos local

      if (incentivosPdvResponse.incentivosPDV.isNotEmpty) {
        await _dbService
            .crearDetalleIncentivoPdv(incentivosPdvResponse.incentivosPDV);
        add(const OnActualizarIncentivosPdvEvent(
          actualizandoIncentivosPdv: false,
          mensaje: "IncentivosPdv actualizadas exitosamente.",
        ));
      } else {
        add(const OnActualizarIncentivosPdvEvent(
          actualizandoIncentivosPdv: false,
          mensaje: "Ocurrió un error al actualizar sus IncentivosPdv.",
        ));
      }
    } on TimeoutException catch (_) {
      add(const OnActualizarIncentivosPdvEvent(
        actualizandoIncentivosPdv: false,
        mensaje: "Ocurrió un error al actualizar sus IncentivosPdv.",
      ));
    } catch (e) {
      add(const OnActualizarIncentivosPdvEvent(
        actualizandoIncentivosPdv: false,
        mensaje: "Ocurrió un error al actualizar sus IncentivosPdv.",
      ));
    }
  }
}
