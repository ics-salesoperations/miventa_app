import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/widgets/widgets.dart';

class DetallePdvEjecucion extends StatefulWidget {
  Planning detallePdv;

  DetallePdvEjecucion({super.key, required this.detallePdv});

  @override
  State<DetallePdvEjecucion> createState() =>
      _DetallePdvEjecucionState(detallePdv: detallePdv);
}

class _DetallePdvEjecucionState extends State<DetallePdvEjecucion> {
  Planning detallePdv;

  _DetallePdvEjecucionState({required this.detallePdv});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
                    'Ejecución',
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
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Resumen de Blister ${detallePdv.invBlsFechaAct.toString() == "null" ? "SIN DATOS" : detallePdv.invBlsFechaAct.toString()}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          )),
                      const SizedBox(height: 12),
                      buildUserInfoDisplay(
                          getValue: detallePdv.grsBlsM0.toString() == "null"
                              ? "SIN DATOS"
                              : detallePdv.grsBlsM0.toString(),
                          title: "Blister M0",
                          icono: 'assets/Iconos/info_dollar.svg',
                          screenWidth: screenWidth),
                      buildUserInfoDisplay(
                        getValue: detallePdv.grsBlsM1.toString() == "null"
                            ? "SIN DATOS"
                            : detallePdv.grsBlsM1.toString(),
                        title: "Blister M1",
                        icono: 'assets/Iconos/info_dollar.svg',
                        screenWidth: screenWidth,
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.grsBlsM2.toString() == "null"
                            ? "SIN DATOS"
                            : detallePdv.grsBlsM2.toString(),
                        title: "Blister M2",
                        icono: 'assets/Iconos/info_dollar.svg',
                        screenWidth: screenWidth,
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.grsBlsM3.toString() == "null"
                            ? "SIN DATOS"
                            : detallePdv.grsBlsM3.toString(),
                        title: "Blister M3",
                        icono: 'assets/Iconos/info_dollar.svg',
                        screenWidth: screenWidth,
                      ),
                      BuildKpiInfoDisplay(
                          mesAct: detallePdv.invBls.toString(),
                          mesAnt: detallePdv.grsBls.toString(),
                          mom: detallePdv.cnvBls.toString(),
                          valor_1: "Activación Blister",
                          valor_2: "Conversión Blister",
                          title: "Asignación Blister",
                          icono: 'assets/Iconos/cashOut.svg',
                          screenWidth: screenWidth),
                      buildUserInfoDisplay(
                        getValue: detallePdv.invBlsDisp.toString() == "null"
                            ? "SIN DATOS"
                            : detallePdv.invBlsDisp.toString(),
                        title: "Inventario Disponible",
                        icono: 'assets/Iconos/info_dollar.svg',
                        screenWidth: screenWidth,
                      ),
                      buildUserInfoDisplay(
                        getValue: detallePdv.invBlsDesc.toString() == "null"
                            ? "SIN DATOS"
                            : detallePdv.invBlsDesc.toString(),
                        title: "Inventario Descartado",
                        icono: 'assets/Iconos/info_dollar.svg',
                        screenWidth: screenWidth,
                      ),
                      buildBlisterResumen(detallePdv,screenWidth)
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
