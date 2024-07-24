import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/circuito.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskTile extends StatelessWidget {
  final Circuito circuito;
  final List<Circuito> segmentado;

  const TaskTile({
    Key? key,
    required this.circuito,
    required this.segmentado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 24,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 35.0, right: 22),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Text(
              'Circuito ' + circuito.nombreCircuito!,
              style: TextStyle(
                color: kSecondaryColor.withOpacity(0.6),
                fontSize: 20,
                fontFamily: 'CronosSPro',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0, right: 22),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.topCenter,
              height: 225.0,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.only(
                top: 25,
                left: 20,
                right: 20,
                bottom: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(75),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 214, 212, 212),
                    offset: Offset(1, 1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 2,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      kThirdColor.withOpacity(0.3),
                                      kThirdColor.withOpacity(0.7),
                                      kThirdColor,
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Total Circuito",
                                    style: TextStyle(
                                      fontFamily: 'CronosLPro',
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Lottie.asset(
                                        'assets/lottie/pdv.json',
                                        width: 24,
                                        height: 24,
                                        animate: true,
                                      ),
                                      Text(
                                        " ${circuito.cantidad}",
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: 'CronosSPro',
                                        ),
                                      ),
                                      const Text(
                                        " PDVs",
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: 'CronosLPro',
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 2,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      kThirdColor.withOpacity(0.3),
                                      kThirdColor.withOpacity(0.7),
                                      kThirdColor,
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Total Visitados",
                                    style: TextStyle(
                                      fontFamily: 'CronosLPro',
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Lottie.asset(
                                        'assets/lottie/pdv_abierto.json',
                                        width: 24,
                                        height: 24,
                                        animate: true,
                                      ),
                                      Text(
                                        " ${circuito.visitado}",
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: 'CronosSPro',
                                        ),
                                      ),
                                      const Text(
                                        "  PDVs",
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: 'CronosLPro',
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: CircularPercentIndicator(
                          radius: 40,
                          circularStrokeCap: CircularStrokeCap.round,
                          percent: (circuito.visitado! / circuito.cantidad!),
                          backgroundColor: kThirdColor,
                          animationDuration: 1000,
                          center: Text(
                            "${(circuito.visitado! * 100 / circuito.cantidad!).toStringAsFixed(0)}%",
                            style: const TextStyle(
                              color: kSecondaryColor,
                              fontFamily: 'CronosSPro',
                              fontSize: 22,
                            ),
                          ),
                          backgroundWidth: 5,
                          lineWidth: 10,
                          linearGradient: LinearGradient(
                            colors: [
                              kSecondaryColor,
                              kSecondaryColor.withOpacity(0.9),
                              kSecondaryColor.withOpacity(0.8),
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.2),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: false,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ...segmentado.map(
                          (e) => Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.segmentoPdv.toString(),
                                    style: const TextStyle(
                                        color: kSecondaryColor,
                                        fontFamily: 'CronosSPro'),
                                  ),
                                  LinearPercentIndicator(
                                    padding: const EdgeInsets.all(0),
                                    width: 80,
                                    lineHeight: 3,
                                    percent: (e.visitado! / e.cantidad!),
                                    backgroundColor:
                                        kPrimaryColor.withOpacity(0.7),
                                    progressColor:
                                        kSecondaryColor.withOpacity(0.6),
                                    barRadius: const Radius.circular(12),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        (e.cantidad! - e.visitado!).toString(),
                                        style: TextStyle(
                                          color: kPrimaryColor.withOpacity(0.6),
                                          fontFamily: 'CronosSPro',
                                        ),
                                      ),
                                      Text(
                                        " restantes",
                                        style: TextStyle(
                                          color: kPrimaryColor.withOpacity(0.6),
                                          fontFamily: 'CronosLPro',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ]);
  }
}
