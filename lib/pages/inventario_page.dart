import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/db_service.dart';
import 'package:miventa_app/widgets/widgets.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
//import 'package:elegant_notification/elegant_notification.dart';

class InventarioPage extends StatefulWidget {
  const InventarioPage({Key? key}) : super(key: key);
  @override
  _InventarioPageState createState() => _InventarioPageState();
}

class _InventarioPageState extends State<InventarioPage> {
  late InventarioBloc inventarioBloc;
  DBService db = DBService();

  @override
  void initState() {
    super.initState();
    inventarioBloc = BlocProvider.of<InventarioBloc>(context);
    inventarioBloc.cargarInventario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: HeaderPicoPainter(),
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 15,
              left: 15,
              right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Inventario",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontFamily: 'CronosSPro',
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<InventarioBloc, InventarioState>(
                    builder: (context, state) {
                  if (state.cargando) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        height: 90,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              )
                            ]),
                        child: SizedBox(
                          height: 60,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              ...state.tipos.map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    inventarioBloc.filtrarInventario(
                                      tipoSeleccionado: e,
                                    );
                                  },
                                  child: Container(
                                    height: 25,
                                    padding: const EdgeInsets.all(12),
                                    margin: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: e == state.tipoSeleccionado
                                          ? kPrimaryColor
                                          : kSecondaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'CronosSPro',
                                        color: e == state.tipoSeleccionado
                                            ? kSecondaryColor
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      state.tipoInfo.isEmpty
                          ? Container()
                          : Container(
                              height: 70,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12)),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  ...state.tipoInfo.map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        inventarioBloc.filtrarInventario(
                                            tipoSeleccionado: inventarioBloc
                                                .state.tipoSeleccionado,
                                            modeloSeleccionado: e.tipo);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 5),
                                        margin: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color:
                                              e.tipo == state.modeloSeleccionado
                                                  ? Colors.white
                                                  : kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Text(
                                              e.tipo,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'CronosSPro',
                                                  color: e.tipo ==
                                                          state
                                                              .modeloSeleccionado
                                                      ? kThirdColor
                                                      : Colors.white),
                                            ),
                                            Positioned(
                                              right: -10,
                                              top: -10,
                                              child: Container(
                                                height: 20,
                                                width: 20,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: kThirdColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Text(
                                                  e.cantidad.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'CronosSPro',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Expanded(
                        child: CustomMaterialIndicator(
                          onRefresh: () async {
                            await inventarioBloc.actualizarTangible();
                          },
                          child: state.inventarioFiltrado.isEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(8),
                                  height: 600,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(1, 1),
                                          blurRadius: 2,
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8),
                                              margin: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      offset: Offset(1, 1),
                                                      blurRadius: 2,
                                                    )
                                                  ]),
                                              child: Text(
                                                'No tienes producto asignado para ' +
                                                    state.tipoSeleccionado,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'CronosSPro',
                                                  color: kSecondaryColor,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(8),
                                  height: 600,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(1, 1),
                                          blurRadius: 2,
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Lista de Productos",
                                          style: TextStyle(
                                            fontFamily: 'CronosSPro',
                                            fontSize: 18,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 100,
                                        child: _BuscarSerie(
                                          series: state.inventario,
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView(
                                          children: [
                                            ...state.inventarioFiltrado.map(
                                              (e) => Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                margin:
                                                    const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        offset: Offset(1, 1),
                                                        blurRadius: 2,
                                                      )
                                                    ]),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.list,
                                                    ),
                                                    const VerticalDivider(
                                                      color: Colors.grey,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            e.serie
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'CronosSPro',
                                                              color: kPrimaryColor
                                                                  .withOpacity(
                                                                      0.8),
                                                            ),
                                                          ),
                                                          Text(
                                                            e.descModelo
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'CronosSPro',
                                                              color:
                                                                  kSecondaryColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuscarSerie extends StatefulWidget {
  final List<ProductoTangible> series;

  const _BuscarSerie({
    required this.series,
  });

  @override
  State<_BuscarSerie> createState() => _BuscarSerieState();
}

class _BuscarSerieState extends State<_BuscarSerie> {
  late InventarioBloc inventarioBloc;
  String busqueda = '';

  @override
  void initState() {
    inventarioBloc = BlocProvider.of<InventarioBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filtroCtrl = TextEditingController(text: busqueda);
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
                    setState(() {
                      busqueda = valor;
                    });

                    inventarioBloc.add(
                      OnFiltrarTipoEvent(
                          cargando: false,
                          tipoSeleccionado:
                              inventarioBloc.state.tipoSeleccionado,
                          inventarioFiltrado: filtrar(valor),
                          tipoInfo: inventarioBloc.state.tipoInfo,
                          modeloSeleccionado:
                              inventarioBloc.state.modeloSeleccionado),
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
                inventarioBloc.add(
                  OnFiltrarTipoEvent(
                      cargando: false,
                      tipoSeleccionado: inventarioBloc.state.tipoSeleccionado,
                      inventarioFiltrado: filtrar(barcode),
                      tipoInfo: inventarioBloc.state.tipoInfo,
                      modeloSeleccionado:
                          inventarioBloc.state.modeloSeleccionado),
                );
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
              inventarioBloc.add(
                OnFiltrarTipoEvent(
                    cargando: false,
                    tipoSeleccionado: inventarioBloc.state.tipoSeleccionado,
                    inventarioFiltrado: filtrar(barcode),
                    tipoInfo: inventarioBloc.state.tipoInfo,
                    modeloSeleccionado:
                        inventarioBloc.state.modeloSeleccionado),
              );
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

  List<ProductoTangible> filtrar(String filtro) {
    final filtrarTipo = widget.series
        .where((element) =>
            element.producto == inventarioBloc.state.tipoSeleccionado)
        .toList();

    return filtrarTipo
        .where((element) => element.serie.toString().contains(filtro))
        .toList();
  }
}
