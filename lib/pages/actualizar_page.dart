import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/widgets/widgets.dart';

class ActualizarPage extends StatefulWidget {
  const ActualizarPage({Key? key}) : super(key: key);
  @override
  _ActualizarPageState createState() => _ActualizarPageState();
}

class _ActualizarPageState extends State<ActualizarPage>
    with TickerProviderStateMixin {
  late AnimationController btnController;
  late Animation<double> girar;
  late ActualizarBloc _actualizarBloc;
  late AuthBloc _auth;

  @override
  void initState() {
    super.initState();

    _actualizarBloc = BlocProvider.of<ActualizarBloc>(context);
    _auth = BlocProvider.of<AuthBloc>(context);
    _actualizarBloc.init();


    btnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    girar = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: btnController,
        curve: Curves.easeOut,
      ),
    );

    //Agregamos un listener
    btnController.addListener(() {
      if (btnController.status == AnimationStatus.completed) {
        btnController.repeat();
      }
    });
  }

  @override
  void dispose() {
    btnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
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
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  "Actualización",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontFamily: 'CronosSPro',
                    fontSize: 28,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 300,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Lottie.asset(
                          'assets/lottie/update_image.json',
                          height: 200,
                        ),
                        BlocBuilder<ActualizarBloc, ActualizarState>(
                          builder: (context, state) {
                            if (state.mensaje.isNotEmpty) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: SOHorizontalCard(
                                      title: "¡Actualizando!",
                                      content: state.mensaje.toString(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                );
                              });
                            }

                            if (state.actualizandoModelos ||
                                state.actualizandoForms ||
                                state.actualizandoPlanning ||
                                state.actualizandoTangible) {
                              btnController.forward();
                            } else {
                              btnController.stop();
                            }

                            return ListView.builder(
                              itemCount: state.tablas.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                VoidCallback fnActualizar = () {};

                                bool animar = false;

                                switch (state.tablas[index].tabla) {
                                  case 'formulario':
                                    fnActualizar = () {
                                      _actualizarBloc.actualizarFormularios(
                                          currentTablas: state.tablas);
                                    };
                                    if (state.actualizandoForms) {
                                      animar = true;
                                    }
                                    break;
                                  case 'planning':
                                    if ([6, 5]
                                        .contains(_auth.state.usuario.perfil)) {
                                      fnActualizar = () {
                                        _actualizarBloc.actualizarPlanningSup(
                                          currentTablas: state.tablas,
                                        );
                                      };
                                    } else {
                                      fnActualizar = () {
                                        _actualizarBloc.actualizarPlanning(
                                          currentTablas: state.tablas,
                                        );
                                      };
                                    }
                                    if (state.actualizandoPlanning) {
                                      animar = true;
                                    }
                                    break;
                                  case 'modelo':
                                    fnActualizar = () {
                                      _actualizarBloc.actualizarModelos(
                                        currentTablas: state.tablas,
                                      );
                                    };
                                    if (state.actualizandoModelos) {
                                      animar = true;
                                    }
                                    break;
                                  case 'tangible':
                                    fnActualizar = () {
                                      _actualizarBloc.actualizarTangible(
                                        currentTablas: state.tablas,
                                      );
                                    };
                                    if (state.actualizandoTangible) {
                                      animar = true;
                                    }
                                    break;
                                  default:
                                }
                                return Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xffcccaaa),
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    leading: InkWell(
                                      splashColor: kPrimaryColor,
                                      onTap: fnActualizar,
                                      child: AnimatedBuilder(
                                          animation: girar,
                                          builder: (context, child) {
                                            return Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(45),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0xffcccaaa),
                                                    blurRadius: 2,
                                                    offset: Offset(
                                                      0,
                                                      2,
                                                    ), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Transform.rotate(
                                                angle: animar
                                                    ? 2 * pi * girar.value
                                                    : 0,
                                                child: const Icon(
                                                  Icons.update_rounded,
                                                  color: kThirdColor,
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    trailing: Text(
                                      state.tablas[index].fechaActualizacion !=
                                              null
                                          ? DateFormat('dd/MM/yyyy HH:mm:ss')
                                              .format(state.tablas[index]
                                                  .fechaActualizacion!)
                                              .toString()
                                          : "Sin actualizar",
                                      style: const TextStyle(
                                        fontFamily: 'CronosLPro',
                                        fontSize: 14,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    title: Text(
                                      state.tablas[index].descripcion
                                          .toString(),
                                      style: const TextStyle(
                                        fontFamily: 'CronosLPro',
                                        fontSize: 16,
                                        color: kSecondaryColor,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
