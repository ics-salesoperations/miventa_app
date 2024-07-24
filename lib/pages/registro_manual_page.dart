import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/helpers/helpers.dart';
import 'package:miventa_app/screens/screens.dart';
import 'package:miventa_app/widgets/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/image_file.dart';

class RegistroManualPage extends StatefulWidget {
  final String id;
  const RegistroManualPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<RegistroManualPage> createState() => _RegistroManualPageState();
}

class _RegistroManualPageState extends State<RegistroManualPage> {
  late SpeedTestBloc speedBloc;

  @override
  void initState() {
    //
    super.initState();
    speedBloc = BlocProvider.of<SpeedTestBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final estructura = <String, AbstractControl<dynamic>>{};
    final valores = {
      "Llamadas": FormControl<bool>(value: false),
      "SMS": FormControl<bool>(value: false),
      "Navegacion": FormControl<bool>(value: false)
    };

    estructura.addEntries(valores.entries);

    final estructura2 = <String, AbstractControl<dynamic>>{};
    final valores2 = {
      "Lentitud": FormControl<bool>(value: false),
      "Inestabilidad": FormControl<bool>(value: false),
      "Sin señal general": FormControl<bool>(value: false),
      "Falla sin energia": FormControl<bool>(value: false)
    };

    estructura2.addEntries(valores2.entries);

    final form = FormGroup({
      'idLectura': FormControl<String>(
        validators: [
          Validators.required,
        ],
        value: widget.id,
      ),
      'departamento': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'municipio': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'zona': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'ambiente': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'tipoAmbiente': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'descripcionAmbiente': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'comentario': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'colonia': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'fallaDesde': FormControl<DateTime>(
        value: DateTime.now(),
        validators: [
          Validators.required,
        ],
      ),
      'horas': FormControl<RangeValues>(
        value: const RangeValues(
          0,
          24,
        ),
      ),
      'tipoAfectacion': FormArray(
        [FormGroup(estructura)],
      ),
      'afectacion': FormArray(
        [FormGroup(estructura2)],
      ),
      'fotografia': FormControl<ImageFile>(),
      'navegacionActiva': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'mbBajada': FormControl<double>(),
      'mbSubida': FormControl<double>(),
    });

    Future openDialog() => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const AlertDialog(
              backgroundColor: Colors.transparent,
              content: ProcessingScreenSenal(),
            ));

    return Scaffold(
      body: CustomPaint(
        painter: HeaderWavesGradientPainter(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 40),
              child: const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Registro Manual",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontFamily: 'CronosSPro',
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 80),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 10, left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.1, 0.1),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: ReactiveFormBuilder(
                        form: () => form,
                        builder: (context, formulario, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SOSeleccionUnicaFieldCustom(
                                campo: "departamento",
                                label: "Departamento",
                                listaValores: departamentos.join(","),
                                form: form,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ReactiveValueListenableBuilder<String>(
                                  formControlName: 'departamento',
                                  builder: (context, departamento, child) {
                                    return SOSeleccionUnicaFieldCustom(
                                      campo: "municipio",
                                      label: "Municipio",
                                      listaValores: [
                                        ...municipios
                                            .where((mun) {
                                              return mun.departamento ==
                                                  departamento.value.toString();
                                            })
                                            .toList()
                                            .map((elemento) =>
                                                elemento.municipio)
                                      ].join(","),
                                      form: form,
                                    );
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              const SOTextFieldCustom(
                                campo: "colonia",
                                label: "Colonia",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SOSeleccionUnicaFieldCustom(
                                campo: "zona",
                                label: "Zona",
                                listaValores: "RURAL,URBANA",
                                form: form,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SOSeleccionUnicaFieldCustom(
                                campo: "ambiente",
                                label: "Ambiente",
                                listaValores: "INTERIOR,EXTERIOR",
                                form: form,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SOSeleccionUnicaFieldCustom(
                                campo: "tipoAmbiente",
                                label: "Tipo Ambiente",
                                listaValores:
                                    "CALLE,CASA,EDIFICIO,MONTAÑA,PARQUE",
                                form: form,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ReactiveValueListenableBuilder<String>(
                                  formControlName: 'tipoAmbiente',
                                  builder: (context, tipo, child) {
                                    return SOSeleccionUnicaFieldCustom(
                                      campo: "descripcionAmbiente",
                                      label: "Descripción del Ambiente",
                                      listaValores: [
                                        ...ambientes
                                            .where((amb) {
                                              return amb.tipo ==
                                                  tipo.value.toString();
                                            })
                                            .toList()
                                            .map((elemento) =>
                                                elemento.descripcion)
                                      ].join(","),
                                      form: form,
                                    );
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              SODateCustom(
                                lastDate: DateTime.now(),
                                campo: "fallaDesde",
                                label: "¿Desde cuándo presenta la falla?",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SORangeCustom(
                                campo: "horas",
                                label: "Horas con falla",
                                min: 0.0,
                                max: 24.0,
                                divisions: 24,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SOSeleccionMultipleCustom(
                                campo: "tipoAfectacion",
                                label: "Tipo de afectación presentada",
                                listaValores: 'Llamadas,Navegacion,SMS',
                                formGroup: formulario,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SOSeleccionMultipleCustom(
                                campo: "afectacion",
                                label: "Afectación presentada",
                                listaValores:
                                    'Lentitud,Inestabilidad,Sin señal general,Falla sin energia',
                                formGroup: formulario,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SOTextFieldMultilineCustom(
                                campo: "comentario",
                                label: "Comentarios Adicionales",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SOSeleccionUnicaFieldCustom(
                                campo: "navegacionActiva",
                                label: "¿Tiene algún paquetede datos Activo?",
                                listaValores: "SI,NO",
                                form: form,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //DESHABILITADO JOSUE.MARQUEZ
                              /*
                              ReactiveValueListenableBuilder<String>(
                                formControlName: 'navegacionActiva',
                                builder: (context, tipo, child) {
                                  if (tipo.value == "SI") {
                                    return Column(
                                      children: [
                                        Stack(
                                          children: [
                                            BlocBuilder<SpeedTestBloc,
                                                SpeedTestState>(
                                              builder: (context, state) {
                                                return SfRadialGauge(
                                                  axes: <RadialAxis>[
                                                    RadialAxis(
                                                      minimum: 0,
                                                      maximum: 100,
                                                      axisLineStyle:
                                                          const AxisLineStyle(
                                                        color: kThirdColor,
                                                      ),
                                                      axisLabelStyle:
                                                          const GaugeTextStyle(
                                                              color:
                                                                  kSecondaryColor,
                                                              fontFamily:
                                                                  'CronosLPro'),
                                                      ranges: <GaugeRange>[
                                                        GaugeRange(
                                                          startValue: 0,
                                                          endValue: 100,
                                                          color: kPrimaryColor,
                                                          startWidth: 10,
                                                          endWidth: 20,
                                                        ),
                                                      ],
                                                      pointers: <GaugePointer>[
                                                        NeedlePointer(
                                                          value: state.tipo ==
                                                                  "BAJADA"
                                                              ? state.download
                                                              : state.upload,
                                                          needleColor:
                                                              kSecondaryColor,
                                                          enableAnimation: true,
                                                          knobStyle:
                                                              const KnobStyle(
                                                            color:
                                                                kSecondaryColor,
                                                          ),
                                                        )
                                                      ],
                                                      annotations: <
                                                          GaugeAnnotation>[
                                                        GaugeAnnotation(
                                                          widget: Container(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      state.tipo ==
                                                                              'BAJADA'
                                                                          ? state.download.toStringAsFixed(
                                                                              2)
                                                                          : state
                                                                              .upload
                                                                              .toStringAsFixed(2),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            30,
                                                                        fontFamily:
                                                                            'CronosSPro',
                                                                        color:
                                                                            kSecondaryColor,
                                                                      ),
                                                                    ),
                                                                    const Text(
                                                                      'Mbps',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        fontFamily:
                                                                            'CronosLPro',
                                                                        color:
                                                                            kSecondaryColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      state
                                                                          .tipo,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontFamily:
                                                                            'CronosLPro',
                                                                        color:
                                                                            kPrimaryColor,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '${state.mensaje}',
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontFamily:
                                                                            'CronosSPro',
                                                                        color:
                                                                            kPrimaryColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          angle: 90,
                                                          positionFactor: 0.8,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            Positioned(
                                              top: 100,
                                              left: (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2) -
                                                  98,
                                              child: BlocBuilder<SpeedTestBloc,
                                                  SpeedTestState>(
                                                builder: (context, state) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      state.ejecutando
                                                          ? Container()
                                                          : Column(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .download_outlined,
                                                                  size: 22,
                                                                  color:
                                                                      kThirdColor,
                                                                ),
                                                                Text(
                                                                  "${state.download.toStringAsFixed(1)}Mbps",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'CronosLPro',
                                                                    fontSize:
                                                                        16,
                                                                    color:
                                                                        kSecondaryColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      state.ejecutando
                                                          ? Container()
                                                          : Column(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .upload_outlined,
                                                                  size: 22,
                                                                  color:
                                                                      kThirdColor,
                                                                ),
                                                                Text(
                                                                  "${state.upload.toStringAsFixed(1)}Mbps",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'CronosLPro',
                                                                    fontSize:
                                                                        16,
                                                                    color:
                                                                        kSecondaryColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                    ],
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        const Text(
                                          "¿Realizar Test de Velocidad?",
                                          style: TextStyle(
                                            color: kSecondaryColor,
                                            fontSize: 16,
                                            fontFamily: 'CronosLPro',
                                          ),
                                        ),
                                        BlocBuilder<SpeedTestBloc,
                                            SpeedTestState>(
                                          builder: (context, state) {
                                            return MaterialButton(
                                              elevation: 4,
                                              color: Colors.white,
                                              onPressed: state.ejecutando
                                                  ? null
                                                  : () async {
                                                      final internetSpeedTest =
                                                          FlutterInternetSpeedTest();

                                                      final started =
                                                          await internetSpeedTest
                                                              .startTesting(
                                                        //fileSize: ,
                                                        uploadTestServer:
                                                            'http://speedtest.tele2.net/upload.php',
                                                        downloadTestServer:
                                                            'https://ipv4.scaleway.testdebit.info:8080/10M.iso',
                                                        //'https://so.tigo.com.hn/apex/r/boc/360/files/static/v234/Home_Comunicado.pdf',
                                                        //'https://freetestdata.com/wp-content/uploads/2021/09/Free_Test_Data_1MB_PDF.pdf',
                                                        //'http://ipv4.scaleway.testdebit.info/1M.iso',
                                                        onDone: (TestResult
                                                                download,
                                                            TestResult upload) {
                                                          speedBloc.add(
                                                              OnIniciarSpeedTest(
                                                            download: download
                                                                .transferRate,
                                                            upload: upload
                                                                .transferRate,
                                                            mensaje:
                                                                "100% completado",
                                                            tipo: "BAJADA",
                                                            ejecutando: false,
                                                          ));

                                                          formulario
                                                                  .controls[
                                                                      'mbSubida']!
                                                                  .value =
                                                              upload
                                                                  .transferRate;

                                                          formulario
                                                                  .controls[
                                                                      'mbBajada']!
                                                                  .value =
                                                              download
                                                                  .transferRate;
                                                        },
                                                        onProgress: (double
                                                                percent,
                                                            TestResult data) {
                                                          speedBloc.add(
                                                              OnIniciarSpeedTest(
                                                            download: data
                                                                        .type ==
                                                                    TestType
                                                                        .DOWNLOAD
                                                                ? data
                                                                    .transferRate
                                                                : 0,
                                                            upload: data.type ==
                                                                    TestType
                                                                        .UPLOAD
                                                                ? data
                                                                    .transferRate
                                                                : 0,
                                                            mensaje:
                                                                "${percent.toStringAsFixed(1)}% completado.",
                                                            tipo: data.type ==
                                                                    TestType
                                                                        .UPLOAD
                                                                ? "SUBIDA"
                                                                : "BAJADA",
                                                            ejecutando: true,
                                                          ));
                                                        },
                                                        onError: (String
                                                                errorMessage,
                                                            String
                                                                speedTestError) {
                                                          print(
                                                              "ERRROR:::$errorMessage");
                                                          print(
                                                              "ERRROR:::$speedTestError");
                                                          speedBloc.add(
                                                              const OnIniciarSpeedTest(
                                                            download: 0,
                                                            upload: 0,
                                                            mensaje:
                                                                "Ocurrió un erro al consultar los datos",
                                                            tipo: "Descarga",
                                                            ejecutando: false,
                                                          ));
                                                        },
                                                      );
                                                    },
                                              child: const Text(
                                                "Iniciar",
                                                style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontFamily: 'CronosLPro',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),*/
                              const SOPhotoCustom(
                                campo: "fotografia",
                                label: "Fotografía",
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ReactiveFormConsumer(
                                        builder: (context, form, child) {
                                      return SORoundedButton(
                                        label: "Enviar",
                                        funcion: !form.valid
                                            ? () {
                                                form.markAllAsTouched();
                                              }
                                            : () {
                                                NetworkInfoBloc
                                                    networkInfoBloc =
                                                    BlocProvider.of<
                                                            NetworkInfoBloc>(
                                                        context);
                                                networkInfoBloc
                                                    .guardarMarcacionManual(
                                                  formulario: form,
                                                );
                                                openDialog().then((value) =>
                                                    Navigator.pop(context));
                                              },
                                      );
                                    }),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: SORoundedButton(
                                      label: "Cerrar",
                                      funcion: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
