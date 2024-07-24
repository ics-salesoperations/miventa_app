import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:miventa_app/global/environment.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/image_file.dart';

part 'visita_event.dart';
part 'visita_state.dart';

class VisitaBloc extends Bloc<VisitaEvent, VisitaState> {
  final DBService _dbService = DBService();
  FormGroup? formGroup;

  VisitaBloc() : super(const VisitaState()) {
    on<OnIniciarVisitaEvent>((event, emit) {
      emit(
        state.copyWith(
          frmControlVisita: event.frmControlVisita,
          formGroupVisita: event.formGroupVisita,
          frmVisitaListo: event.frmVisitaListo,
          errores: event.errores,
        ),
      );
    });
    on<OnFinalizarVisitaEvent>((event, emit) {
      emit(
        state.copyWith(
          guardado: event.guardado,
          enviado: event.enviado,
        ),
      );
    });
    on<OnGuardandoFormularioEvent>((event, emit) {
      emit(
        state.copyWith(
          guardandoFormulario: true,
        ),
      );
    });
    on<OnActualizarInformacionEvent>((event, emit) {
      emit(
        state.copyWith(
          formId: event.formId,
          fechaCreacion: event.fechaCreacion,
          instanceId: event.instanceId,
          respondentId: event.respondentId,
        ),
      );
    });
    on<OnActualizarIdVisitaEvent>((event, emit) {
      emit(
        state.copyWith(
          idVisita: event.idVisita,
          idPdv: event.idPdv,
        ),
      );
    });
  }

  Future<void> iniciarVisita(
    Planning pdv,
    String idForm,
    String usuario,
  ) async {
    add(
      const OnIniciarVisitaEvent(
        visitaIniciada: false,
        frmControlVisita: [],
        frmVisitaListo: false,
        errores: [],
      ),
    );

    List<String> errores = [];
    final localizacionHabilitada = await _checkGpsStatus();
    final position = await Geolocator.getCurrentPosition();

    if (localizacionHabilitada == 'Deshabilitado') {
      errores.add("Tienes la localización deshabilitada.");
    }

    final tipoDatos = await _checkDataStatus();
    String esRuta = await validarRuta(pdv);

    if (esRuta == 'NO') {
      errores.add("Visitarás un Punto de Venta que no esta en tu ruta de hoy.");
    }

    final distancia = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      pdv.latitude!,
      pdv.longitude!,
    );

    if (distancia >= 100) {
      errores.add("No estas en el Punto de Venta.");
    }

    final sinConfirmar = await _dbService.getPendienteConfirmar(
      idPdv: pdv.idPdv.toString(),
    );

    for (var element in sinConfirmar) {
      errores.add(
          "Tienes ${element['cantidad']} productos sin confirmar en el IDPDV:  ${element['idPdv']}");
    }

    try {
      final formulario = await _dbService.leerFormulario(
        idForm: idForm,
      );
      //creamos el formGroup
      final formGroup = await createCurrentFormGroup(
        formulario: formulario,
        pdv: pdv,
        usuario: usuario,
        position: position,
        esRuta: esRuta,
        localizacionHabilitada: localizacionHabilitada,
        tipoDatos: tipoDatos,
        aplicaRevision: errores.isEmpty ? "NO" : "SI",
      );

      //Agregamos el evento para el BLOC
      add(
        OnIniciarVisitaEvent(
          visitaIniciada: true,
          frmControlVisita: formulario,
          formGroupVisita: formGroup,
          frmVisitaListo: true,
          errores: errores,
        ),
      );
    } catch (e) {
      add(
        const OnIniciarVisitaEvent(
          visitaIniciada: false,
          frmControlVisita: [],
          frmVisitaListo: false,
          errores: [],
        ),
      );
    }
  }

  Future<String> validarRuta(Planning pdv) async {
    String esRuta = "NO";
    final datos = await _dbService.leerDetallePdv(pdv.idPdv ?? 0);
    final fechaActual = DateTime.now();
    for (var d in datos) {
      if (d.fecha != null) {
        if (DateFormat('ddMMyyyy').format(d.fecha!) ==
            DateFormat('ddMMyyyy').format(fechaActual)) {
          esRuta = "SI";
          return esRuta;
        }
      }
    }
    return esRuta;
  }

  Future<FormGroup> createCurrentFormGroup({
    required List<Formulario> formulario,
    required Planning pdv,
    required String usuario,
    required Position position,
    required String localizacionHabilitada,
    required String esRuta,
    required String tipoDatos,
    required String aplicaRevision,
  }) async {
    final jsonForm = pdv.toJson();

    Map<String, AbstractControl<dynamic>> elementos = {};
    Map<String, AbstractControl<dynamic>> elemento = {};

    final fecha = DateTime.now();

    final idVisita = usuario +
        ":" +
        DateFormat('ddMMyyyyHHmmss').format(fecha) +
        ":" +
        pdv.idPdv.toString();

    add(
      OnActualizarIdVisitaEvent(
        idVisita: idVisita,
        idPdv: pdv.idPdv ?? 0,
      ),
    );

    for (var campo in formulario) {
      List<Map<String, dynamic>? Function(AbstractControl<dynamic>)>
          validaciones = campo.required == 'Y' ? [Validators.required] : [];

      switch (campo.shortText.toString().toUpperCase()) {
        case "IDVISITA":
          {
            elemento = <String, AbstractControl<dynamic>>{
              "${campo.questionText}": FormControl<String>(
                value: idVisita,
                validators: validaciones,
              )
            };
          }
          break;
        case "IDPDV":
          {
            elemento = <String, AbstractControl<dynamic>>{
              "${campo.questionText}": FormControl<String>(
                value: jsonForm['${campo.shortText}'].toString(),
                validators: validaciones,
              )
            };
          }
          break;
        case "LOCALIZACION":
          {
            elemento = <String, AbstractControl<dynamic>>{
              "${campo.questionText}": FormControl<String>(
                  validators: validaciones,
                  value: '${position.latitude}, ${position.longitude}')
            };
          }
          break;
        case "LOCALIZACIONHABILITADA":
          {
            elemento = <String, AbstractControl<dynamic>>{
              "${campo.questionText}": FormControl<String>(
                value: localizacionHabilitada,
                validators: validaciones,
              )
            };
          }
          break;
        case "TIPODATOS":
          {
            elemento = <String, AbstractControl<dynamic>>{
              "${campo.questionText}": FormControl<String>(
                value: tipoDatos,
                disabled: true,
                validators: validaciones,
              )
            };
          }
          break;
        case "USUARIO":
          {
            elemento = <String, AbstractControl<dynamic>>{
              "${campo.questionText}": FormControl<String>(
                value: usuario,
                validators: validaciones,
              )
            };
          }
          break;
        case "ESRUTA":
          {
            elemento = <String, AbstractControl<dynamic>>{
              "${campo.questionText}": FormControl<String>(
                value: esRuta,
                validators: validaciones,
              )
            };
          }
          break;
        case "APLICAREVISION":
          {
            elemento = <String, AbstractControl<dynamic>>{
              "${campo.questionText}": FormControl<String>(
                value: aplicaRevision,
                validators: validaciones,
              )
            };
          }
          break;
        case "INICIO":
          {
            elemento = <String, AbstractControl<dynamic>>{
              "${campo.questionText}": FormControl<String>(
                value: DateFormat('yyyyMMdd:HHmmss').format(fecha),
                validators: validaciones,
              )
            };
          }
          break;
        case "FIN":
          {
            elemento = <String, AbstractControl<dynamic>>{
              "${campo.questionText}": FormControl<String>(
                //value: aplicaRevision,
                validators: validaciones,
              )
            };
          }
          break;
      }
      elementos.addEntries(elemento.entries);
    }

    formGroup = FormGroup(elementos);

    await guardarFormulario(formulario, formGroup!);
    Visita visit = Visita(
      enviado: "NO",
      fechaInicioVisita: fecha,
      idPDV: pdv.idPdv,
      idVisita: idVisita,
      latitud: position.latitude,
      longitud: position.longitude,
      usuario: usuario,
    );

    await _dbService.guardarVisita(visit);

    return formGroup!;
  }

  Future<String> _checkGpsStatus() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();

    if (isEnabled) {
      return 'Habilitado';
    }

    if (!isEnabled) {
      return 'Deshabilitado';
    }

    return 'Error';
  }

  Future<String> _checkDataStatus() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.mobile) {
        return "Mobile";
      }

      if (connectivityResult == ConnectivityResult.wifi) {
        return "Wifi";
      }
    } catch (e) {
      return "No Identificado";
    }

    return "No Habilitado";
  }

  Future<void> guardarFormulario(
    List<Formulario> estructura,
    FormGroup frm,
  ) async {
    add(
      const OnFinalizarVisitaEvent(
        enviado: false,
        guardado: false,
      ),
    );

    UsuarioService _usuarioService = UsuarioService();

    List<FormularioAnswer> respuestas = [];

    final usuario = await _usuarioService.getInfoUsuario();
    final currentDate = DateTime.now();
    final formated = DateFormat('yyyyMMdd:HHmmss').format(currentDate);
    final dato2 = DateFormat('yyyyMMddHHmmss').format(currentDate);

    final instanceId = dato2 + usuario.usuario.toString();

    int formId = -1;
    String idVisita = "";

    for (var campo in estructura) {
      FormularioAnswer resp = FormularioAnswer(
        instanceId: instanceId + campo.formId.toString(),
        formId: campo.formId,
        respondentId: usuario.usuario,
        fechaCreacion: formated,
        questionId: campo.questionId,
        enviado: "NO",
      );

      formId = campo.formId!;
      if (campo.shortText.toString() == "idVisita") {
        idVisita = frm.controls["${campo.questionText}"]!.value.toString();
      }

      switch (campo.questionType) {
        case 'Abierta Texto':
        case 'Abierta Numerica':
        case 'Seleccion Unica':
        case 'Fecha':
        case 'Abierta Texto Multilinea':
        case 'Localizacion':
          resp = resp.copyWith(
            response: frm.controls["${campo.questionText}"]!.value.toString(),
          );
          break;
        case 'Seleccion Multiple':
          final respuesta =
              (frm.controls["${campo.questionText}"]!.value as List);
          final respuestaMap = (respuesta[0] as Map);

          final resultado = <String>[];

          for (var i = 0; i < respuestaMap.keys.length; i++) {
            if (respuestaMap[respuestaMap.keys.elementAt(i)] == true) {
              resultado.add(respuestaMap.keys.elementAt(i));
            }
          }

          resp = resp.copyWith(
            response: resultado.join(","),
          );
          break;
        case 'Fotografia':
          {
            if (frm.controls["${campo.questionText}"]!.value != null) {
              final imageFile = File(
                  (frm.controls["${campo.questionText}"]!.value as ImageFile)
                      .image!
                      .path);

              Uint8List imagebytes =
                  await imageFile.readAsBytes(); //convert to bytes
              final imagen = base64.encode(imagebytes);

              resp = resp.copyWith(
                response: imagen,
              );
            }
          }
          break;
        default:
          {}
      }
      if (resp.response != null &&
          resp.response != '' &&
          resp.response != 'null') {
        respuestas.add(resp);
      }
    }

    await _dbService.guardarRespuestaFormulario(respuestas);

    add(OnActualizarInformacionEvent(
      formId: formId,
      instanceId: instanceId + formId.toString(),
      fechaCreacion: formated,
      respondentId: usuario.usuario.toString(),
      idVisita: idVisita,
    ));

    add(
      const OnFinalizarVisitaEvent(
        enviado: false,
        guardado: true,
      ),
    );
  }

  Future<void> enviarDatos({
    required int formId,
    required String instanceId,
    required String fechaCreacion,
    required String respondentId,
    required Planning pdv,
  }) async {
    add(
      const OnFinalizarVisitaEvent(
        enviado: false,
        guardado: true,
      ),
    );

    final currentDate = DateTime.now();
    final formated = DateFormat('yyyyMMdd:HHmmss').format(currentDate);

    FormularioAnswer resp = FormularioAnswer(
      instanceId: instanceId,
      formId: formId,
      respondentId: respondentId,
      fechaCreacion: fechaCreacion,
      questionId: 279,
      enviado: "NO",
      response: formated,
    );

    await _dbService.guardarRespuestaFormulario([resp]);
    await _dbService.actualizarPdvPlanning(
      pdv.copyWith(
        visitado: "SI",
        fechaVisita: currentDate,
      ),
    );

    final respuestas = await _dbService.leerRespuestaFormulario(
      instanceId: instanceId,
    );

    List<Map<String, dynamic>> datos = [];

    for (var info in respuestas) {
      final data = {
        'APP_ID': '300',
        'RESPONDENT_ID': info.respondentId,
        'FORM_ID': info.formId,
        'QUESTION_ID': info.questionId,
        'RESPONSE': info.response,
        'FECHA_CREACION': info.fechaCreacion,
      };

      datos.add(data);
    }

    try {
      final body = {"data": datos};

      final resp = await http
          .post(
            Uri.parse('${Environment.apiURL}/appdms/newform_json'),
            body: body,
            headers: {'Content-Type': 'application/json'},
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(minutes: 5));

      if (resp.statusCode == 200) {
        await _dbService.updateEnviados(
          respuestas,
        );

        add(
          const OnFinalizarVisitaEvent(
            enviado: true,
            guardado: true,
          ),
        );
      } else {
        add(
          const OnFinalizarVisitaEvent(
            enviado: false,
            guardado: true,
          ),
        );
        return;
      }
    } on TimeoutException catch (_) {
      add(
        const OnFinalizarVisitaEvent(
          enviado: false,
          guardado: true,
        ),
      );
      return;
    } catch (e) {
      add(
        const OnFinalizarVisitaEvent(
          enviado: false,
          guardado: true,
        ),
      );
      return;
    }
  }
}
