import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';

class DetalleSolicitudScreen extends StatefulWidget {
  final Solicitudes solicitud;

  const DetalleSolicitudScreen({Key? key, required this.solicitud})
      : super(key: key);

  @override
  State<DetalleSolicitudScreen> createState() => _DetalleSolicitudScreenState();
}

class _DetalleSolicitudScreenState extends State<DetalleSolicitudScreen> {
  late SyncBloc _syncBloc;

  @override
  void initState() {
    super.initState();
    _syncBloc = BlocProvider.of<SyncBloc>(context);

    _syncBloc.getRespDetalleSolicitud(
      fecha: DateFormat('yyyyMMdd:HHmmss').format(widget.solicitud.fecha!),
      formId: widget.solicitud.formId.toString(),
    );
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
                        widget.solicitud.idPdv.toString(),
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
                      widget.solicitud.formName.toString(),
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
                            .format(widget.solicitud.fecha!),
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
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      color: Colors.blueGrey[100],
                    ),
                    padding: const EdgeInsets.all(
                      8,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Detalle de Respuesta",
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 18,
                        fontFamily: 'CronosSPro',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          "Fecha solicitud: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'CronosSPro',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            DateFormat('dd/MM/yyyy HH:mm:ss')
                                .format(widget.solicitud.fecha!),
                            style: const TextStyle(
                              color: kSecondaryColor,
                              fontSize: 18,
                              fontFamily: 'CronosLPro',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          "Tipo solicitud: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'CronosSPro',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.solicitud.formName.toString(),
                            style: const TextStyle(
                              color: kSecondaryColor,
                              fontSize: 18,
                              fontFamily: 'CronosLPro',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          "ID PDV: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'CronosSPro',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.solicitud.idPdv.toString(),
                            style: const TextStyle(
                              color: kSecondaryColor,
                              fontSize: 18,
                              fontFamily: 'CronosLPro',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          "Fecha respuesta: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'CronosSPro',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.solicitud.fechaRespuesta == null
                                ? 'Sin respuesta'
                                : DateFormat('dd/MM/yyyy HH:mm:ss')
                                    .format(widget.solicitud.fechaRespuesta!),
                            style: const TextStyle(
                              color: kSecondaryColor,
                              fontSize: 18,
                              fontFamily: 'CronosLPro',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          "Estado: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'CronosSPro',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.solicitud.estado.toString(),
                            style: const TextStyle(
                              color: kSecondaryColor,
                              fontSize: 18,
                              fontFamily: 'CronosLPro',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          "Comentarios: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'CronosSPro',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.solicitud.comentarios.toString() == 'null'
                                ? ''
                                : widget.solicitud.comentarios.toString(),
                            style: const TextStyle(
                              color: kSecondaryColor,
                              fontSize: 18,
                              fontFamily: 'CronosLPro',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      color: Colors.blueGrey[100],
                    ),
                    padding: const EdgeInsets.all(
                      8,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Detalle de Solicitud",
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 18,
                        fontFamily: 'CronosSPro',
                      ),
                    ),
                  ),
                  BlocBuilder<SyncBloc, SyncState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          state.respDetalleList.isEmpty
                              ? const Text(
                                  "No se encontró el detalle de esta solicitud en tu teléfono.",
                                  style: TextStyle(
                                    fontFamily: 'CronosLPro',
                                    fontSize: 16,
                                    color: kPrimaryColor,
                                  ),
                                )
                              : Container(),
                          ...state.respDetalleList.map(
                            (e) {
                              final tipo = e.questionType;
                              Uint8List bytes = Uint8List(100000);
                              if (tipo == "Fotografia") {
                                bytes = base64.decode(e.response!);
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      e.questionText.toString() + ': ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'CronosSPro',
                                      ),
                                    ),
                                    Expanded(
                                      child: tipo != "Fotografia"
                                          ? Text(
                                              e.response.toString(),
                                              style: const TextStyle(
                                                color: kSecondaryColor,
                                                fontSize: 18,
                                                fontFamily: 'CronosLPro',
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
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  )
                ],
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
