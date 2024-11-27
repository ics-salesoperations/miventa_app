import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/screens/confirmation_screen.dart';
import 'package:miventa_app/screens/detalle_visita_screen.dart';
import 'package:miventa_app/services/db_service.dart';
import 'package:miventa_app/widgets/widgets.dart';
import 'package:reactive_date_range_picker/reactive_date_range_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../models/models.dart';
//import 'package:elegant_notification/elegant_notification.dart';

class SincronizarPage extends StatefulWidget {
  const SincronizarPage({Key? key}) : super(key: key);
  @override
  _SincronizarPageState createState() => _SincronizarPageState();
}

class _SincronizarPageState extends State<SincronizarPage> {
  late SyncBloc syncBloc;
  DBService db = DBService();
  final formulario = FormGroup({
    'rango': FormControl<DateTimeRange>(
        validators: [Validators.required],
        value: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        )),
  });

  List<ProductoTangible> registros = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_Es', null);
    syncBloc = BlocProvider.of<SyncBloc>(context);
    syncBloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: CustomPaint(
        painter: HeaderPicoPainter(),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 15,
            left: 15,
            right: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_outlined,
                        color: kPrimaryColor,
                        size: 22,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Mi Gestión",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontFamily: 'CronosSPro',
                            fontSize: 28,
                          ),
                        ),
                        Lottie.asset(
                          'assets/lottie/buscar.json',
                          width: 50,
                          height: 50,
                          animate: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<SyncBloc, SyncState>(builder: (context, state) {
                if (state.actualizandoResumen) {
                  return const Center(child: CircularProgressIndicator());
                }

                final datos = state.resSincronizar;
                final sincronizados =
                    datos.where((resp) => resp.porcentajeSync == 100).length;

                final noSincronizados = datos.length - sincronizados;

                return Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        _Filtros(
                          formulario: formulario,
                          syncBloc: syncBloc,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _Resultados(
                          sincronizados: sincronizados,
                          noSincronizados: noSincronizados,
                        ),
                        _Botones(syncBloc: syncBloc),
                        const Divider(),
                        const Text(
                          "Lista de formularios",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontFamily: 'CronosSPro',
                            fontSize: 18,
                          ),
                        ),
                        state.mensaje == ""
                            ? Container()
                            : Container(
                                height: 60,
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Lottie.asset(
                                      'assets/lottie/cargando.json',
                                      height: 40,
                                    ),
                                    Text(
                                      " " + state.mensaje,
                                      style: const TextStyle(
                                        fontFamily: 'CronosLPro',
                                        fontSize: 14,
                                        color: kSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        const SizedBox(
                          height: 25,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemCount: datos.length,
                              separatorBuilder: (context, index) => Container(
                                height: 5,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    final pdv = await db.leerDetallePdv(
                                        datos[index].idPdv ?? 0);

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DetalleVisitaScreen(
                                          pdv: pdv.isEmpty
                                              ? Planning(
                                                  idPdv: 0,
                                                  nombrePdv: datos[index].tipo,
                                                )
                                              : pdv.first,
                                          idVisita:
                                              datos[index].idVisita.toString(),
                                          fechaVisita: datos[index].fecha!,
                                          tipo: datos[index].tipo.toString(),
                                        );
                                      },
                                    );
                                  },
                                  child: FadeInLeft(
                                    child: SOFormCard(
                                      res: datos[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      )),
    );
  }
}

class _Botones extends StatelessWidget {
  const _Botones({
    Key? key,
    required this.syncBloc,
  }) : super(key: key);

  final SyncBloc syncBloc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MaterialButton(
            child: Container(
              height: 40,
              width: 120,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(22),
                ),
                color: kSecondaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/delete.json',
                    height: 22,
                  ),
                  const Flexible(
                    child: Center(
                      child: Text(
                        " Eliminar sincronizados",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'CronosLPro',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              //syncBloc.
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const ConfirmationScreen(
                  mensaje:
                      "¿Estas seguro de eliminar los formularios ya sincronizados?",
                ),
              ).then((value) async {
                if (value) {
                  await syncBloc.eliminarDatosLocalesSincronizados();
                  syncBloc.init();
                }
              });
            },
          ),
          BlocBuilder<SyncBloc, SyncState>(
            builder: (context, state) {
              return MaterialButton(
                child: Container(
                  height: 40,
                  width: 120,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(22),
                    ),
                    color: kSecondaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Lottie.asset(
                        'assets/lottie/send.json',
                        height: 22,
                      ),
                      const Text(
                        "Sincronizar",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'CronosLPro',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: state.mensaje == ""
                    ? () async {
                        await syncBloc.sincronizarDatos(0,null);
                        await syncBloc.init();
                      }
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Resultados extends StatelessWidget {
  const _Resultados({
    Key? key,
    required this.sincronizados,
    required this.noSincronizados,
  }) : super(key: key);

  final int sincronizados;
  final int noSincronizados;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: kThirdColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "$sincronizados",
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'CronosSPro',
                  fontSize: 45,
                ),
              ),
              Text(
                "Sincronizados",
                style: TextStyle(
                  color: kSecondaryColor.withOpacity(0.75),
                  fontFamily: 'CronosSPro',
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Lottie.asset(
            'assets/lottie/check_list.json',
            height: 50,
          ),
          Column(
            children: [
              Text(
                "$noSincronizados",
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'CronosSPro',
                  fontSize: 45,
                ),
              ),
              Text(
                "Sin sincronizar",
                style: TextStyle(
                  color: kSecondaryColor.withOpacity(0.75),
                  fontFamily: 'CronosSPro',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Filtros extends StatelessWidget {
  const _Filtros({
    Key? key,
    required this.formulario,
    required this.syncBloc,
  }) : super(key: key);

  final FormGroup formulario;
  final SyncBloc syncBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 248, 248, 248),
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: ReactiveFormBuilder(
        form: () => formulario,
        builder: (context, form, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "     Filtrar:",
                style: TextStyle(
                  fontFamily: 'CronosLPro',
                  fontSize: 20,
                  color: kSecondaryColor,
                ),
              ),
              ReactiveDateRangePicker(
                formControlName: 'rango',
                lastDate: DateTime.now(),
                errorFormatText: "Formato de fecha inválido.",
                validationMessages: {
                  "required": ((error) => "Rango de fechas inválido")
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  helperText: '',
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: kSecondaryColor,
                  ),
                ),
              ),
              SizedBox(
                width: 110,
                height: 30,
                child: ReactiveFormConsumer(
                  builder: (context, frm, child) => MaterialButton(
                    child: Container(
                      height: 30,
                      width: 115,
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(22),
                        ),
                        color: kPrimaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/Iconos/filter.svg',
                            height: 16,
                          ),
                          const Flexible(
                            child: Center(
                              child: Text(
                                "Filtrar",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'CronosLPro',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      if (frm.valid) {
                        DateTimeRange rango =
                            frm.controls['rango']!.value as DateTimeRange;

                        syncBloc.getRespResumen(
                          rango.start,
                          rango.end,
                        );
                      } else {
                        print("FORMULARIO INVALIDO");
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
