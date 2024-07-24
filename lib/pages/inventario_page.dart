import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/db_service.dart';
import 'package:miventa_app/widgets/widgets.dart';
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
                      Expanded(
                        child: Container(
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
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
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
                                  modelo: ModeloTangible(),
                                ),
                              ),
                              ...state.inventarioFiltrado.map(
                                (e) => Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(3),
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
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.list,
                                      ),
                                      const VerticalDivider(
                                        color: Colors.grey,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.serie.toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'CronosSPro',
                                              color: kPrimaryColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          Text(
                                            e.descModelo.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'CronosSPro',
                                              color: kSecondaryColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
  late CarritoBloc carritoBloc;

  @override
  void initState() {
    carritoBloc = BlocProvider.of<CarritoBloc>(context);
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
                      OnCambiarFiltroEvent(
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
                                const OnCambiarFiltroEvent(filtro: ""),
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
                carritoBloc.add(OnCambiarFiltroEvent(
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
              carritoBloc.add(OnCambiarFiltroEvent(filtro: barcode));
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
