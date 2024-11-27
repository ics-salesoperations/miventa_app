import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/global/environment.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'carrito_reasignacion_event.dart';
part 'carrito_reasignacion_state.dart';

class CarritoReasignacionBloc
    extends Bloc<CarritoReasignacionEvent, CarritoReasignacionState> {
  final DBService _dbService = DBService();
  final UsuarioService _usuarioService = UsuarioService();
  final AuthService _authService = AuthService();
  FormGroup formulario = FormGroup({
    'mensaje': FormControl<String>(value: 'Cargando datos'),
  });

  CarritoReasignacionBloc()
      : super(
          CarritoReasignacionState(
            frmProductos: FormGroup(
              {
                'mensaje': FormControl<String>(value: 'Cargando datos'),
              },
            ),
            actual: ModeloTangible(),
            serieActual: ProductoTangibleReasignacion(),
          ),
        ) {
    on<OnCargarModelosReasignacionEvent>((event, emit) {
      emit(
        state.copyWith(
          mensaje: event.mensaje,
          cargandoModelos: event.cargandoModelos,
          modelos: event.modelos,
          actual: ModeloTangible(),
        ),
      );
    });
    on<OnCargarModelosAsignadosoReasignacionEvent>((event, emit) {
      emit(
        state.copyWith(
          modelosAsignados: event.modelosAsignados,
        ),
      );
    });
    on<OnUpdateTotalReasignacionEvent>((event, emit) {
      emit(
        state.copyWith(
          total: event.total,
        ),
      );
    });
    on<OnCambiarCategoriaReasignacionEvent>((event, emit) {
      emit(
        state.copyWith(
          selectedCat: event.categoria,
        ),
      );
    });
    on<OnCambiarFiltroReasignacionEvent>((event, emit) {
      emit(
        state.copyWith(
          filter: event.filtro,
        ),
      );
    });
    on<OnCargarFrmProductoReasignacionEvent>((event, emit) {
      emit(
        state.copyWith(
          cargandoFrmProductos: event.cargandoFrmProducto,
          frmProductos: event.frmProducto,
        ),
      );
    });
    on<OnCargarLstTangibleModeloReasignacionEvent>((event, emit) {
      emit(
        state.copyWith(
          cargandoLstTangibleModelo: event.cargandoLstTangibleModelo,
          lstTangibleModelo: event.lstTangibleModelo,
        ),
      );
    });
    on<OnEnviarTangiblesReasignacionEvent>((event, emit) {
      emit(
        state.copyWith(
          mensaje: event.mensaje,
          enviando: event.enviando,
        ),
      );
    });
    on<OnChangeModeloActualReasignacion>((event, emit) {
      emit(
        state.copyWith(
          actual: event.actual,
          modelos: state.modelos.map((elemento) {
            return elemento.modelo == event.actual.modelo
                ? event.actual
                : elemento;
          }).toList(),
        ),
      );
    });
    on<OnChangeSerieActualReasignacion>((event, emit) {
      emit(
        state.copyWith(
          serieActual: event.actual,
          lstTangibleModelo: state.lstTangibleModelo.map((elemento) {
            return elemento.serie == event.actual.serie
                ? event.actual
                : elemento;
          }).toList(),
        ),
      );
    });
    on<OnUpdateBlisterReasignacionEvent>((event, emit) {
      emit(
        state.copyWith(
          blisterValidado: event.blisterValidado,
          mensaje: event.mensaje,
          validandoBlister: event.validandoBlister,
        ),
      );
    });

    //init();
  }

  Future<void> init(int idPdv) async {
    final m = await getModelosReasignacion(idPdv);
    await crearFrmProductos(m);
    await actualizaTotal();
  }

  Future<List<ModeloTangible>> getModelos() async {
    add(OnCargarModelosReasignacionEvent(
      modelos: state.modelos,
      cargandoModelos: true,
      mensaje: "",
    ));

    List<ModeloTangible> modelos;

    try {
      modelos = await _dbService.leerListadoModelos();
    } catch (e) {
      modelos = const [];
      add(OnCargarModelosReasignacionEvent(
          modelos: modelos,
          cargandoModelos: false,
          mensaje: "Ocurrió un error al actualizar modelos"));
    }

    add(OnCargarModelosReasignacionEvent(
      modelos: modelos,
      cargandoModelos: false,
      mensaje: "",
    ));

    return modelos;
  }

  Future<List<ModeloTangible>> getModelosReasignacion(int idPDv) async {
    add(OnCargarModelosReasignacionEvent(
      modelos: state.modelos,
      cargandoModelos: true,
      mensaje: "",
    ));

    List<ModeloTangible> modelos;

    try {
      modelos = await _dbService.leerListadoModelosReasignacion(idPDv);
    } catch (e) {
      modelos = const [];
      add(OnCargarModelosReasignacionEvent(
          modelos: modelos,
          cargandoModelos: false,
          mensaje: "Ocurrió un error al actualizar modelos"));
    }

    add(OnCargarModelosReasignacionEvent(
      modelos: modelos,
      cargandoModelos: false,
      mensaje: "",
    ));

    return modelos;
  }

  Future<void> procesarVisita({
    required int idPdv,
    required String idVisita,
  }) async {
    SyncBloc _sincronizar = SyncBloc();

    add(const OnEnviarTangiblesReasignacionEvent(
      enviando: true,
      mensaje: "Datos guardados correctamente.",
    ));

    await confirmarTangibleReasignados(
      idPdv: idPdv,
    );

    add(const OnEnviarTangiblesReasignacionEvent(
      enviando: true,
      mensaje: "Datos guardados correctamente, Enviando datos...",
    ));

    await enviarDatos(idPdv);
    await _sincronizar.sincronizarDatos(1, idPdv);

    add(const OnEnviarTangiblesReasignacionEvent(
      enviando: false,
      mensaje: "Proceso realizado correctamente.",
    ));
  }

  Future<void> confirmarTangiblesAsignados({
    required int idPdv,
  }) async {
    try {
      await _dbService.confirmarTangiblesAsignadios(
        idPdv: idPdv,
      );
    } catch (e) {
      add(const OnEnviarTangiblesReasignacionEvent(
        enviando: false,
        mensaje: "Ocurrió un error al procesar la venta.",
      ));
    }
  }

  Future<void> confirmarTangibleReasignados({
    required int idPdv,
  }) async {
    try {
      await _dbService.confirmarTangiblesReasignadios(
        idPdv: idPdv,
      );
    } catch (e) {
      add(const OnEnviarTangiblesReasignacionEvent(
        enviando: false,
        mensaje: "Ocurrió un error al procesar la venta.",
      ));
    }
  }

  Future<void> enviarDatos(int idPdv) async {
    add(
      const OnEnviarTangiblesReasignacionEvent(
        enviando: true,
        mensaje: "Estamos sincronizando los datos... ",
      ),
    );

    final usuario = await _usuarioService.getInfoUsuario();
    final token = await _authService.getToken();
    final registros = await _dbService.getTangibleConfirmadoReasignacion(idPdv);
    final List<Map<String, dynamic>> datos = [];

    for (var venta in registros) {
      if (venta.fechaVenta == null) continue;

      final id = DateFormat('ddMMyyyyHHmmss').format(venta.fechaVenta!) +
          usuario.usuario.toString() +
          venta.serie.toString();
      String tipoGestion = "";

      if (venta.asignado == 1) {
        tipoGestion = "REASIGNADO";
      } else if (venta.descartado == 1) {
        tipoGestion = "NO ENCONTRADO";
      }

      final data = {
        'captureId': id.toString(),
        'fechaAsignacion': venta.fechaVenta?.toIso8601String(),
        'usuario': usuario.usuario,
        'idPdv': venta.idPdv.toString(),
        'idVisita': venta.idVisita.toString(),
        'serie': venta.serie,
        'tipoGestion': tipoGestion.toString()
      };

      datos.add(data);
    }

    try {
      final body = {
        "data": datos,
      };

      final jsonString = jsonEncode(body);

      print('string: ' + jsonString);

      final resp = await http
          .post(
            Uri.parse(
                '${Environment.apiURL}/appmiventa/guardar_venta_tipo_gestion_json'),
            body: jsonString,
            headers: {'Content-Type': 'application/json', 'token': token},
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(
            minutes: 10,
          ));

      if (resp.statusCode == 200) {
        add(
          const OnEnviarTangiblesReasignacionEvent(
            enviando: true,
            mensaje: 'Actualizando datos sincronizados.',
          ),
        );
        await _dbService.updateTangibleEnviadoReasignado(
          registros,
        );
        add(
          const OnEnviarTangiblesReasignacionEvent(
            enviando: false,
            mensaje: 'Datos enviados exitosamente.',
          ),
        );
      } else {
        add(
          const OnEnviarTangiblesReasignacionEvent(
            enviando: false,
            mensaje: 'Ocurrió un error al realizar la asignación.',
          ),
        );
        return;
      }
    } catch (e) {
      add(
        const OnEnviarTangiblesReasignacionEvent(
          enviando: false,
          mensaje: 'Ocurrió un error al realizar la asignación.',
        ),
      );
      return;
    }
  }

  Future<List<ModeloTangible>> getModelosAsignados({
    required Planning pdv,
  }) async {
    add(const OnCargarModelosAsignadosoReasignacionEvent(
      modelosAsignados: [],
    ));

    List<ModeloTangible> modelos;

    try {
      modelos = await _dbService.leerListadoModelosReasignados();
    } catch (e) {
      modelos = const [];
      add(OnCargarModelosAsignadosoReasignacionEvent(
        modelosAsignados: modelos,
      ));
    }

    add(OnCargarModelosAsignadosoReasignacionEvent(
      modelosAsignados: modelos,
    ));

    await validarBlister(
      pdv: pdv,
      modelos: modelos,
    );

    return modelos;
  }

  Future<void> actualizaTotal() async {
    int total = 0;

    try {
      total = await _dbService.leerTotalModelosReasignacion();
    } catch (e) {
      total = 0;
    }

    add(OnUpdateTotalReasignacionEvent(
      total: total,
    ));
  }

  Future<void> getTangiblePorModelo(
      {required ModeloTangible modelo, required int idPdv}) async {
    add(const OnCargarLstTangibleModeloReasignacionEvent(
      lstTangibleModelo: [],
      cargandoLstTangibleModelo: true,
    ));

    List<ProductoTangibleReasignacion> tangibles;

    try {
      tangibles = await _dbService.getTangibleModeloReasignacion(
          modelo: modelo, idPdv: idPdv);
      tangibles.sort(
        (a, b) {
          return (DateFormat('yyyyMMdd').format(a.fechaAsignacion!) + a.serie!)
              .compareTo(
                  DateFormat('yyyyMMdd').format(b.fechaAsignacion!) + b.serie!);
        },
      );
      add(OnCargarLstTangibleModeloReasignacionEvent(
        lstTangibleModelo: tangibles,
        cargandoLstTangibleModelo: false,
      ));
    } catch (e) {
      add(const OnCargarLstTangibleModeloReasignacionEvent(
        lstTangibleModelo: [],
        cargandoLstTangibleModelo: false,
      ));
    }
  }

  Future<void> crearFrmProductos(List<ModeloTangible> modelos) async {
    add(OnCargarFrmProductoReasignacionEvent(
      cargandoFrmProducto: true,
      frmProducto: formulario,
    ));

    Map<String, AbstractControl<dynamic>> elementos = {};
    Map<String, AbstractControl<dynamic>> elemento = {};

    for (var modelo in modelos) {
      List<Map<String, dynamic>? Function(AbstractControl<dynamic>)>
          validaciones = [Validators.min(0), Validators.max(modelo.disponible)];

      elemento = <String, AbstractControl<dynamic>>{
        modelo.tangible.toString() + modelo.modelo.toString(): FormControl<int>(
          value: modelo.asignado,
          validators: validaciones,
          //disabled: true,
        )
      };
      elementos.addEntries(elemento.entries);
    }

    add(OnCargarFrmProductoReasignacionEvent(
      cargandoFrmProducto: false,
      frmProducto: FormGroup(elementos),
    ));
  }

  Future<int> asignarProducto({
    String? serie,
    required ModeloTangible modelo,
    required int idPdv,
    required String idVisita,
  }) async {
    int valor = -1;

    List<ProductoTangibleReasignacion> lstTangibleDet =
        await _dbService.getTangibleReasignacion(
      serie: serie,
      modelo: modelo.modelo,
      tangible: modelo.tangible,
      asignar: true,
    );

    lstTangibleDet.sort(
      (a, b) {
        return (DateFormat('yyyyMMdd').format(a.fechaAsignacion!) + a.serie!)
            .compareTo(
                DateFormat('yyyyMMdd').format(b.fechaAsignacion!) + b.serie!);
      },
    );

    if (lstTangibleDet.isEmpty) {
      valor = -1;
    } else {
      ProductoTangibleReasignacion? tangibleDet;

      if (serie != null) {
        tangibleDet = lstTangibleDet.first;
      } else {
        final filtrado = lstTangibleDet.isEmpty
            ? []
            : lstTangibleDet.where((element) => element.asignado == 0).toList();
        tangibleDet = filtrado.isEmpty ? null : filtrado.first;
      }

      if (tangibleDet != null && tangibleDet.descartado == 0) {
        valor = tangibleDet.asignado == 1 ? 0 : 1;

        tangibleDet = tangibleDet.copyWith(
          asignado: tangibleDet.asignado == 1 ? 0 : 1,
          idPdv: tangibleDet.asignado == 1 ? null : idPdv,
          idVisita: tangibleDet.asignado == 1 ? null : idVisita,
          fechaVenta: tangibleDet.asignado == 1 ? null : DateTime.now(),
        );

        await _dbService.updateTangibleReasignacion(tangibleDet);

        var sum = tangibleDet.asignado == 1 ? 1 : -1;

        var modeloNuevo = modelo.copyWith(
          asignado: modelo.asignado + sum,
        );

        await _dbService.updateModeloTangible(modeloNuevo);

        add(OnChangeSerieActualReasignacion(actual: tangibleDet));
        add(OnChangeModeloActualReasignacion(
          actual: modelo,
        ));
      }
    }
    return valor;
  }

  Future<int> descartarProducto({
    String? serie,
    required ModeloTangible modelo,
    required int idPdv,
    required String idVisita,
  }) async {
    int valor = -1;

    List<ProductoTangibleReasignacion> lstTangibleDet =
        await _dbService.getTangibleReasignacionDes(
      serie: serie,
      modelo: modelo.modelo,
      tangible: modelo.tangible,
      asignar: true,
    );

    lstTangibleDet.sort(
      (a, b) {
        return (DateFormat('yyyyMMdd').format(a.fechaAsignacion!) + a.serie!)
            .compareTo(
                DateFormat('yyyyMMdd').format(b.fechaAsignacion!) + b.serie!);
      },
    );

    if (lstTangibleDet.isEmpty) {
      valor = -1;
    } else {
      ProductoTangibleReasignacion? tangibleDet;

      if (serie != null) {
        tangibleDet = lstTangibleDet.first;
      } else {
        final filtrado = lstTangibleDet.isEmpty
            ? []
            : lstTangibleDet
                .where((element) => element.descartado == 0)
                .toList();
        tangibleDet = filtrado.isEmpty ? null : filtrado.first;
      }

      if (tangibleDet != null && tangibleDet.asignado == 0) {
        valor = tangibleDet.descartado == 1 ? 0 : 1;

        tangibleDet = tangibleDet.copyWith(
          descartado: tangibleDet.descartado == 1 ? 0 : 1,
          idPdv: tangibleDet.descartado == 1 ? null : idPdv,
          idVisita: tangibleDet.descartado == 1 ? null : idVisita,
          fechaVenta: tangibleDet.descartado == 1 ? null : DateTime.now(),
        );

        await _dbService.updateTangibleReasignacion(tangibleDet);

        var sum = tangibleDet.descartado == 1 ? 1 : -1;

        var modeloNuevo = modelo.copyWith(
          descartado: modelo.asignado + sum,
        );

        await _dbService.updateModeloTangible(modeloNuevo);

        add(OnChangeSerieActualReasignacion(actual: tangibleDet));
        add(OnChangeModeloActualReasignacion(
          actual: modelo,
        ));
      }
    }
    return valor;
  }

  Future<int> asignarProductoMasivo({
    int cantidad = 0,
    required ModeloTangible modelo,
    required int idPdv,
    required String idVisita,
  }) async {
    int valor = -1;

    List<ProductoTangibleReasignacion> lstTangibleDet =
        await _dbService.getTangibleReasignacion(
      modelo: modelo.modelo,
      tangible: modelo.tangible,
      asignar: true,
    );

    lstTangibleDet.sort(
      (a, b) {
        return (DateFormat('yyyyMMdd').format(a.fechaAsignacion!) + a.serie!)
            .compareTo(
                DateFormat('yyyyMMdd').format(b.fechaAsignacion!) + b.serie!);
      },
    );

    if (lstTangibleDet.isEmpty) {
      valor = -1;
    } else {
      final List<ProductoTangibleReasignacion> filtrado = lstTangibleDet.isEmpty
          ? []
          : lstTangibleDet
              .where((element) => (element.asignado == 0) //||
                  //(element.asignado == 1 && element.confirmado==0 && element.idPdv==idPdv)
                  )
              .toList()
              .take(cantidad)
              .toList();

      for (var tangibleDet in filtrado) {
        valor = tangibleDet.asignado == 1 ? 0 : 1;

        tangibleDet = tangibleDet.copyWith(
          asignado: tangibleDet.asignado == 1 ? 0 : 1,
          idPdv: tangibleDet.asignado == 1 ? null : idPdv,
          idVisita: tangibleDet.asignado == 1 ? null : idVisita,
          fechaVenta: tangibleDet.asignado == 1 ? null : DateTime.now(),
        );

        await _dbService.updateTangibleReasignacion(tangibleDet);

        var sum = tangibleDet.asignado == 1 ? 1 : -1;

        var modeloNuevo = modelo.copyWith(
          asignado: modelo.asignado + sum,
        );

        await _dbService.updateModeloTangible(modeloNuevo);
        add(OnChangeSerieActualReasignacion(actual: tangibleDet));
        add(OnChangeModeloActualReasignacion(
          actual: modelo,
        ));
      }
    }
    return valor;
  }

  Future<int> desasignarProductoMasivo({
    int cantidad = 0,
    required ModeloTangible modelo,
    required int idPdv,
    required String idVisita,
  }) async {
    int valor = -1;

    List<ProductoTangibleReasignacion> lstTangibleDet =
        await _dbService.getTangibleReasignacion(
      modelo: modelo.modelo,
      tangible: modelo.tangible,
      asignar: false,
    );

    lstTangibleDet.sort(
      (a, b) {
        return (DateFormat('yyyyMMdd').format(b.fechaAsignacion!) + b.serie!)
            .compareTo(
                DateFormat('yyyyMMdd').format(a.fechaAsignacion!) + a.serie!);
      },
    );

    if (lstTangibleDet.isEmpty) {
      valor = -1;
    } else {
      final List<ProductoTangibleReasignacion> filtrado = lstTangibleDet.isEmpty
          ? []
          : lstTangibleDet
              .where((element) => (element.asignado == 1) //||
                  //(element.asignado == 1 && element.confirmado==0 && element.idPdv==idPdv)
                  )
              .toList()
              .take(cantidad)
              .toList();

      for (var tangibleDet in filtrado) {
        valor = tangibleDet.asignado == 1 ? 0 : 1;

        tangibleDet = tangibleDet.copyWith(
          asignado: tangibleDet.asignado == 1 ? 0 : 1,
          idPdv: tangibleDet.asignado == 1 ? null : idPdv,
          idVisita: tangibleDet.asignado == 1 ? null : idVisita,
          fechaVenta: tangibleDet.asignado == 1 ? null : DateTime.now(),
        );

        await _dbService.updateTangibleReasignacion(tangibleDet);

        var sum = tangibleDet.asignado == 1 ? 1 : -1;

        var modeloNuevo = modelo.copyWith(
          asignado: modelo.asignado + sum,
        );

        await _dbService.updateModeloTangible(modeloNuevo);
        add(OnChangeSerieActualReasignacion(actual: tangibleDet));
        add(OnChangeModeloActualReasignacion(
          actual: modelo,
        ));
      }
    }
    return valor;
  }

  Future<int> desAsignarProducto({
    String? serie,
    required ModeloTangible modelo,
    required int idPdv,
    required String idVisita,
  }) async {
    int valor = -1;

    List<ProductoTangibleReasignacion> lstTangibleDet =
        await _dbService.getTangibleReasignacion(
      serie: serie,
      modelo: modelo.modelo,
      tangible: modelo.tangible,
      asignar: false,
    );

    lstTangibleDet.sort(
      (a, b) {
        return (DateFormat('yyyyMMdd').format(b.fechaAsignacion!) + b.serie!)
            .compareTo(
                DateFormat('yyyyMMdd').format(a.fechaAsignacion!) + a.serie!);
      },
    );

    if (lstTangibleDet.isEmpty) {
      valor = -1;
    } else {
      ProductoTangibleReasignacion? tangibleDet;

      if (serie != null) {
        tangibleDet = lstTangibleDet.first;
      } else {
        tangibleDet = lstTangibleDet.isEmpty ? null : lstTangibleDet.first;
      }

      if (tangibleDet != null) {
        valor = tangibleDet.asignado == 1 ? 0 : 1;

        tangibleDet = tangibleDet.copyWith(
          asignado: tangibleDet.asignado == 1 ? 0 : 1,
          idPdv: tangibleDet.asignado == 1 ? null : idPdv,
          idVisita: tangibleDet.asignado == 1 ? null : idVisita,
        );

        await _dbService.updateTangibleReasignacion(tangibleDet);

        await _dbService.updateModeloTangible(modelo);
      }
    }
    return valor;
  }

  Future<void> validarBlister({
    required Planning pdv,
    required List<ModeloTangible> modelos,
  }) async {
    bool validado = true;
    List<String> asignados = [];
    add(
      OnUpdateBlisterReasignacionEvent(
        blisterValidado: validado,
        mensaje: 'Validando PDV',
        validandoBlister: true,
      ),
    );

    print("Servicios asignados");
    print(pdv.servicios);
    print(modelos.length);
    for (var e in modelos) {
      asignados.add(e.tangible.toString().toUpperCase());
    }

    print("asignados");
    print(asignados.toString());

    if (asignados.contains('BLISTER') &&
        !pdv.servicios.toString().toUpperCase().contains('BLISTER')) {
      validado = false;
    }

    final solicitudes = await _dbService.leerListadoSolicitudes(
      pdv.idPdv.toString(),
      'SOLICITUD AUTOMATICA DE SERVICIO BLISTER',
    );

    if (solicitudes.isNotEmpty) {
      validado = true;
    }

    add(
      OnUpdateBlisterReasignacionEvent(
        blisterValidado: validado,
        mensaje: 'Blister validado',
        validandoBlister: false,
      ),
    );
  }

  Future<void> enviarAlarmaBlister({
    required Planning pdv,
    required String usuario,
  }) async {
    bool validado = true;
    List<String> asignados = [];
    bool almacenado = false;

    add(
      OnUpdateBlisterReasignacionEvent(
        blisterValidado: validado,
        mensaje: 'Enviando alarma de Blister.',
        validandoBlister: true,
      ),
    );

    try {
      SolicitudAutomatica solicitud = SolicitudAutomatica(
        fecha: DateTime.now(),
        usuario: usuario,
        idPdv: pdv.idPdv.toString(),
        tipo: 'SOLICITUD AUTOMATICA DE SERVICIO BLISTER',
        enviado: 0,
      );

      final guardado = await _dbService.insertarSolicitudAutomatica(solicitud);

      solicitud = solicitud.copyWith(
        id: guardado,
      );

      almacenado = true;

      final body = {
        "idPdv": solicitud.idPdv,
        "usuario": solicitud.usuario,
        "tipo": solicitud.tipo,
        "fecha": DateFormat('yyyy-MM-dd HH:mm:ss').format(solicitud.fecha!),
      };

      final token = await _authService.getToken();

      final resp = await http
          .post(
            Uri.parse('${Environment.apiURL}/appmiventa/altablister'),
            body: jsonEncode(body),
            headers: {
              'Content-Type': 'application/json',
              'token': token,
            },
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(
            minutes: 1,
          ));

      if (resp.statusCode == 200) {
        await _dbService.updateSolicitudAutomatica(
          solicitud.copyWith(enviado: 1),
        );
      }
      validado = true;
    } catch (_) {
      validado = almacenado;
    }

    add(
      OnUpdateBlisterReasignacionEvent(
        blisterValidado: validado,
        mensaje: 'Blister validado',
        validandoBlister: false,
      ),
    );
  }

  Future<void> enviarDatosAlarmasBlister() async {
    print(":::::::Hola:::::");
    try {
      final solicitudes = await _dbService.leerSolicitudesAutomaticas();
      final token = await _authService.getToken();

      print("LSITA D ESOLICITUDES PENDIENTES");

      print(solicitudes.length);

      for (var solicitud in solicitudes) {
        final body = {
          "idPdv": solicitud.idPdv,
          "usuario": solicitud.usuario,
          "tipo": solicitud.tipo,
          "fecha": DateFormat('yyyy-MM-dd HH:mm:ss').format(solicitud.fecha!),
        };

        final resp = await http
            .post(
              Uri.parse('${Environment.apiURL}/appmiventa/altablister'),
              body: jsonEncode(body),
              headers: {
                'Content-Type': 'application/json',
                'token': token,
              },
              encoding: Encoding.getByName('utf-8'),
            )
            .timeout(const Duration(
              minutes: 1,
            ));

        if (resp.statusCode == 200) {
          await _dbService.updateSolicitudAutomatica(
            solicitud.copyWith(
              enviado: 1,
            ),
          );
        }
      }
    } catch (_) {}
  }
}