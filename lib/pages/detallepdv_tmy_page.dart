import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/widgets/widgets.dart';

class DetallePdvTmy extends StatefulWidget {
  Planning detallePdv;

  DetallePdvTmy({super.key, required this.detallePdv});

  @override
  State<DetallePdvTmy> createState() =>
      _DetallePdvTmyState(detallePdv: detallePdv);
}

class _DetallePdvTmyState extends State<DetallePdvTmy> {
  Planning detallePdv;

  _DetallePdvTmyState({required this.detallePdv});

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
                    'Indicadores TMY',
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
                      buildUserInfoDisplay(
                          getValue: detallePdv.qbrTmy.toString() == "null"
                              ? "SIN DATOS"
                              : detallePdv.qbrTmy.toString(),
                          title: "Quiebre TMY",
                          icono: 'assets/Iconos/info_dollar.svg',
                          screenWidth: screenWidth),
                      buildUserInfoDisplay(
                        getValue:
                            detallePdv.anomesActBlncTmy.toString() == "null"
                                ? "SIN DATOS"
                                : detallePdv.anomesActBlncTmy.toString(),
                        title: "Saldo TMY",
                        icono: 'assets/Iconos/info_dollar.svg',
                        screenWidth: screenWidth,
                      ),
                      BuildKpiInfoDisplay(
                        mesAct: detallePdv.anomesActCashin.toString(),
                        mesAnt: detallePdv.anomesAntCashin.toString(),
                        mom: detallePdv.cashinMom.toString(),
                        title: "Cash In",
                        icono: 'assets/Iconos/cashIn.svg',
                        screenWidth: screenWidth,
                      ),
                      BuildKpiInfoDisplay(
                          mesAct: detallePdv.anomesActCashout.toString(),
                          mesAnt: detallePdv.anomesAntCashout.toString(),
                          mom: detallePdv.cashoutMom.toString(),
                          title: "Cash Out",
                          icono: 'assets/Iconos/cashOut.svg',
                          screenWidth: screenWidth),
                      BuildKpiInfoDisplay(
                          mesAct: detallePdv.anomesActPagos.toString(),
                          mesAnt: detallePdv.anomesAntPagos.toString(),
                          mom: detallePdv.pagosMom.toString(),
                          title: "Pagos",
                          icono: 'assets/Iconos/Billpayment.svg',
                          screenWidth: screenWidth),
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
