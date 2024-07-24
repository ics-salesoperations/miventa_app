import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({Key? key}) : super(key: key);

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.9,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
        ),
        child: BlocBuilder<FormularioBloc, FormularioState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/processing.json',
                  width: 250,
                  height: 350,
                  animate: true,
                ),
                (state.sinProcesar + state.procesado) <= 0
                    ? Container()
                    : LinearPercentIndicator(
                        width: 250,
                        lineHeight: 16,
                        percent: state.procesado /
                            (state.procesado + state.sinProcesar),
                        backgroundColor: kThirdColor,
                        progressColor: kPrimaryColor,
                        alignment: MainAxisAlignment.center,
                        animateFromLastPercent: true,
                        addAutomaticKeepAlive: true,
                        barRadius: const Radius.circular(10),
                        center: Text(
                          "${state.procesado * 100 ~/ (state.procesado + state.sinProcesar)}%",
                          style: const TextStyle(
                            fontFamily: 'CronosSPro',
                            fontSize: 14,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffcccaaa),
                        blurRadius: 5,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            state.guardado
                                ? 'assets/Iconos/done.svg'
                                : 'assets/Iconos/warning.svg',
                            height: 20,
                          ),
                          const Text(
                            " Guardado localmente: ",
                            style: TextStyle(
                              fontFamily: 'CronosLPro',
                              fontSize: 16,
                              color: kSecondaryColor,
                            ),
                          ),
                          Text(
                            state.guardado ? "Exitoso" : "En proceso",
                            style: const TextStyle(
                              fontFamily: 'CronosLPro',
                              fontSize: 16,
                              color: kSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            state.enviado
                                ? 'assets/Iconos/done.svg'
                                : 'assets/Iconos/warning.svg',
                            height: 20,
                          ),
                          const Text(
                            " Enviado: ",
                            style: TextStyle(
                              fontFamily: 'CronosLPro',
                              fontSize: 16,
                              color: kSecondaryColor,
                            ),
                          ),
                          Text(
                            state.enviado ? "Exitoso" : "Sin Exito",
                            style: const TextStyle(
                              fontFamily: 'CronosLPro',
                              fontSize: 16,
                              color: kSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            "       Porcentaje enviado: ",
                            style: TextStyle(
                              fontFamily: 'CronosLPro',
                              fontSize: 16,
                              color: kSecondaryColor,
                            ),
                          ),
                          Text(
                            (state.sinProcesar + state.procesado) <= 0
                                ? "0%"
                                : "${state.procesado * 100 ~/ (state.procesado + state.sinProcesar)}%",
                            style: const TextStyle(
                              fontFamily: 'CronosLPro',
                              fontSize: 16,
                              color: kSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Observación: ",
                            style: TextStyle(
                              fontFamily: 'CronosLPro',
                              fontSize: 16,
                              color: kSecondaryColor,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              state.mensaje,
                              style: const TextStyle(
                                  fontFamily: 'CronosLPro',
                                  fontSize: 16,
                                  color: kSecondaryColor,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  elevation: 4,
                  color: Colors.white,
                  onPressed: state.mensaje == 'Actualizando despues de enviado.'
                      ? null
                      : () {
                          Navigator.pop(context);
                        },
                  child: const Text(
                    "Cerrar",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontFamily: 'CronosLPro',
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
