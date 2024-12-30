import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/screens/detalle_modelo_screen.dart';

import '../blocs/blocs.dart';

class VisitaContentScreen extends StatefulWidget {
  final AnimationController controller;
  final List<ModeloTangible> modelos;
  final String selectedCat;
  final Planning pdv;

  const VisitaContentScreen({
    Key? key,
    required this.controller,
    required this.modelos,
    required this.selectedCat,
    required this.pdv,
  }) : super(key: key);

  @override
  State<VisitaContentScreen> createState() => _VisitaContentScreenState();
}

class _VisitaContentScreenState extends State<VisitaContentScreen> {
  late CarritoBloc _carritoBloc;
  List<int> asignados = [];

  late VisitaBloc _visitaBloc;

  final TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carritoBloc = BlocProvider.of<CarritoBloc>(context);
    _visitaBloc = BlocProvider.of<VisitaBloc>(context);
    _visitaBloc.initSaldos();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    int index = 0;
    bool advertenciaMostrada = false;

    List<ModeloTangible> filtrado = widget.modelos;
    asignados = filtrado.map((e) => e.asignado).toList();
    if (widget.selectedCat.isNotEmpty) {
      filtrado = widget.modelos
          .where((element) => element.tangible == widget.selectedCat)
          .toList();
      asignados = filtrado.map((e) => e.asignado).toList();
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        margin: EdgeInsets.only(
          top: media.padding.top + 150,
          left: 10,
          right: 10,
          bottom: 10,
        ),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                25,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white10,
                offset: Offset(1, 2),
                blurRadius: 2,
              ),
            ]),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ...filtrado.map(
              (model) {
                var modelo = model;
                if (model.modelo == _carritoBloc.state.actual.modelo) {
                  modelo = _carritoBloc.state.actual;
                }
                if (!advertenciaMostrada &&
                    modelo.tangible.toString() == 'BLISTER' &&
                    widget.pdv.segmentoPdv == 'B PDA' &&
                    widget.selectedCat.isNotEmpty) {
                  advertenciaMostrada = true;
                  return Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: kThirdColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.shade300,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Asignación no Válida!",
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'CronosSPro',
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "El punto es PDA; la asignación de Blister es únicamente para puntos de otro segmento.",
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontFamily: 'CronosPro',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if ((modelo.tangible.toString() != 'BLISTER' &&
                        widget.pdv.segmentoPdv == 'B PDA') ||
                    widget.pdv.segmentoPdv != 'B PDA') {
                  return ZoomIn(
                    //duration: const Duration(milliseconds: 200),
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 15,
                        left: 5,
                        right: 5,
                      ),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade100,
                              blurRadius: 5,
                            )
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    modelo.descripcion.toString(),
                                    style: const TextStyle(
                                      color: kSecondaryColor,
                                      fontFamily: 'CronosSPro',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                            255,
                                            247,
                                            249,
                                            249,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 12,
                                            )
                                          ]),
                                      child: Column(
                                        children: [
                                          if (modelo.modelo != 'EPIN' &&
                                              modelo.modelo != 'TMY') ...[
                                            Text(
                                              "SERIE INICIAL ",
                                              style: TextStyle(
                                                color:
                                                    kFourColor.withOpacity(0.6),
                                                fontFamily: 'CronosLPro',
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              modelo.serieInicial.toString(),
                                              style: const TextStyle(
                                                color: kSecondaryColor,
                                                fontFamily: 'CronosLPro',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                          // Otros widgets que quieras agregar
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                            255,
                                            247,
                                            249,
                                            249,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 12,
                                            )
                                          ]),
                                      child: Column(
                                        children: [
                                          if (modelo.modelo != 'EPIN' &&
                                              modelo.modelo != 'TMY') ...[
                                            Text(
                                              "SERIE FINAL ",
                                              style: TextStyle(
                                                color:
                                                    kFourColor.withOpacity(0.6),
                                                fontFamily: 'CronosLPro',
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              modelo.serieFinal.toString(),
                                              style: const TextStyle(
                                                color: kSecondaryColor,
                                                fontFamily: 'CronosLPro',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                          // Otros widgets que quieras agregar
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              modelo.modelo == 'EPIN' ||
                                                      modelo.modelo == 'TMY'
                                                  ? "MONTO A VENDER: "
                                                  : "DISPONIBLE: ",
                                              style: const TextStyle(
                                                color: kSecondaryColor,
                                                fontFamily: 'CronosLPro',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              modelo.modelo == 'EPIN' ||
                                                      modelo.modelo == 'TMY'
                                                  ? ''
                                                  : modelo.disponible
                                                      .toString(),
                                              style: const TextStyle(
                                                color: kPrimaryColor,
                                                fontFamily: 'CronosSPro',
                                                fontSize: 26,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (modelo.modelo != 'EPIN' &&
                                                modelo.modelo != 'TMY') ...[
                                              GestureDetector(
                                                onTap: () async {
                                                  final valor = modelo.asignado;

                                                  int nuevo = 0;

                                                  if (valor - 1 <= 0) {
                                                    nuevo = 0;
                                                  } else {
                                                    nuevo = valor - 1;
                                                  }

                                                  modelo = modelo.copyWith(
                                                    asignado: nuevo,
                                                  );

                                                  //Asignadndo tangible a nivel de base de datos.
                                                  await _carritoBloc
                                                      .desAsignarProducto(
                                                    modelo: modelo,
                                                    idPdv:
                                                        _visitaBloc.state.idPdv,
                                                    idVisita: _visitaBloc
                                                        .state.idVisita,
                                                  );

                                                  await _carritoBloc
                                                      .actualizaTotal();

                                                  _carritoBloc.add(
                                                      OnChangeModeloActual(
                                                          actual: modelo));
                                                  //await _carritoBloc.getModelos();
                                                  widget.controller.forward();
                                                },
                                                child: Container(
                                                  width: 25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    color: kThirdColor
                                                        .withOpacity(0.8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: kSecondaryColor
                                                            .withOpacity(0.4),
                                                        blurRadius: 3,
                                                      )
                                                    ],
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: kSecondaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 26,
                                                width: 60,
                                                child: Center(
                                                  child: Text(
                                                    modelo.asignado.toString(),
                                                    style: const TextStyle(
                                                      fontFamily: 'CronosLPro',
                                                      color: kSecondaryColor,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  final valor = modelo.asignado;
                                                  int nuevo = 0;

                                                  if (valor + 1 >=
                                                      modelo.disponible) {
                                                    nuevo = modelo.disponible;
                                                  } else {
                                                    nuevo = valor + 1;
                                                  }

                                                  modelo = modelo.copyWith(
                                                    asignado: nuevo,
                                                  );

                                                  //Asignadndo tangible a nivel de base de datos.
                                                  await _carritoBloc
                                                      .asignarProducto(
                                                    modelo: modelo,
                                                    idPdv:
                                                        _visitaBloc.state.idPdv,
                                                    idVisita: _visitaBloc
                                                        .state.idVisita,
                                                  );

                                                  await _carritoBloc
                                                      .actualizaTotal();

                                                  _carritoBloc.add(
                                                      OnChangeModeloActual(
                                                          actual: modelo));
                                                  //await _carritoBloc.getModelos();

                                                  widget.controller.forward();
                                                },
                                                child: Container(
                                                  width: 25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    color: kThirdColor
                                                        .withOpacity(0.8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: kSecondaryColor
                                                            .withOpacity(0.4),
                                                        blurRadius: 3,
                                                      )
                                                    ],
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "+",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: kSecondaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ] else ...[
                                              SizedBox(
                                                height: 50,
                                                width: 120,
                                                child: Center(
                                                  child: TextField(
                                                    controller:
                                                        _numberController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign
                                                        .center, // Centra el texto
                                                    style: const TextStyle(
                                                      fontFamily: 'CronosLPro',
                                                      color: kSecondaryColor,
                                                      fontSize: 24,
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.all(5),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: kPrimaryColor,
                                                          width:
                                                              2.0, // Ancho del borde
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: kPrimaryColor,
                                                          width:
                                                              2.0, // Ancho del borde
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: kPrimaryColor,
                                                          width:
                                                              2.0, // Ancho del borde
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(modelo.controller.text),
                                    SizedBox(
                                      height: 40,
                                      child: modelo.modelo == 'EPIN' ||
                                              modelo.modelo == 'TMY'
                                          ? MaterialButton(
                                              elevation: 0,
                                              color: kPrimaryColor,
                                              child: const Text(
                                                'Guardar',
                                                style: TextStyle(
                                                  color: kSecondaryColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              onPressed: () async {
                                                final int? number =
                                                    int.tryParse(
                                                        _numberController.text);
                                                if (number == null ||
                                                    number <= 0) {
                                                  const snackBar = SnackBar(
                                                    content: Center(
                                                      child: Text(
                                                        'El saldo debe ser mayor a 0',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                } else {
                                                  await _carritoBloc
                                                      .guardarModeloSaldo(
                                                          modelo: modelo);
                                                  await _carritoBloc
                                                      .asignarSaldos(
                                                    cantidad: number,
                                                    modelo: modelo,
                                                    idPdv:
                                                        _visitaBloc.state.idPdv,
                                                    idVisita: _visitaBloc
                                                        .state.idVisita,
                                                  );
                                                  final snackBar = SnackBar(
                                                    content: Center(
                                                      child: Text(
                                                        '${modelo.modelo} datos guardados correctamente',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        kPrimaryColor,
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                }
                                              },
                                            )
                                          : MaterialButton(
                                              elevation: 0,
                                              color: kPrimaryColor,
                                              child: const FaIcon(
                                                FontAwesomeIcons.barcode,
                                                size: 16,
                                                color: kSecondaryColor,
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DetalleModeloScreen(
                                                    modelo: modelo,
                                                  ),
                                                ).then((value) async {
                                                  final m = await _carritoBloc
                                                      .getModelos();
                                                  await _carritoBloc
                                                      .crearFrmProductos(m);
                                                  await _carritoBloc
                                                      .actualizaTotal();
                                                });
                                              }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
