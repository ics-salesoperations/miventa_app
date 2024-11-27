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

  @override
  void initState() {
    super.initState();

    _carritoBloc = BlocProvider.of<CarritoBloc>(context);
    _visitaBloc = BlocProvider.of<VisitaBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    int index = 0;

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
                if (modelo.tangible.toString() == 'BLISTER' &&
                    widget.pdv.segmentoPdv == 'B PDA' &&
                    widget.selectedCat.isNotEmpty) {
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
                }
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
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 12,
                                          )
                                        ]),
                                    child: Column(
                                      children: [
                                        Text(
                                          "SERIE INICIAL ",
                                          style: TextStyle(
                                            color: kFourColor.withOpacity(0.6),
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
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 12,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "SERIE FINAL",
                                          style: TextStyle(
                                            color: kFourColor.withOpacity(0.6),
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
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                            "DISPONIBLE: ",
                                            style: TextStyle(
                                              color:
                                                  kFourColor.withOpacity(0.6),
                                              fontFamily: 'CronosLPro',
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            modelo.disponible.toString(),
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
                                                idPdv: _visitaBloc.state.idPdv,
                                                idVisita:
                                                    _visitaBloc.state.idVisita,
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
                                                    BorderRadius.circular(5),
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
                                                idPdv: _visitaBloc.state.idPdv,
                                                idVisita:
                                                    _visitaBloc.state.idVisita,
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
                                                    BorderRadius.circular(5),
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
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(modelo.controller.text),
                                  SizedBox(
                                    height: 40,
                                    child: MaterialButton(
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
                                            final m =
                                                await _carritoBloc.getModelos();
                                            await _carritoBloc
                                                .crearFrmProductos(m);
                                            await _carritoBloc.actualizaTotal();
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
