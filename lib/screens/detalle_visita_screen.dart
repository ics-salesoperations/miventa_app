import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';

class DetalleVisitaScreen extends StatefulWidget {
  final Planning pdv;
  final String idVisita;
  final DateTime fechaVisita;
  final String tipo;

  const DetalleVisitaScreen({
    Key? key,
    required this.pdv,
    required this.idVisita,
    required this.fechaVisita,
    required this.tipo,
  }) : super(key: key);

  @override
  State<DetalleVisitaScreen> createState() => _DetalleVisitaScreenState();
}

class _DetalleVisitaScreenState extends State<DetalleVisitaScreen> {
  late SyncBloc _syncBloc;

  @override
  void initState() {
    super.initState();
    _syncBloc = BlocProvider.of<SyncBloc>(context);
    if (widget.tipo == 'VISITA') {
      _syncBloc.cargarDetalleVisita(idVisita: widget.idVisita);
    } else {
      _syncBloc.getRespDetalle(instanceId: widget.idVisita);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.08,
            left: MediaQuery.of(context).size.width * 0.05),
        //padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: 110,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "ID PDV: ",
                        style: TextStyle(
                          color: kFourColor,
                          fontFamily: 'CronosLPro',
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.pdv.idPdv.toString(),
                        style: const TextStyle(
                          color: kSecondaryColor,
                          fontFamily: 'CronosLPro',
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Text(
                      widget.pdv.nombrePdv.toString(),
                      maxLines: 2,
                      style: const TextStyle(
                        color: kSecondaryColor,
                        fontFamily: 'CronosSPro',
                        fontSize: 22,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Fecha Visita: ",
                        style: TextStyle(
                          color: kFourColor,
                          fontFamily: 'CronosLPro',
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy HH:mm:ss')
                            .format(widget.fechaVisita),
                        style: const TextStyle(
                          color: kSecondaryColor,
                          fontFamily: 'CronosLPro',
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 110,
              ),
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 8,
                  )
                ],
              ),
              child: BlocBuilder<SyncBloc, SyncState>(
                builder: (context, state) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text(
                          widget.tipo == "VISITA"
                              ? "Detalle del Producto"
                              : "Detalle del Formulario",
                          style: const TextStyle(
                            color: kSecondaryColor,
                            fontSize: 18,
                            fontFamily: 'CronosSPro',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ...state.detalleVisita
                          .map(
                            (e) => FadeInLeft(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: kSecondaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 245, 245, 243),
                                      spreadRadius: 4,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "MODELO: ",
                                          style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 18,
                                            fontFamily: 'CronosLpro',
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            e.descModelo.toString(),
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: 'CronosLpro',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "SERIE: ",
                                          style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 18,
                                            fontFamily: 'CronosLpro',
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            e.serie.toString(),
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: 'CronosLpro',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "ESTADO: ",
                                          style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 18,
                                            fontFamily: 'CronosLpro',
                                          ),
                                        ),
                                        Text(
                                          e.enviado == 1
                                              ? "Enviado"
                                              : "Sin Enviar",
                                          maxLines: 2,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'CronosLpro',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      ...state.respDetalleList.map(
                        (e) {
                          final tipo = e.questionType;
                          Uint8List bytes = Uint8List(100000);
                          if (tipo == "Fotografia") {
                            bytes = base64.decode(e.response!);
                          }
                          return FadeInRight(
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                bottom: 10,
                              ),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 7,
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16,
                                          child: Text(
                                            e.questionText.toString(),
                                            style: const TextStyle(
                                              fontFamily: 'CronosSPro',
                                              fontSize: 14,
                                              color: kFourColor,
                                            ),
                                          ),
                                        ),
                                        tipo != "Fotografia"
                                            ? Text(
                                                e.response.toString(),
                                                maxLines: 5,
                                                style: const TextStyle(
                                                  fontFamily: 'CronosLPro',
                                                  fontSize: 16,
                                                  color: kSecondaryColor,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            : SizedBox(
                                                height: 160,
                                                width: 160,
                                                child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Image.memory(
                                                    bytes,
                                                    width: 120,
                                                    height: 120,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  FadeInDown(
                                    delay: const Duration(
                                      milliseconds: 100,
                                    ),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: e.enviado == "SI"
                                            ? kSecondaryColor.withOpacity(0.8)
                                            : kThirdColor.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      child: e.enviado == "SI"
                                          ? const FaIcon(
                                              Icons.cloud_done,
                                              size: 16,
                                              color: kPrimaryColor,
                                            )
                                          : const FaIcon(
                                              Icons.signal_wifi_off,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: kFourColor.withOpacity(0.8),
                  radius: 16,
                  child: const FaIcon(
                    FontAwesomeIcons.xmark,
                    size: 22,
                    color: kThirdColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
