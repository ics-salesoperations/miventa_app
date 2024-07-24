import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/screens/screens.dart';

import '../blocs/blocs.dart';

class CestaPdvScreen extends StatefulWidget {
  final Planning pdv;

  const CestaPdvScreen({Key? key, required this.pdv}) : super(key: key);

  @override
  State<CestaPdvScreen> createState() => _CestaPdvScreenState();
}

class _CestaPdvScreenState extends State<CestaPdvScreen> {
  late CarritoBloc _carritoBloc;
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _carritoBloc = BlocProvider.of<CarritoBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _carritoBloc.getModelosAsignados(
      pdv: widget.pdv,
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.only(
            top: media.padding.top + 10,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          //padding: const EdgeInsets.all(20),
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white10,
                  offset: Offset(1, 2),
                  blurRadius: 2,
                ),
              ]),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.only(
                      left: 60,
                      right: 12,
                      top: 12,
                      bottom: 12,
                    ),
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            color: Colors.black12,
                          )
                        ]),
                    child: Text(
                      widget.pdv.idPdv.toString() +
                          " - " +
                          widget.pdv.nombrePdv.toString(),
                      style: const TextStyle(
                        color: kSecondaryColor,
                        fontFamily: 'CronosSPro',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 10,
                    top: 30,
                    child: Icon(
                      FontAwesomeIcons.bagShopping,
                      size: 55,
                      color: kSecondaryColor,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          false,
                        );
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.circleXmark,
                        color: kSecondaryColor,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Resumen de Compra",
                style: TextStyle(
                  color: kFourColor,
                  fontSize: 22,
                  fontFamily: 'CronosSPro',
                ),
              ),
              Expanded(
                child: Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(252, 251, 248, 242),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: BlocBuilder<CarritoBloc, CarritoState>(
                    builder: (context, state) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.modelosAsignados.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final modelo = state.modelosAsignados[index];
                          return SlideInLeft(
                            delay: Duration(milliseconds: index * 100),
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: kThirdColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    margin: const EdgeInsets.only(left: 15),
                                    child: FaIcon(
                                      modelo.tangible.toString() ==
                                              "SMARTHPHONES"
                                          ? FontAwesomeIcons.mobileScreen
                                          : modelo.tangible.toString() ==
                                                  "SCRATCHCARD"
                                              ? FontAwesomeIcons.creditCard
                                              : modelo.tangible.toString() ==
                                                      "SIMCARD"
                                                  ? FontAwesomeIcons.simCard
                                                  : modelo.tangible
                                                              .toString() ==
                                                          "BLISTER"
                                                      ? FontAwesomeIcons
                                                          .addressCard
                                                      : modelo.tangible
                                                                  .toString() ==
                                                              "ACCESS CARD MFS"
                                                          ? FontAwesomeIcons
                                                              .creditCard
                                                          : FontAwesomeIcons
                                                              .cartPlus,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      modelo.modelo.toString() == 'SMARTHPHONES'
                                          ? 'SMARTPHONES'
                                          : modelo.tangible.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'CronosSPro',
                                        color: kSecondaryColor,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: -10,
                                    top: 10,
                                    child: FaIcon(
                                      modelo.tangible.toString() ==
                                              "SMARTHPHONES"
                                          ? FontAwesomeIcons.mobileScreen
                                          : modelo.tangible.toString() ==
                                                  "SCRATCHCARD"
                                              ? FontAwesomeIcons.creditCard
                                              : modelo.tangible.toString() ==
                                                      "SIMCARD"
                                                  ? FontAwesomeIcons.simCard
                                                  : modelo.tangible
                                                              .toString() ==
                                                          "BLISTER"
                                                      ? FontAwesomeIcons
                                                          .addressCard
                                                      : modelo.tangible
                                                                  .toString() ==
                                                              "ACCESS CARD MFS"
                                                          ? FontAwesomeIcons
                                                              .creditCard
                                                          : FontAwesomeIcons
                                                              .cartPlus,
                                      color: Colors.black12,
                                      size: 90,
                                    ),
                                  ),
                                  Positioned(
                                    right: 12,
                                    top: 0,
                                    child: SizedBox(
                                      height: 60,
                                      child: Align(
                                        child: Text(
                                          modelo.asignado.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'CronosSPro',
                                            fontSize: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<CarritoBloc, CarritoState>(
                builder: (context, state) {
                  if (state.validandoBlister) {
                    return Container(
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            kSecondaryColor,
                            kSecondaryColor.withOpacity(0.9),
                            kSecondaryColor.withOpacity(0.8),
                            kPrimaryColor
                          ],
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            state.mensaje,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'CronosLPro',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (!state.blisterValidado) {
                    return Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          const Text(
                            "Este PDV no tiene el servicio BLISTER asignado, ¿Deseas adicionar el servicio?",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'CronosLPro',
                              color: kSecondaryColor,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MaterialButton(
                                onPressed: () async {
                                  await _carritoBloc.enviarAlarmaBlister(
                                    pdv: widget.pdv,
                                    usuario: _authBloc.state.usuario.usuario
                                        .toString(),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Agregar",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'CronosLPro',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Cancelar",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'CronosLPro',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }

                  return MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ProcessingVenta(pdv: widget.pdv),
                      );
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            kSecondaryColor,
                            kSecondaryColor.withOpacity(0.9),
                            kSecondaryColor.withOpacity(0.8),
                            kPrimaryColor
                          ],
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Confirmar compra",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'CronosLPro',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
