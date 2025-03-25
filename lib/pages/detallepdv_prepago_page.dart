import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/pages/modificar_form_page.dart';
import 'package:miventa_app/widgets/widgets.dart';

class DetallePdvPre extends StatefulWidget {
  Planning detallePdv;

  DetallePdvPre({super.key, required this.detallePdv});

  @override
  State<DetallePdvPre> createState() =>
      _DetallePdvPreState(detallePdv: detallePdv);
}

class _DetallePdvPreState extends State<DetallePdvPre> {
  Planning detallePdv;

  _DetallePdvPreState({required this.detallePdv});

  @override
  Widget build(BuildContext context) {
    double screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    'Indicadores Prepago',
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
                  width: 240,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildUserInfoDisplay(
                        getValue: detallePdv.qbrMbl == "null"
                            ? "SIN DATOS"
                            : detallePdv.qbrMbl.toString(),
                        screenWidth: screenHeigth,
                        title: "Quiebre Mbl",
                        icono: 'assets/Iconos/info_dollar.svg',
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.anomesActBlncMbl == "null"
                            ? "SIN DATOS"
                            : 'L. ' + detallePdv.anomesActBlncMbl.toString(),
                        title: "Saldo Mbl",
                        icono: 'assets/Iconos/info_dollar.svg',
                        screenWidth: screenHeigth,
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.fechaVisitaVen == "null"
                            ? "SIN DATOS"
                            : detallePdv.fechaVisitaVen.toString(),
                        title: "Fecha Visita",
                        icono: 'assets/Iconos/frecuencia.svg',
                        screenWidth: screenHeigth,
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.nombreVendedor == "null"
                            ? "SIN DATOS"
                            : detallePdv.nombreVendedor.toString(),
                        title: "Nombre Vendedor",
                        icono: 'assets/Iconos/frecuencia.svg',
                        screenWidth: screenHeigth,
                      ),
                      BuildKpiInfoDisplay(
                        mesAct: 'L. ' + detallePdv.anomesActEpin.toString(),
                        mesAnt: 'L. ' + detallePdv.anomesAntEpin.toString(),
                        mom: detallePdv.epinMom.toString(),
                        title: "Epin",
                        icono: 'assets/Iconos/info_dollar.svg',
                        screenWidth: screenHeigth,
                      ),
                      buildUserInfoDisplay(
                        getValue: 'L. ' + detallePdv.epinMiTienda.toString(),
                        title: "Epin Mi Tienda",
                        icono: 'assets/Iconos/info_dollar.svg',
                        screenWidth: screenHeigth,
                      ),
                      BuildKpiInfoDisplay(
                        mesAct: detallePdv.anomesActGross.toString(),
                        mesAnt: detallePdv.anomesAntGross.toString(),
                        mom: detallePdv.grossMom.toString(),
                        title: "Gross",
                        icono: 'assets/Iconos/info_dollar.svg',
                        screenWidth: screenHeigth,
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.fechaFD11 == null
                            ? "SIN DATOS"
                            : DateFormat('dd-MM-yyyy')
                                .format(detallePdv.fechaFD11!),
                        title: "Fecha FORDIS 11",
                        icono: 'assets/Iconos/frecuencia.svg',
                        screenWidth: screenHeigth,
                      ),
                      buildLocalKpiInfoDisplay(
                        getValue:
                            detallePdv.fd11 == "null" || detallePdv.fd11 == null
                                ? "SIN DATOS"
                                : detallePdv.fd11.toString(),
                        title: "Detalle FORDIS 11",
                        icono: 'assets/Iconos/frecuencia.svg',
                        screenHeight: screenHeigth,
                        screenWidth: screenHeigth,
                        esFormulario: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModificarFormPage(
                                detallePdv: detallePdv,
                                idForm: "31",
                              ),
                            ),
                          );
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
    );
  }
}

Widget buildLocalKpiInfoDisplay({
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
                height: 80,
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
                            height: 80,
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
                            maxLines: 3,
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
