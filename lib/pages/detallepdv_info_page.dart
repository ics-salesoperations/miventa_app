import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/pages/pages.dart';
import 'package:miventa_app/screens/formularios_visita_screen.dart';
import 'package:miventa_app/screens/screens.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../blocs/blocs.dart';

class DetallePdvInfo extends StatefulWidget {
  final Planning detallePdv;

  const DetallePdvInfo({super.key, required this.detallePdv});

  @override
  State<DetallePdvInfo> createState() => _DetallePdvInfoState(
        detallePdv: detallePdv,
      );
}

class _DetallePdvInfoState extends State<DetallePdvInfo> {
  final Planning detallePdv;
  late FormularioBloc frmBloc;
  late AuthBloc _auth;
  late ActualizarBloc _actualizarBloc;
  late Future<List<IncentivoPdv>> _futureIncentivosPdv;

  _DetallePdvInfoState({
    required this.detallePdv,
  });

  List<IncentivoPdv> incentivosPdv = [];

  @override
  void initState() {
    frmBloc = BlocProvider.of<FormularioBloc>(context);
    _auth = BlocProvider.of<AuthBloc>(context);
    _actualizarBloc = BlocProvider.of<ActualizarBloc>(context);
    _futureIncentivosPdv = BlocProvider.of<ActualizarBloc>(context)
        .getIncentivosPdv(detallePdv.idPdv.toString());
    _actualizarBloc.actualizarTangibleReasignacion(idPdv: detallePdv.idPdv!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    int? perfil = BlocProvider.of<AuthBloc>(context).state.usuario.perfil;

    return Scaffold(
      //backgroundColor: const Color(0xFFffffff),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kThirdColor.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffcccaaa),
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Información General',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: kSecondaryColor,
                      fontFamily: 'Cronos-Pro',
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 42,
                top: 2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.75),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(45),
                    ),
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
                ),
              ),
              Positioned(
                right: 42,
                top: 2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.75),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(45),
                    ),
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
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 55),
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  width: screenWidth * 0.8,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FutureBuilder<List<IncentivoPdv>>(
                        future: _futureIncentivosPdv,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No hay incentivos disponibles'));
                          } else {
                            List<IncentivoPdv> incentivosPdv = snapshot.data!;
                            return CarouselSlider(
                              options: CarouselOptions(
                                height: MediaQuery.of(context).size.height *
                                    0.17, // Ajusta la altura según sea necesario
                                enableInfiniteScroll: true,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 5),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                              ),
                              items: incentivosPdv.map((incentivo) {
                                var incentivoMap = incentivos.firstWhere(
                                  (map) =>
                                      map["tipo_incentivo"] ==
                                      incentivo.incentivo.toString(),
                                  orElse: () => {},
                                );

                                return cardIndicador(
                                  title: incentivoMap["titulo"]!,
                                  icono: incentivoMap["svg"]!,
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeigth,
                                  colorBorde: incentivo.incentivo.toString() ==
                                          '90 Días'
                                      ? kThirdColor
                                      : kPrimaryColor,
                                  titulo: incentivoMap["titulo"]!,
                                  subtitulo: incentivoMap["subTitulo"]!,
                                  detalle: incentivo.incentivo.toString() ==
                                          '90 Días'
                                      ? 'Total: ' + incentivo.meta.toString()
                                      : 'Meta: ' + incentivo.meta.toString(),
                                  onTap: incentivo.incentivo.toString() ==
                                          '90 Días'
                                      ? () async => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InventarioReasignacionPage(
                                                  detallePdv: detallePdv,
                                                ),
                                              ),
                                            )
                                          }
                                      : null,
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.idPdv.toString(),
                        title: "ID PDV",
                        icono: 'assets/Iconos/SmartphoneStar.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.nombrePdv.toString(),
                        title: "Nombre PDV",
                        icono: 'assets/pdv.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                        esFormulario: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModificarFormPage(
                                detallePdv: detallePdv,
                                idForm: "41",
                              ),
                            ),
                          ).then((value) {
                            frmBloc.add(
                              const OnCurrentFormReadyEvent(
                                isCurrentFormReady: false,
                                currentForm: [],
                              ),
                            );
                          });
                        },
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.nombreDueno.toString(),
                        title: "Nombre Dueño",
                        icono: 'assets/Iconos/SmartphoneStar.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                        esFormulario: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModificarFormPage(
                                detallePdv: detallePdv,
                                idForm: "42",
                              ),
                            ),
                          ).then((value) {
                            frmBloc.add(
                              const OnCurrentFormReadyEvent(
                                isCurrentFormReady: false,
                                currentForm: [],
                              ),
                            );
                          });
                        },
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.identidadDueno.toString(),
                        title: "Identidad Dueño",
                        icono: 'assets/Iconos/SmartphoneStar.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                        esFormulario: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModificarFormPage(
                                detallePdv: detallePdv,
                                idForm: "42",
                              ),
                            ),
                          ).then((value) {
                            frmBloc.add(
                              const OnCurrentFormReadyEvent(
                                isCurrentFormReady: false,
                                currentForm: [],
                              ),
                            );
                          });
                        },
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.nombreSucursal
                            .toString()
                            .replaceAll('DEALER - ', ''),
                        title: "Sucursal",
                        icono: 'assets/pdv.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.nombreCircuito.toString(),
                        title: "Circuito",
                        icono: 'assets/pdv.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                        esFormulario: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModificarFormPage(
                                detallePdv: detallePdv,
                                idForm: "47",
                              ),
                            ),
                          ).then((value) {
                            frmBloc.add(
                              const OnCurrentFormReadyEvent(
                                isCurrentFormReady: false,
                                currentForm: [],
                              ),
                            );
                          });
                        },
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.territorio.toString(),
                        title: "Territorio",
                        icono: 'assets/Iconos/info_dollar.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.categoria.toString(),
                        title: "Categoría",
                        icono: 'assets/celTigo.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                        esFormulario: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModificarFormPage(
                                detallePdv: detallePdv,
                                idForm: "88",
                              ),
                            ),
                          ).then((value) {
                            frmBloc.add(
                              const OnCurrentFormReadyEvent(
                                isCurrentFormReady: false,
                                currentForm: [],
                              ),
                            );
                          });
                        },
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.segmentoPdv.toString(),
                        title: "Segmento",
                        icono: 'assets/celTigo.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          Clipboard.setData(
                            ClipboardData(
                              text: (detallePdv.movilEpin == 'null'
                                  ? "No tiene"
                                  : detallePdv.movilEpin.toString()),
                            ),
                          ).then((value) {
                            //only if ->
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: kThirdColor,
                                duration: const Duration(
                                  seconds: 1,
                                ),
                                content: Text(
                                  "Texto copiado: " +
                                      (detallePdv.movilEpin == 'null'
                                          ? "No tiene"
                                          : detallePdv.movilEpin.toString()),
                                  style: const TextStyle(
                                    fontFamily: 'CronosLPro',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                        child: buildUserInfoDisplay(
                          getValue: (detallePdv.movilEpin == 'null'
                              ? "No tiene"
                              : detallePdv.movilEpin.toString()),
                          title: "Movil Epin",
                          icono: 'assets/celTigo.svg',
                          screenWidth: screenWidth,
                          screenHeight: screenHeigth,
                          esFormulario: true,
                          onTap: () {
                            if ([6, 5, 1]
                                .contains(_auth.state.usuario.perfil)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ModificarFormPage(
                                    detallePdv: detallePdv,
                                    idForm: "82",
                                  ),
                                ),
                              ).then((value) {
                                frmBloc.add(
                                  const OnCurrentFormReadyEvent(
                                    isCurrentFormReady: false,
                                    currentForm: [],
                                  ),
                                );
                              });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ModificarFormPage(
                                    detallePdv: detallePdv,
                                    idForm: "83",
                                  ),
                                ),
                              ).then((value) {
                                frmBloc.add(
                                  const OnCurrentFormReadyEvent(
                                    isCurrentFormReady: false,
                                    currentForm: [],
                                  ),
                                );
                              });
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          Clipboard.setData(ClipboardData(
                            text: (detallePdv.movilActivador == null
                                ? "No tiene"
                                : detallePdv.movilActivador.toString()),
                          )).then((value) {
                            //only if ->
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: kThirdColor,
                                duration: const Duration(
                                  seconds: 1,
                                ),
                                content: Text(
                                  "Texto copiado: " +
                                      (detallePdv.movilActivador == null
                                          ? "No tiene"
                                          : detallePdv.movilActivador
                                              .toString()),
                                  style: const TextStyle(
                                    fontFamily: 'CronosLPro',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                        child: buildUserInfoDisplay(
                          getValue: detallePdv.movilActivador == null
                              ? "No tiene"
                              : detallePdv.movilActivador.toString(),
                          title: "Movil Activador",
                          icono: 'assets/celTigo.svg',
                          screenWidth: screenWidth,
                          screenHeight: screenHeigth,
                          esFormulario: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ModificarFormPage(
                                  detallePdv: detallePdv,
                                  idForm: "19",
                                ),
                              ),
                            ).then((value) {
                              frmBloc.add(
                                const OnCurrentFormReadyEvent(
                                  isCurrentFormReady: false,
                                  currentForm: [],
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          Clipboard.setData(
                            ClipboardData(
                              text: (detallePdv.movilTmy == 'null'
                                  ? "No tiene"
                                  : detallePdv.movilTmy.toString()),
                            ),
                          ).then((value) {
                            //only if ->
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: kThirdColor,
                                duration: const Duration(
                                  seconds: 1,
                                ),
                                content: Text(
                                  "Texto copiado: " +
                                      (detallePdv.movilTmy == 'null'
                                          ? "No tiene"
                                          : detallePdv.movilTmy.toString()),
                                  style: const TextStyle(
                                    fontFamily: 'CronosLPro',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                        child: buildUserInfoDisplay(
                          getValue: (detallePdv.movilTmy == 'null'
                              ? "No tiene"
                              : detallePdv.movilTmy.toString()),
                          title: "Movil TMY",
                          icono: 'assets/celTigo.svg',
                          screenWidth: screenWidth,
                          screenHeight: screenHeigth,
                        ),
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.permitePop.toString(),
                        title: "Permite POP",
                        icono: 'assets/Iconos/SmartphoneStar.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                        esFormulario: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModificarFormPage(
                                detallePdv: detallePdv,
                                idForm: "46",
                              ),
                            ),
                          ).then((value) {
                            frmBloc.add(
                              const OnCurrentFormReadyEvent(
                                isCurrentFormReady: false,
                                currentForm: [],
                              ),
                            );
                          });
                        },
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.miTienda.toString() == 'null'
                            ? "NO"
                            : detallePdv.miTienda.toString(),
                        title: "Mi Tienda",
                        icono: 'assets/Iconos/Mi Tigo.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.direccion.toString() == 'null'
                            ? ''
                            : detallePdv.direccion.toString(),
                        title: "Dirección",
                        icono: 'assets/pdv.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                        esFormulario: true,
                        onTap: () {
                          if ([6, 5, 1].contains(_auth.state.usuario.perfil)) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ModificarFormPage(
                                  detallePdv: detallePdv,
                                  idForm: "73",
                                ),
                              ),
                            ).then((value) {
                              frmBloc.add(
                                const OnCurrentFormReadyEvent(
                                  isCurrentFormReady: false,
                                  currentForm: [],
                                ),
                              );
                            });
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ModificarFormPage(
                                  detallePdv: detallePdv,
                                  idForm: "43",
                                ),
                              ),
                            ).then((value) {
                              frmBloc.add(
                                const OnCurrentFormReadyEvent(
                                  isCurrentFormReady: false,
                                  currentForm: [],
                                ),
                              );
                            });
                          }
                        },
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.dmsStatus.toString() == 'null'
                            ? ''
                            : detallePdv.dmsStatus.toString(),
                        title: "Estado",
                        icono: 'assets/pdv.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                        esFormulario: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModificarFormPage(
                                detallePdv: detallePdv,
                                idForm: "44",
                              ),
                            ),
                          ).then((value) {
                            frmBloc.add(
                              const OnCurrentFormReadyEvent(
                                isCurrentFormReady: false,
                                currentForm: [],
                              ),
                            );
                          });
                        },
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.servicios.toString() == 'null'
                            ? ''
                            : detallePdv.servicios.toString(),
                        title: "Servicios",
                        icono: 'assets/pdv.svg',
                        screenWidth: screenWidth,
                        screenHeight: screenHeigth,
                        esFormulario: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModificarFormPage(
                                detallePdv: detallePdv,
                                idForm: "86",
                              ),
                            ),
                          ).then((value) {
                            frmBloc.add(
                              const OnCurrentFormReadyEvent(
                                isCurrentFormReady: false,
                                currentForm: [],
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: SpeedDialFabWidget(
        secondaryIconsList: perfil != 6 && perfil != 1 && perfil != 5
            ? const [
                Icons.store,
                Icons.change_circle_rounded,
                Icons.security_rounded,
                Icons.format_list_numbered_outlined,
              ]
            : const [
                Icons.store,
                Icons.change_circle_rounded,
                Icons.list_alt,
                Icons.security_rounded,
                Icons.format_list_numbered_outlined,
              ],
        secondaryIconsText: perfil != 6 && perfil != 1 && perfil != 5
            ? const [
                "Registrar Visita",
                "Cambio de Local",
                "Garantía de Equipo",
                "Encuestas",
              ]
            : const [
                "Registrar Visita",
                "Cambio de Local",
                "Forven 13",
                "Garantía de Equipo",
                "Encuestas",
              ],
        secondaryIconsOnPress: perfil != 6 && perfil != 1 && perfil != 5
            ? [
                () async => {
                      await showDialog(
                        context: context,
                        builder: (ctx) =>
                            ValidacionVisitaScreen(pdv: detallePdv),
                      ).then(
                        (value) {
                          if (value == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RealizarVisitaPage(
                                  detallePdv: detallePdv,
                                ),
                              ),
                            );
                          } else {
                            //Navigator.pop(context);
                          }
                        },
                      )
                    },
                () => {
                      //cambio de local
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModificarFormPage(
                            detallePdv: detallePdv,
                            idForm: "85",
                          ),
                        ),
                      ).then((value) {
                        frmBloc.add(
                          const OnCurrentFormReadyEvent(
                            isCurrentFormReady: false,
                            currentForm: [],
                          ),
                        );
                      })
                    },
                () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModificarFormPage(
                            detallePdv: detallePdv,
                            idForm: "32",
                          ),
                        ),
                      ).then((value) {
                        frmBloc.add(
                          const OnCurrentFormReadyEvent(
                            isCurrentFormReady: false,
                            currentForm: [],
                          ),
                        );
                      })
                    },
                () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormulariosVisitaScreen(
                            pdv: detallePdv,
                          ),
                        ),
                      ).then((value) {
                        frmBloc.add(
                          const OnCurrentFormReadyEvent(
                            isCurrentFormReady: false,
                            currentForm: [],
                          ),
                        );
                      })
                    },
              ]
            : [
                () async => {
                      await showDialog(
                        context: context,
                        builder: (ctx) =>
                            ValidacionVisitaScreen(pdv: detallePdv),
                      ).then(
                        (value) {
                          if (value == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RealizarVisitaPage(
                                  detallePdv: detallePdv,
                                ),
                              ),
                            );
                          } else {
                            //Navigator.pop(context);
                          }
                        },
                      )
                    },
                () => {
                      //cambio de local
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModificarFormPage(
                            detallePdv: detallePdv,
                            idForm: "85",
                          ),
                        ),
                      ).then((value) {
                        frmBloc.add(
                          const OnCurrentFormReadyEvent(
                            isCurrentFormReady: false,
                            currentForm: [],
                          ),
                        );
                      })
                    },
                () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModificarFormPage(
                            detallePdv: detallePdv,
                            idForm: "33",
                          ),
                        ),
                      ).then((value) {
                        frmBloc.add(
                          const OnCurrentFormReadyEvent(
                            isCurrentFormReady: false,
                            currentForm: [],
                          ),
                        );
                      })
                    },
                () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModificarFormPage(
                            detallePdv: detallePdv,
                            idForm: "32",
                          ),
                        ),
                      ).then((value) {
                        frmBloc.add(
                          const OnCurrentFormReadyEvent(
                            isCurrentFormReady: false,
                            currentForm: [],
                          ),
                        );
                      })
                    },
                () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormulariosVisitaScreen(
                            pdv: detallePdv,
                          ),
                        ),
                      ).then((value) {
                        frmBloc.add(
                          const OnCurrentFormReadyEvent(
                            isCurrentFormReady: false,
                            currentForm: [],
                          ),
                        );
                      })
                    },
              ],
        secondaryBackgroundColor: kSecondaryColor,
        secondaryForegroundColor: Colors.white,
        primaryBackgroundColor: kThirdColor,
        primaryForegroundColor: kSecondaryColor,
      ),
    );
  }
}

Widget buildUserInfoDisplay({
  required String getValue,
  required String title,
  required String icono,
  required double screenWidth,
  required double screenHeight,
  bool esFormulario = false,
  VoidCallback? onTap,
}) =>
    Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              splashColor: kThirdColor,
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(10),
                width: screenWidth * 0.8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: kScaffoldBackground,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffcccaaa),
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    esFormulario
                        ? Container(
                            //height: 80,
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.library_add_rounded,
                              color: kFourColor.withOpacity(0.1),
                              size: 35,
                            ),
                          )
                        : Container(),
                    Row(
                      children: [
                        SvgPicture.asset(icono,
                            height: 50, semanticsLabel: 'Label'),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontFamily: 'CronosLPro',
                              color: kSecondaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            getValue,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: const TextStyle(
                              fontFamily: 'CronosSPro',
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));

Widget tarjetaConIcono({
  required String title,
  required String icono,
  required double screenWidth,
  required double screenHeight,
  VoidCallback? onTap,
}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            splashColor: kThirdColor,
            onTap: onTap,
            child: Container(
              width: screenWidth * 0.8,
              height: 35,
              margin: const EdgeInsets.only(left: 110, top: 18),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: kScaffoldBackground,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffcccaaa),
                    blurRadius: 5,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Cronos-Pro',
                    color: kSecondaryColor,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
          Positioned(
            left: 75,
            child: Lottie.asset(
              icono,
              width: 70,
              height: 70,
              animate: true,
            ),
          ),
        ],
      ),
    );

Widget tarjetaConIconoForm({
  required String title,
  required String icono,
  required double screenWidth,
  required double screenHeight,
  VoidCallback? onTap,
}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            splashColor: kThirdColor,
            onTap: onTap,
            child: Container(
              width: screenWidth * 0.3,
              height: 35,
              margin: const EdgeInsets.only(left: 110, top: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: kScaffoldBackground,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffcccaaa),
                    blurRadius: 5,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Cronos-Pro',
                    color: kSecondaryColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 100,
            top: 12,
            child: Icon(
              Icons.dynamic_form,
              size: 32,
              color: kSecondaryColor,
            ),
          ),
        ],
      ),
    );

Widget cardIndicador({
  required String title,
  required String icono,
  required double screenWidth,
  required double screenHeight,
  required String titulo,
  required String subtitulo,
  required Color colorBorde,
  String? detalle,
  VoidCallback? onTap, // Añade el callback onTap
}) =>
    GestureDetector(
      onTap: onTap, // Asigna el onTap aquí
      child: Card(
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: kScaffoldBackground,
        color: kSecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Container(
          width: screenWidth * 0.8,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: kScaffoldBackground,
            border: Border.all(
              color: colorBorde,
              width: 2.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: kSecondaryColor,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titulo,
                            style: const TextStyle(
                              fontFamily: 'CronosPro',
                              fontSize: 16,
                              color: kSecondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            subtitulo,
                            style: const TextStyle(
                              fontFamily: 'CronosLPro',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          icono,
                          height: 50,
                          semanticsLabel: 'Label',
                        ),
                        const SizedBox(height: 5),
                        Text(
                          detalle ?? '',
                          style: const TextStyle(
                            fontFamily: 'CronosLPro',
                            fontSize: 12,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
//BLISTER,EPIN,COMISION AUMENTADA,90 Días
List<Map<String, String>> incentivos = [
  {
    "tipo_incentivo": "EPIN",
    "titulo": "Incentivo EPIN",
    "subTitulo": "L25 en EPIN por cada gross adicional",
    "Restriciones":
        "*Aplican restricciones a un máximo de cumplimiento permitido",
    "svg": 'assets/Iconos/SmartphoneGiftSimplified.svg',
  },
  {
    "tipo_incentivo": "BLISTER",
    "titulo": "Activación Blister",
    "subTitulo": "SR de 7 días al cumplir la meta asignada.",
    "Restriciones": "",
    "svg": 'assets/Iconos/SmartphoneGiftSimplified.svg',
  },
  {
    "tipo_incentivo": "COMISION AUMENTADA",
    "titulo": "Comisión aumentada",
    "subTitulo": "Recibe una comisión diferenciada en los WP el siguiente mes.",
    "Restriciones": "",
    "svg": 'assets/Iconos/SmartphoneGiftSimplified.svg',
  },
  {
    "tipo_incentivo": "90 Días",
    "titulo": "Pdv con Stock de",
    "subTitulo": "90 días",
    "Restriciones": "",
    "svg": 'assets/Iconos/90_dias.svg',
  }
];
