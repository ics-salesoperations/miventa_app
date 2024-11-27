import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';

class DetalleModeloReasignacionScreen extends StatefulWidget {
  final ModeloTangible modelo;

  const DetalleModeloReasignacionScreen({
    Key? key,
    required this.modelo,
  }) : super(key: key);

  @override
  State<DetalleModeloReasignacionScreen> createState() =>
      _DetalleModeloReasignacionScreenState();
}

class _DetalleModeloReasignacionScreenState
    extends State<DetalleModeloReasignacionScreen> {
  late CarritoReasignacionBloc carritoBloc;
  late VisitaBloc visitaBloc;
  final ScrollController _seriesScrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    carritoBloc = BlocProvider.of<CarritoReasignacionBloc>(context);
    visitaBloc = BlocProvider.of<VisitaBloc>(context);

    carritoBloc.getTangiblePorModelo(
      modelo: widget.modelo,
      idPdv: visitaBloc.state.idPdv,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      //padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: BlocBuilder<CarritoReasignacionBloc, CarritoReasignacionState>(
        builder: (context, state) {
          if (state.cargandoLstTangibleModelo) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Estamos cargando el detalle de las series.",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontFamily: 'CronosLPro',
                  ),
                ),
              ],
            );
          }

          if (state.lstTangibleModelo.isEmpty) {
            return const Center(
              child: Text(
                "No tienes producto disponible de este modelo.",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontFamily: 'CronosLPro',
                ),
              ),
            );
          }

          final lstAsignados =
              state.lstTangibleModelo.where((e) => e.asignado == 1).toList();
          final lstDescartados =
              state.lstTangibleModelo.where((e) => e.descartado == 1).toList();

          int orden = 0;
          List<ProductoTangibleReasignacion> lstSeries = [];
          if (state.filter.isEmpty) {
            lstSeries = state.lstTangibleModelo;
          } else {
            lstSeries = state.lstTangibleModelo
                .where((e) => e.serie.toString().contains(state.filter))
                .toList();
          }

          return Column(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: double.infinity,
                        ),
                        SvgPicture.asset(
                          'assets/pdv.svg',
                          height: 125,
                          semanticsLabel: 'Label',
                          color: kScaffoldBackground,
                        ),
                        Text(
                          widget.modelo.descripcion.toString(),
                          style: const TextStyle(
                            color: kSecondaryColor,
                            fontSize: 18,
                            fontFamily: 'CronosSPro',
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        )
                      ],
                    ),
                    Positioned(
                      right: -20,
                      top: 0,
                      child: RawMaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.circleXmark,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 0,
                      child: _DisponiblesCard(widget: widget),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 0,
                      child: _AsignadosCard(
                        asignados: lstAsignados.length,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 135,
                      right:
                          135, // Esto asegura que esté centrado horizontalmente
                      child: _DescartadosCard(
                        descartados: lstDescartados.length,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12),
                child: _BuscarSerie(modelo: widget.modelo),
              ),
              Container(
                height: 45,
                padding: const EdgeInsets.only(right: 12, bottom: 10),
                child: AsignacionMultipleReasignacion(
                  modelo: widget.modelo,
                ),
              ),
              Expanded(
                child: ListView(
                  controller: _seriesScrollCtrl,
                  children: [
                    ...lstSeries.map((p) {
                      orden++;

                      ProductoTangibleReasignacion producto = p;

                      return FlipInX(
                        delay: const Duration(milliseconds: 70),
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.black12,
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 45,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  orden.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'CronosLPro',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          // Logic when arrow icon is tapped
                                          await carritoBloc.asignarProducto(
                                            modelo: widget.modelo,
                                            serie: producto.serie,
                                            idPdv: visitaBloc.state.idPdv,
                                            idVisita: visitaBloc.state.idVisita,
                                          );
                                        },
                                        child: const Icon(
                                          Icons.arrow_right,
                                          color: kPrimaryColor,
                                          size: 16,
                                        ),
                                      ),
                                      Text(
                                        producto.serie.toString(),
                                        style: const TextStyle(
                                          fontFamily: 'CronosLPro',
                                          fontSize: 14,
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy HH:mm:ss')
                                        .format(producto.fechaAsignacion!),
                                    style: const TextStyle(
                                      fontFamily: 'CronosLPro',
                                      fontSize: 14,
                                      color: kFourColor,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  // Logic for assigning the product
                                  await carritoBloc.asignarProducto(
                                    modelo: widget.modelo,
                                    serie: producto.serie,
                                    idPdv: visitaBloc.state.idPdv,
                                    idVisita: visitaBloc.state.idVisita,
                                  );
                                },
                                child: producto.asignado == 1
                                    ? const Icon(
                                        Icons.check_circle_outline,
                                        color: kSecondaryColor,
                                        size: 24,
                                      )
                                    : const Icon(
                                        Icons.radio_button_unchecked,
                                        color: kFourColor,
                                        size: 24,
                                      ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  // Logic for assigning the product
                                  await carritoBloc.descartarProducto(
                                    modelo: widget.modelo,
                                    serie: producto.serie,
                                    idPdv: visitaBloc.state.idPdv,
                                    idVisita: visitaBloc.state.idVisita,
                                  );
                                },
                                child: producto.descartado == 1
                                    ? const Icon(
                                        Icons.block_outlined,
                                        color: kSecondaryColor,
                                        size: 24,
                                      )
                                    : const Icon(
                                        Icons.radio_button_unchecked,
                                        color: kFourColor,
                                        size: 24,
                                      ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList()
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BuscarSerie extends StatefulWidget {
  final ModeloTangible modelo;

  const _BuscarSerie({
    required this.modelo,
  });

  @override
  State<_BuscarSerie> createState() => _BuscarSerieState();
}

class _BuscarSerieState extends State<_BuscarSerie> {
  late CarritoReasignacionBloc carritoBloc;

  @override
  void initState() {
    carritoBloc = BlocProvider.of<CarritoReasignacionBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filtroCtrl = TextEditingController(text: carritoBloc.state.filter);
    //corregir posicion del cursos a el final.
    filtroCtrl.selection = TextSelection.fromPosition(
        TextPosition(offset: filtroCtrl.text.length));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              width: 140,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 5)
                    ]),
                child: TextField(
                  onChanged: (valor) {
                    carritoBloc.add(
                      OnCambiarFiltroReasignacionEvent(
                        filtro: valor == "-1" ? "" : valor,
                      ),
                    );
                  },
                  controller: filtroCtrl,
                  enableInteractiveSelection: true,
                  textAlignVertical: TextAlignVertical.center,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: 'Ingrese una serie',
                    suffixIcon: carritoBloc.state.filter.isNotEmpty
                        ? IconButton(
                            padding: const EdgeInsets.all(0),
                            iconSize: 14,
                            icon: const FaIcon(
                              FontAwesomeIcons.filterCircleXmark,
                              size: 14,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              carritoBloc.add(
                                const OnCambiarFiltroReasignacionEvent(
                                    filtro: ""),
                              );
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () async {
              try {
                String barcode = await FlutterBarcodeScanner.scanBarcode(
                  "#ff6666",
                  "Cancelar",
                  false,
                  ScanMode.BARCODE,
                );

                filtroCtrl.text = barcode == "-1" ? "" : barcode;
                carritoBloc.add(OnCambiarFiltroReasignacionEvent(
                  filtro: barcode,
                ));
              } catch (e) {
                null;
              }
            },
            icon: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kFourColor.withOpacity(0.1),
              ),
              child: const FaIcon(
                FontAwesomeIcons.barcode,
                size: 22,
                color: kPrimaryColor,
              ),
            ),
          ),
          IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () async {
              String barcode = await FlutterBarcodeScanner.scanBarcode(
                "#ff6666",
                "Cancelar",
                false,
                ScanMode.QR,
              );
              filtroCtrl.text = barcode;
              carritoBloc
                  .add(OnCambiarFiltroReasignacionEvent(filtro: barcode));
            },
            icon: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kFourColor.withOpacity(0.1),
              ),
              child: const FaIcon(
                FontAwesomeIcons.qrcode,
                size: 22,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AsignacionMultipleReasignacion extends StatefulWidget {
  final ModeloTangible modelo;

  const AsignacionMultipleReasignacion({
    super.key,
    required this.modelo,
  });

  @override
  State<AsignacionMultipleReasignacion> createState() =>
      _AsignacionMultipleReasignacionState();
}

class _AsignacionMultipleReasignacionState
    extends State<AsignacionMultipleReasignacion> {
  late CarritoReasignacionBloc carritoBloc;
  late VisitaBloc visitaBloc;
  final asignacionCtrl = TextEditingController();

  @override
  void initState() {
    carritoBloc = BlocProvider.of<CarritoReasignacionBloc>(context);
    visitaBloc = BlocProvider.of<VisitaBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 100,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                    )
                  ]),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: asignacionCtrl,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'CronosLPro',
                  fontSize: 16,
                ),
                enableInteractiveSelection: true,
                textAlignVertical: TextAlignVertical.center,
                autocorrect: false,
                inputFormatters: [
                  TextInputFormatter.withFunction(
                    (oldValue, newValue) {
                      return (newValue.text.isEmpty
                                  ? 0
                                  : int.parse(newValue.text)) >
                              widget.modelo.disponible
                          ? oldValue
                          : newValue;
                    },
                  ),
                ],
                onChanged: (value) {},
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Ink(
            decoration: const ShapeDecoration(
                color: kSecondaryColor,
                shape: CircleBorder(),
                shadows: [
                  BoxShadow(
                    color: Colors.grey,
                  )
                ]),
            child: IconButton(
              highlightColor: kSecondaryColor,
              splashRadius: 22,
              padding: const EdgeInsets.all(10),
              onPressed: () async {
                await carritoBloc.asignarProductoMasivo(
                  modelo: widget.modelo,
                  idPdv: visitaBloc.state.idPdv,
                  idVisita: visitaBloc.state.idVisita,
                  cantidad: asignacionCtrl.text.isEmpty
                      ? 0
                      : int.parse(asignacionCtrl.text),
                );
              },
              icon: const Icon(
                Icons.check_box_outlined,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Ink(
            decoration: const ShapeDecoration(
                color: kSecondaryColor,
                shape: CircleBorder(),
                shadows: [
                  BoxShadow(
                    color: Colors.grey,
                  )
                ]),
            child: IconButton(
              onPressed: () async {
                await carritoBloc.desasignarProductoMasivo(
                  modelo: widget.modelo,
                  idPdv: visitaBloc.state.idPdv,
                  idVisita: visitaBloc.state.idVisita,
                  cantidad: asignacionCtrl.text.isEmpty
                      ? 0
                      : int.parse(asignacionCtrl.text),
                );
              },
              icon: const Icon(
                Icons.check_box_outline_blank_outlined,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DisponiblesCard extends StatelessWidget {
  const _DisponiblesCard({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final DetalleModeloReasignacionScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 100,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: kThirdColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            widget.modelo.disponible.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'CronosSPro',
            ),
          ),
          const Text(
            "Disponibles",
            style: TextStyle(
              color: kFourColor,
              fontSize: 16,
              fontFamily: 'CronosLPro',
            ),
          ),
        ],
      ),
    );
  }
}

class _AsignadosCard extends StatelessWidget {
  const _AsignadosCard({
    Key? key,
    required this.asignados,
  }) : super(key: key);

  final int asignados;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 100,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: kThirdColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            asignados.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'CronosSPro',
            ),
          ),
          const Text(
            "Reasignados",
            style: TextStyle(
              color: kFourColor,
              fontSize: 16,
              fontFamily: 'CronosLPro',
            ),
          ),
        ],
      ),
    );
  }
}

class _DescartadosCard extends StatelessWidget {
  const _DescartadosCard({
    Key? key,
    required this.descartados,
  }) : super(key: key);

  final int descartados;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 100,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: kThirdColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            descartados.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'CronosSPro',
            ),
          ),
          const Text(
            "Descartados",
            style: TextStyle(
              color: kFourColor,
              fontSize: 16,
              fontFamily: 'CronosLPro',
            ),
          ),
        ],
      ),
    );
  }
}
