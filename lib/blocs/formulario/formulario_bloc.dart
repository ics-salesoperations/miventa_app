import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:miventa_app/global/environment.dart';
import 'package:miventa_app/models/form_response.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/services.dart';
import 'package:miventa_app/widgets/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/image_file.dart';

part 'formulario_event.dart';
part 'formulario_state.dart';

class FormularioBloc extends Bloc<FormularioEvent, FormularioState> {
  final DBService _dbService = DBService();
  final AuthService _authService = AuthService();
  FormGroup? formGroup;

  FormularioBloc() : super(const FormularioState()) {
    on<OnActualizarFormsEvent>((event, emit) {
      emit(
        state.copyWith(
          formsActualizados: event.formsActualizados,
          formularios: event.formularios,
        ),
      );
    });
    on<OnCargarFormsEvent>((event, emit) {
      emit(
        state.copyWith(
          formularios: event.formularios,
          lstFormVisita: event.lstFormVisita,
          lstFormgroupVisita: event.lstFormgroupVisita,
          isFrmVisitaListo: event.isFrmVisitaListo,
        ),
      );
    });
    on<OnChangeBetweenForms>((event, emit) {
      emit(
        state.copyWith(
          frmActualVisita: event.frmActualVisita,
        ),
      );
    });
    on<OnCurrentFormReadyEvent>((event, emit) {
      emit(
        state.copyWith(
          currentForm: event.currentForm,
          isCurrentFormListo: event.isCurrentFormReady,
          currentFormgroup: event.formGroup,
        ),
      );
    });
    on<OnProcessingEvent>((event, emit) {
      emit(state.copyWith(
        mensaje: event.mensaje,
        procesado: event.procesado,
        sinProcesar: event.sinProcesar,
        guardado: event.guardado,
        enviado: event.enviado,
      ));
    });
    on<OnCurrentFormSaving>(guardarFormulario);
    on<OnUpdateFormsEvent>((event, emit) {
      emit(
        state.copyWith(
          formularios: event.formularios,
        ),
      );
    });
  }

  Future<void> init() async {
    final updateFormularios = await actualizarForms();
    final forms = await getFormulariosVisita();

    //Agregamos el evento para el BLOC
    add(
      OnActualizarFormsEvent(
        formsActualizados: updateFormularios,
        formularios: forms,
      ),
    );
  }

  Future<void> actualizarFormsModificacion(String idForm) async {
    final forms = await getFormulariosModificacion(
      formId: idForm,
    );

    //Agregamos el evento para el BLOC
    add(
      OnActualizarFormsEvent(
        formsActualizados: true,
        formularios: forms,
      ),
    );
  }

  Future<void> cargarFormsEncuestas({
    required Planning pdv,
  }) async {
    //Agregamos el evento para el BLOC
    add(
      const OnCargarFormsEvent(
        formularios: <FormularioResumen>[],
        lstFormgroupVisita: <FormGroup>[],
        lstFormVisita: [],
        isFrmVisitaListo: false,
      ),
    );
    final formsResumen = await getFormulariosEncuesta(
      aditionalFilter: " WHERE response = '" + pdv.idPdv.toString() + "'",
      segmento: pdv.segmentoPdv.toString(),
    );

    final formsDetalle = await getDetalleFormulariosVisita(
      resumen: formsResumen,
    );
    final frmsGroup = await getFormGroupsVisita(
      detalle: formsDetalle,
      pdv: pdv,
    );
    //Agregamos el evento para el BLOC
    add(
      OnCargarFormsEvent(
        formularios: formsResumen,
        lstFormgroupVisita: frmsGroup,
        lstFormVisita: formsDetalle,
        isFrmVisitaListo: true,
      ),
    );
  }

  Future<void> cargarFormsGeneral() async {
    //Agregamos el evento para el BLOC
    add(
      const OnCargarFormsEvent(
        formularios: <FormularioResumen>[],
        lstFormgroupVisita: <FormGroup>[],
        lstFormVisita: [],
        isFrmVisitaListo: false,
      ),
    );
    final formsResumen = await getFormulariosGeneral();

    final formsDetalle =
        await getDetalleFormulariosVisita(resumen: formsResumen);
    final frmsGroup = await getFormGroupsGeneral(
      detalle: formsDetalle,
    );
    //Agregamos el evento para el BLOC
    add(
      OnCargarFormsEvent(
        formularios: formsResumen,
        lstFormgroupVisita: frmsGroup,
        lstFormVisita: formsDetalle,
        isFrmVisitaListo: true,
      ),
    );
  }

  Future<bool> actualizarForms() async {
    try {
      final token = await _authService.getToken();
      final resp = await http.get(
        Uri.parse('${Environment.apiURL}/appdms/estructura_form/100'),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
        },
      );

      final formsResponse = formResponseFromMap(resp.body);

      //guardar en base de datos local
      await _dbService.crearFormularios(formsResponse.detalleFormulario);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Formulario>> getFormularios() async {
    try {
      final forms = await _dbService.leerListadoForms();
      return forms;
    } catch (e) {
      return <Formulario>[];
    }
  }

  Future<List<FormularioResumen>> getFormulariosModificacion({
    String? formId,
  }) async {
    try {
      final formsResumen = await _dbService.leerResumenForms(
        tipo: "MODIFICACION",
        formId: formId,
      );
      return formsResumen;
    } catch (e) {
      return <FormularioResumen>[];
    }
  }

  Future<List<FormularioResumen>> getFormulariosVisita() async {
    try {
      final formsResumen = await _dbService.leerResumenForms(tipo: "VISITA");
      return formsResumen;
    } catch (e) {
      return <FormularioResumen>[];
    }
  }

  Future<List<FormularioResumen>> getFormulariosEncuesta({
    String aditionalFilter = '',
    String segmento = '',
  }) async {
    try {
      final formsResumen = await _dbService.leerResumenForms(
        tipo: "ENCUESTA",
        adicionalFilter: aditionalFilter,
        segmento: segmento,
      );
      return formsResumen;
    } catch (e) {
      return <FormularioResumen>[];
    }
  }

  Future<List<FormularioResumen>> getFormulariosGeneral() async {
    try {
      final formsResumen = await _dbService.leerResumenForms(tipo: "GENERAL");
      return formsResumen;
    } catch (e) {
      return <FormularioResumen>[];
    }
  }

  Future<List<List<Formulario>>> getDetalleFormulariosVisita({
    required List<FormularioResumen> resumen,
  }) async {
    final respuesta = <List<Formulario>>[];
    try {
      for (var frm in resumen) {
        final formulario = await _dbService.leerFormulario(
          idForm: frm.formId.toString(),
        );
        respuesta.add(formulario);
      }

      return respuesta;
    } catch (e) {
      return respuesta;
    }
  }

  Future<List<FormGroup>> getFormGroupsVisita({
    required List<List<Formulario>> detalle,
    required Planning pdv,
  }) async {
    final respuesta = <FormGroup>[];
    try {
      for (var frm in detalle) {
        final formGroup = await createCurrentFormGroup(frm, pdv);
        respuesta.add(formGroup);
      }
      return respuesta;
    } catch (e) {
      return respuesta;
    }
  }

  Future<List<FormGroup>> getFormGroupsGeneral({
    required List<List<Formulario>> detalle,
  }) async {
    final respuesta = <FormGroup>[];
    try {
      for (var frm in detalle) {
        final formGroup = await createCurrentFormGroupGeneral(frm);
        respuesta.add(formGroup);
      }
      return respuesta;
    } catch (e) {
      return respuesta;
    }
  }

  Future<void> getFormulario(String idForm, Planning pdv) async {
    add(
      const OnCurrentFormReadyEvent(
        isCurrentFormReady: false,
        currentForm: [],
      ),
    );
    try {
      final formulario = await _dbService.leerFormulario(
        idForm: idForm,
      );
      //creamos el formGroup
      final formGroup = await createCurrentFormGroup(formulario, pdv);

      //Cambio de Direccion Supervisor
      if (idForm == '73' &&
          formGroup.controls.keys.contains('Coordenadas Nuevas')) {
        final position = await Geolocator.getCurrentPosition();

        formGroup.control('Coordenadas Nuevas').value =
            '${position.latitude},${position.longitude}';
      }

      //Cambio de Local
      if (idForm == '85') {
        if (formGroup.controls.keys.contains('Coordenadas Nuevas')) {
          final position = await Geolocator.getCurrentPosition();

          formGroup.control('Coordenadas Nuevas').value =
              '${position.latitude},${position.longitude}';
        }

        if (formGroup.controls.keys.contains('Categoria Nueva')) {
          formGroup.control('Categoria Nueva').value = pdv.categoria;
        }

        if (formGroup.controls.keys.contains('Circuito Nuevo')) {
          formGroup.control('Circuito Nuevo').value = pdv.nombreCircuito;
        }

        if (formGroup.controls.keys.contains('Dirección Nueva')) {
          formGroup.control('Dirección Nueva').value = pdv.direccion;
        }
      }

      //Agregamos el evento para el BLOC
      add(
        OnCurrentFormReadyEvent(
          isCurrentFormReady: true,
          currentForm: formulario,
          formGroup: formGroup,
        ),
      );
    } catch (e) {
      add(
        const OnCurrentFormReadyEvent(
          isCurrentFormReady: false,
          currentForm: [],
        ),
      );
    }
  }

  Future<void> getFormularioGeneral(String idForm) async {
    add(
      const OnCurrentFormReadyEvent(
        isCurrentFormReady: false,
        currentForm: [],
      ),
    );
    try {
      final formulario = await _dbService.leerFormulario(
        idForm: idForm,
      );
      //creamos el formGroup
      final formGroup = await createCurrentFormGroupGeneral(formulario);

      //Agregamos el evento para el BLOC
      add(
        OnCurrentFormReadyEvent(
          isCurrentFormReady: true,
          currentForm: formulario,
          formGroup: formGroup,
        ),
      );
    } catch (e) {
      add(
        const OnCurrentFormReadyEvent(
          isCurrentFormReady: false,
          currentForm: [],
        ),
      );
    }
  }

  Future<void> getFormularioEncuesta(String idForm, Planning pdv) async {
    add(
      const OnCurrentFormReadyEvent(
        isCurrentFormReady: false,
        currentForm: [],
      ),
    );
    try {
      final formulario = await _dbService.leerFormulario(
        idForm: idForm,
      );
      //creamos el formGroup
      final formGroup = await createCurrentFormGroup(formulario, pdv);

      //Agregamos el evento para el BLOC
      add(
        OnCurrentFormReadyEvent(
          isCurrentFormReady: true,
          currentForm: formulario,
          formGroup: formGroup,
        ),
      );
    } catch (e) {
      add(
        const OnCurrentFormReadyEvent(
          isCurrentFormReady: false,
          currentForm: [],
        ),
      );
    }
  }

  Future<FormGroup> createCurrentFormGroupGeneral(
      List<Formulario> formulario) async {
    Map<String, AbstractControl<dynamic>> elementos = {};
    Map<String, AbstractControl<dynamic>> elemento = {};
    for (var campo in formulario) {
      List<Map<String, dynamic>? Function(AbstractControl<dynamic>)>
          validaciones = campo.required == 'Y' ? [Validators.required] : [];

      switch (campo.auto) {
        case 1:
          {
            elemento = <String, AbstractControl<dynamic>>{
              "${campo.questionText}": FormControl<String>(
                value: 'No Soportado',
                disabled: true,
                validators: validaciones,
              )
            };
          }
          break;
        case 0:
          {
            if (campo.questionType == 'Seleccion Multiple') {
              var elementos = campo.offeredAnswer.toString().split(",");

              elementos.sort((a, b) {
                return a.toLowerCase().compareTo(b.toLowerCase());
              });

              final estructura = <String, AbstractControl<dynamic>>{};

              for (var elemento in elementos) {
                final valor = {elemento: FormControl<bool>(value: false)};
                estructura.addEntries(valor.entries);
              }

              elemento = <String, AbstractControl<dynamic>>{
                "${campo.questionText}": FormArray([
                  FormGroup(estructura),
                ]),
              };
            } else if (campo.questionType == 'Fotografia') {
              elemento = <String, AbstractControl<dynamic>>{
                "${campo.questionText}": FormControl<ImageFile>(
                  validators: validaciones,
                )
              };
            } else if (campo.questionType == 'Localizacion') {
              final position = await Geolocator.getCurrentPosition();
              final userService = UsuarioService();
              final usuario = await userService.getInfoUsuario();

              elemento = <String, AbstractControl<dynamic>>{
                "${campo.questionText}": FormControl<String>(
                    validators: validaciones,
                    disabled: [6, 5].contains(usuario.perfil) ? false : true,
                    value: '${position.latitude}, ${position.longitude}')
              };
            } else {
              elemento = <String, AbstractControl<dynamic>>{
                "${campo.questionText}": FormControl<String>(
                  validators: validaciones,
                )
              };
            }
          }
          break;
      }
      elementos.addEntries(elemento.entries);
    }

    formGroup = FormGroup(elementos);

    return formGroup!;
  }

  Future<FormGroup> createCurrentFormGroup(
      List<Formulario> formulario, Planning pdv) async {
    final jsonForm = pdv.toJson();

    Map<String, AbstractControl<dynamic>> elementos = {};
    Map<String, AbstractControl<dynamic>> elemento = {};
    for (var campo in formulario) {
      List<Map<String, dynamic>? Function(AbstractControl<dynamic>)>
          validaciones = campo.required == 'Y' ? [Validators.required] : [];

      switch (campo.auto) {
        case 1:
          {
            if (campo.questionType == 'Seleccion Multiple') {
              var elementos = campo.offeredAnswer.toString().split(",");

              elementos.sort((a, b) {
                return a.toLowerCase().compareTo(b.toLowerCase());
              });

              final estructura = <String, AbstractControl<dynamic>>{};

              for (var elemento in elementos) {
                final valor = {
                  elemento: FormControl<bool>(
                    value: jsonForm['${campo.shortText}']
                            .toString()
                            .contains(elemento)
                        ? true
                        : false,
                    disabled: true,
                  )
                };
                estructura.addEntries(valor.entries);
              }

              elemento = <String, AbstractControl<dynamic>>{
                "${campo.questionText}": FormArray([
                  FormGroup(estructura),
                ]),
              };
            } else {
              elemento = <String, AbstractControl<dynamic>>{
                "${campo.questionText}": FormControl<String>(
                  value: jsonForm['${campo.shortText}'].toString(),
                  disabled: (campo.formId == 19 &&
                          (campo.questionId == 253 ||
                              campo.questionId == 257 ||
                              campo.questionId == 258))
                      ? false
                      : true,
                  validators: validaciones,
                )
              };
            }
          }
          break;
        case 0:
          {
            if (campo.questionType == 'Seleccion Multiple') {
              var elementos = campo.offeredAnswer.toString().split(",");

              elementos.sort((a, b) {
                return a.toLowerCase().compareTo(b.toLowerCase());
              });

              final estructura = <String, AbstractControl<dynamic>>{};

              for (var elemento in elementos) {
                final valor = {elemento: FormControl<bool>(value: false)};
                estructura.addEntries(valor.entries);
              }

              elemento = <String, AbstractControl<dynamic>>{
                "${campo.questionText}": FormArray([
                  FormGroup(estructura),
                ]),
              };
            } else if (campo.questionType == 'Fotografia') {
              elemento = <String, AbstractControl<dynamic>>{
                "${campo.questionText}": FormControl<ImageFile>(
                  validators: validaciones,
                )
              };
            } else if (campo.questionType == 'Localizacion') {
              final position = await Geolocator.getCurrentPosition();

              elemento = <String, AbstractControl<dynamic>>{
                "${campo.questionText}": FormControl<String>(
                    validators: validaciones,
                    disabled: true,
                    value: '${position.latitude}, ${position.longitude}')
              };
            } else {
              elemento = <String, AbstractControl<dynamic>>{
                "${campo.questionText}": FormControl<String>(
                  validators: validaciones,
                )
              };
            }
          }
          break;
      }
      elementos.addEntries(elemento.entries);
    }

    formGroup = FormGroup(elementos);

    return formGroup!;
  }

  List<Widget> contruirCampos(List<Formulario> form) {
    List<Widget> campos = <Widget>[];

    const espacio = SizedBox(
      height: 10,
    );

    for (var campo in form) {
      var preguntasPadre = campo.parentQuestion.toString().split("|");
      var respuestasPadre = campo.parentAnswer.toString().split("|");

      switch (campo.questionType) {
        case 'Abierta Texto':
          if (campo.conditional == 1) {
            final padre = form.map((elemento) {
              if (preguntasPadre[0].contains(
                elemento.questionId.toString(),
              )) {
                return elemento.questionText.toString();
              }
            }).toList();

            final filtrado = padre.where((e) => e != null).toList();

            campos.add(ReactiveValueListenableBuilder<String>(
              formControlName: filtrado[0],
              builder: (context, control, child) {
                if (respuestasPadre[0].contains(control.value.toString())) {
                  if (preguntasPadre.length >= 2) {
                    final padre2 = form.map((elemento) {
                      if (preguntasPadre[1]
                          .contains(elemento.questionId.toString())) {
                        return elemento.questionText.toString();
                      }
                    }).toList();

                    final filtrado2 = padre2.where((e) => e != null).toList();

                    return ReactiveValueListenableBuilder(
                      formControlName: filtrado2[0],
                      builder: (context, control, child) {
                        if (respuestasPadre[1]
                            .contains(control.value.toString())) {
                          return Column(
                            children: [
                              SOTextField(
                                campo: campo,
                              ),
                              espacio,
                            ],
                          );
                        }
                        return Container();
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        SOTextField(
                          campo: campo,
                        ),
                        espacio,
                      ],
                    );
                  }

                  //campos.add(espacio);
                }
                return Container();
              },
            ));
          } else {
            campos.add(
              SOTextField(campo: campo),
            );
            campos.add(espacio);
          }
          break;
        case 'Abierta Numerica':
          if (campo.conditional == 1) {
            final padre = form.map((elemento) {
              if (preguntasPadre[0].contains(elemento.questionId.toString())) {
                return elemento.questionText.toString();
              }
            }).toList();

            final filtrado = padre.where((e) => e != null).toList();

            campos.add(ReactiveValueListenableBuilder<String>(
              formControlName: filtrado[0],
              builder: (context, control, child) {
                if (respuestasPadre[0].contains(control.value.toString())) {
                  if (preguntasPadre.length >= 2) {
                    final padre2 = form.map((elemento) {
                      if (preguntasPadre[1]
                          .contains(elemento.questionId.toString())) {
                        return elemento.questionText.toString();
                      }
                    }).toList();

                    final filtrado2 = padre2.where((e) => e != null).toList();

                    return ReactiveValueListenableBuilder(
                      formControlName: filtrado2[0],
                      builder: (context, control, child) {
                        if (respuestasPadre[1]
                            .contains(control.value.toString())) {
                          return Column(
                            children: [
                              SONumberField(
                                campo: campo,
                              ),
                              espacio,
                            ],
                          );
                        }
                        return Container();
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        SONumberField(
                          campo: campo,
                        ),
                        espacio,
                      ],
                    );
                  }

                  //campos.add(espacio);
                }
                return Container();
              },
            ));
          } else {
            campos.add(
              SONumberField(campo: campo),
            );
            campos.add(espacio);
          }
          break;
        case 'Seleccion Unica':
          if (campo.conditional == 1) {
            final padre = form.map((elemento) {
              if (preguntasPadre[0].contains(elemento.questionId.toString())) {
                return elemento.questionText.toString();
              }
            }).toList();

            final filtrado = padre.where((e) => e != null).toList();

            campos.add(ReactiveValueListenableBuilder<String>(
              formControlName: filtrado[0],
              builder: (context, control, child) {
                if (respuestasPadre[0].contains(control.value.toString())) {
                  if (preguntasPadre.length >= 2) {
                    final padre2 = form.map((elemento) {
                      if (preguntasPadre[1]
                          .contains(elemento.questionId.toString())) {
                        return elemento.questionText.toString();
                      }
                    }).toList();

                    final filtrado2 = padre2.where((e) => e != null).toList();

                    return ReactiveValueListenableBuilder(
                      formControlName: filtrado2[0],
                      builder: (context, control, child) {
                        if (respuestasPadre[1]
                            .contains(control.value.toString())) {
                          return Column(
                            children: [
                              SOSeleccionUnicaField(
                                campo: campo,
                              ),
                              espacio
                            ],
                          );
                        }
                        return Container();
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        SOSeleccionUnicaField(
                          campo: campo,
                        ),
                        espacio
                      ],
                    );
                  }

                  //campos.add(espacio);
                }
                return Container();
              },
            ));
          } else {
            campos.add(
              SOSeleccionUnicaField(campo: campo),
            );
            campos.add(espacio);
          }
          break;
        case 'Seleccion Multiple':
          if (campo.conditional == 1) {
            final padre = form.map((elemento) {
              if (preguntasPadre[0].contains(elemento.questionId.toString())) {
                return elemento.questionText.toString();
              }
            }).toList();

            final filtrado = padre.where((e) => e != null).toList();

            campos.add(ReactiveValueListenableBuilder<String>(
              formControlName: filtrado[0],
              builder: (context, control, child) {
                if (respuestasPadre[0].contains(control.value.toString())) {
                  if (preguntasPadre.length >= 2) {
                    final padre2 = form.map((elemento) {
                      if (preguntasPadre[1]
                          .contains(elemento.questionId.toString())) {
                        return elemento.questionText.toString();
                      }
                    }).toList();

                    final filtrado2 = padre2.where((e) => e != null).toList();

                    return ReactiveValueListenableBuilder(
                      formControlName: filtrado2[0],
                      builder: (context, control, child) {
                        if (respuestasPadre[1]
                            .contains(control.value.toString())) {
                          return Column(
                            children: [
                              SOSeleccionMultipleField(
                                campo: campo,
                                formGroup: formGroup!,
                              ),
                              espacio,
                            ],
                          );
                        }
                        return Container();
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        SOSeleccionMultipleField(
                          campo: campo,
                          formGroup: formGroup!,
                        ),
                        espacio,
                      ],
                    );
                  }
                  //campos.add(espacio);
                }
                return Container();
              },
            ));
          } else {
            campos.add(
              SOSeleccionMultipleField(campo: campo, formGroup: formGroup!),
            );
            campos.add(espacio);
          }
          break;
        case 'Abierta Texto Multilinea':
          if (campo.conditional == 1) {
            final padre = form.map((elemento) {
              if (preguntasPadre[0].contains(elemento.questionId.toString())) {
                return elemento.questionText.toString();
              }
            }).toList();

            final filtrado = padre.where((e) => e != null).toList();

            campos.add(ReactiveValueListenableBuilder<String>(
              formControlName: filtrado[0],
              builder: (context, control, child) {
                if (respuestasPadre[0].contains(control.value.toString())) {
                  if (preguntasPadre.length >= 2) {
                    final padre2 = form.map((elemento) {
                      if (preguntasPadre[1]
                          .contains(elemento.questionId.toString())) {
                        return elemento.questionText.toString();
                      }
                    }).toList();

                    final filtrado2 = padre2.where((e) => e != null).toList();

                    return ReactiveValueListenableBuilder(
                      formControlName: filtrado2[0],
                      builder: (context, control, child) {
                        if (respuestasPadre[1]
                            .contains(control.value.toString())) {
                          return Column(
                            children: [
                              SOTextFieldMultilineField(
                                campo: campo,
                              ),
                              espacio,
                            ],
                          );
                        }
                        return Container();
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        SOTextFieldMultilineField(
                          campo: campo,
                        ),
                        espacio,
                      ],
                    );
                  }

                  //campos.add(espacio);
                }
                return Container();
              },
            ));
          } else {
            campos.add(
              SOTextFieldMultilineField(campo: campo),
            );
            campos.add(espacio);
          }
          break;
        case 'Fotografia':
          if (campo.conditional == 1) {
            final padre = form.map((elemento) {
              if (preguntasPadre[0].contains(elemento.questionId.toString())) {
                return elemento.questionText.toString();
              }
            }).toList();

            final filtrado = padre.where((e) => e != null).toList();

            campos.add(ReactiveValueListenableBuilder<String>(
              formControlName: filtrado[0],
              builder: (context, control, child) {
                if (respuestasPadre[0].contains(control.value.toString())) {
                  if (preguntasPadre.length >= 2) {
                    final padre2 = form.map((elemento) {
                      if (preguntasPadre[1]
                          .contains(elemento.questionId.toString())) {
                        return elemento.questionText.toString();
                      }
                    }).toList();

                    final filtrado2 = padre2.where((e) => e != null).toList();

                    return ReactiveValueListenableBuilder(
                      formControlName: filtrado2[0],
                      builder: (context, control, child) {
                        if (respuestasPadre[1]
                            .contains(control.value.toString())) {
                          return Column(
                            children: [
                              SOPhotoField(
                                campo: campo,
                              ),
                              espacio,
                            ],
                          );
                        }
                        return Container();
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        SOPhotoField(
                          campo: campo,
                        ),
                        espacio,
                      ],
                    );
                  }

                  //campos.add(espacio);
                }
                return Container();
              },
            ));
          } else {
            campos.add(
              SOPhotoField(campo: campo),
            );
            campos.add(espacio);
          }
          break;
        default:
          {
            if (campo.conditional == 1) {
              final padre = form.map((elemento) {
                if (preguntasPadre[0]
                    .contains(elemento.questionId.toString())) {
                  return elemento.questionText.toString();
                }
              }).toList();

              final filtrado = padre.where((e) => e != null).toList();

              campos.add(ReactiveValueListenableBuilder<String>(
                formControlName: filtrado[0],
                builder: (context, control, child) {
                  if (respuestasPadre[0].contains(control.value.toString())) {
                    if (preguntasPadre.length >= 2) {
                      final padre2 = form.map((elemento) {
                        if (preguntasPadre[1]
                            .contains(elemento.questionId.toString())) {
                          return elemento.questionText.toString();
                        }
                      }).toList();

                      final filtrado2 = padre2.where((e) => e != null).toList();

                      return ReactiveValueListenableBuilder(
                        formControlName: filtrado2[0],
                        builder: (context, control, child) {
                          if (respuestasPadre[1]
                              .contains(control.value.toString())) {
                            return Column(
                              children: [
                                SOTextField(
                                  campo: campo,
                                ),
                                espacio,
                              ],
                            );
                          }
                          return Container();
                        },
                      );
                    } else {
                      return Column(
                        children: [
                          SOTextField(
                            campo: campo,
                          ),
                          espacio,
                        ],
                      );
                    }

                    //campos.add(espacio);
                  }
                  return Container();
                },
              ));
            } else {
              campos.add(
                SOTextField(campo: campo),
              );
              campos.add(espacio);
            }
          }
      }
    }

    return campos;
  }

  Future<void> guardarFormulario(
    OnCurrentFormSaving event,
    Emitter<FormularioState> emit,
  ) async {
    add(
      const OnProcessingEvent(
        mensaje: "Procesando Formulario...",
        procesado: 0,
        sinProcesar: 0,
        enviado: false,
        guardado: false,
      ),
    );

    UsuarioService _usuarioService = UsuarioService();

    final estructura = event.currentForm;
    final frm = event.formGroup;
    List<FormularioAnswer> respuestas = [];

    final usuario = await _usuarioService.getInfoUsuario();
    final currentDate = DateTime.now();
    final formated = DateFormat('yyyyMMdd:HHmmss').format(currentDate);
    final dato2 = DateFormat('yyyyMMddHHmmss').format(currentDate);

    final instanceId = dato2 + usuario.usuario.toString();

    int formId = -1;

    for (var campo in estructura!) {
      FormularioAnswer resp = FormularioAnswer(
        instanceId: instanceId + campo.formId.toString(),
        formId: campo.formId,
        respondentId: usuario.usuario,
        fechaCreacion: formated,
        questionId: campo.questionId,
        enviado: "NO",
      );

      formId = campo.formId!;

      switch (campo.questionType) {
        case 'Abierta Texto':
        case 'Abierta Numerica':
        case 'Seleccion Unica':
        case 'Abierta Texto Multilinea':
        case 'Localizacion':
          resp = resp.copyWith(
            response: frm!.controls["${campo.questionText}"]!.value.toString(),
          );
          break;
        case 'Seleccion Multiple':
          final respuesta =
              (frm!.controls["${campo.questionText}"]!.value as List);
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
            if (frm!.controls["${campo.questionText}"]!.value != null) {
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

    add(
      const OnProcessingEvent(
        mensaje: "Formulario procesado.",
        procesado: 0,
        sinProcesar: 0,
        enviado: false,
        guardado: false,
      ),
    );

    add(
      const OnProcessingEvent(
        mensaje: "Guardando formulario localmente.",
        procesado: 0,
        sinProcesar: 0,
        enviado: false,
        guardado: false,
      ),
    );
    await _dbService.guardarRespuestaFormulario(respuestas);
    final formularios = state.formularios;

    formularios[formularios.indexWhere((element) => element.formId == formId)]
        .guardado = true;

    add(
      const OnProcessingEvent(
        mensaje: "Formulario guardado localmente",
        procesado: 0,
        sinProcesar: 0,
        enviado: false,
        guardado: true,
      ),
    );

    add(OnUpdateFormsEvent(formularios: formularios));

    final datos = await _dbService.leerRespuestaFormulario(
        instanceId: instanceId + formId.toString());

    await enviarDatos(datos);

    formularios[formularios.indexWhere((element) => element.formId == formId)]
        .enviado = true;

    add(OnUpdateFormsEvent(formularios: formularios));
  }

  Future<void> enviarDatos(List<FormularioAnswer> respuestas) async {
    add(
      const OnProcessingEvent(
        mensaje: "Enviando formulario.",
        procesado: 0,
        sinProcesar: 0,
        enviado: false,
        guardado: true,
      ),
    );
    DBService db = DBService();

    List<Map<String, dynamic>> datos = [];

    int total = respuestas.length;
    for (var info in respuestas) {
      final data = {
        'appId': '300',
        'respondentId': info.respondentId,
        'formId': info.formId,
        'questionId': info.questionId,
        'response': info.response,
        'fechaCreacion': info.fechaCreacion,
      };

      datos.add(data);
    }

    try {
      final body = {
        "data": datos,
      };

      final resp = await http
          .post(
            Uri.parse('${Environment.apiURL}/appdms/newform_json'),
            body: jsonEncode(body),
            headers: {'Content-Type': 'application/json'},
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(minutes: 5));

      if (resp.statusCode == 200) {
        add(
          OnProcessingEvent(
            mensaje: "Actualizando despues de enviado.",
            procesado: total,
            sinProcesar: 0,
            enviado: true,
            guardado: true,
          ),
        );
        await db.updateEnviados(
          respuestas,
        );

        add(
          OnProcessingEvent(
            mensaje: "Enviado exitosamente.",
            procesado: total,
            sinProcesar: 0,
            enviado: true,
            guardado: true,
          ),
        );
      } else {
        add(
          OnProcessingEvent(
            mensaje:
                "Ocurrió un error al procesar respuesta. La puedes sincronizar luego desde el menú principal.",
            procesado: 0,
            sinProcesar: total,
            enviado: false,
            guardado: true,
          ),
        );
      }
    } on TimeoutException catch (_) {
      add(
        OnProcessingEvent(
          mensaje:
              "Ocurrió un error al procesar respuesta. La puedes sincronizar luego desde el menú principal.",
          procesado: 0,
          sinProcesar: total,
          enviado: false,
          guardado: true,
        ),
      );
      return;
    } catch (e) {
      add(
        OnProcessingEvent(
          mensaje:
              "Ocurrió un error al procesar respuesta. La puedes sincronizar desde el menú principal.",
          procesado: 0,
          sinProcesar: total,
          enviado: false,
          guardado: true,
        ),
      );
    }
  }
}
