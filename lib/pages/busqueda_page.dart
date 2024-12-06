import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/pages/detallepdv_page.dart';
import 'package:miventa_app/pages/pages.dart';
import 'package:miventa_app/widgets/boton_azul.dart';
import 'package:miventa_app/widgets/widgets.dart';
//import 'package:elegant_notification/elegant_notification.dart';

class BusquedaPage extends StatefulWidget {
  const BusquedaPage({Key? key}) : super(key: key);
  @override
  _BusquedaPageState createState() => _BusquedaPageState();
}

class _BusquedaPageState extends State<BusquedaPage> {
  late FilterBloc filterBloc;
  late MapBloc mapBloc;

  @override
  void initState() {
    super.initState();
    filterBloc = BlocProvider.of<FilterBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);
    filterBloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
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
                children: [
                  const Text(
                    "Búsqueda",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontFamily: 'CronosSPro',
                      fontSize: 28,
                    ),
                  ),
                  Lottie.asset(
                    'assets/lottie/buscar.json',
                    width: 50,
                    height: 50,
                    animate: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: BlocBuilder<FilterBloc, FilterState>(
                    builder: (context, state) {
                      if (state.cargandoDealers ||
                          state.cargandoSucursales ||
                          state.cargandoCircuitos) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Dealer",
                              style: TextStyle(
                                  fontFamily: 'CronosLPro',
                                  fontSize: 18,
                                  color: kSecondaryColor),
                            ),
                            DropdownSearch<Dealer>(
                              popupProps: const PopupProps.menu(
                                //showSelectedItems: true,
                                searchFieldProps: TextFieldProps(
                                  style: TextStyle(
                                    color: kSecondaryColor,
                                    fontFamily: 'CrosnoLPro',
                                    fontSize: 16,
                                  ),
                                ),
                                /*textStyle: TextStyle(
                                  color: kSecondaryColor,
                                  fontFamily: 'CrosnoLPro',
                                  fontSize: 30,
                                ),*/
                              ),
                              selectedItem: state.dealers.isEmpty
                                  ? null
                                  : state.dealers[0],
                              asyncItems: (String dealer) =>
                                  filtrarDealer(dealer),
                              itemAsString: (Dealer dealer) =>
                                  dealer.nombreDealer,
                              onChanged: (Dealer? dealer) {},
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Sucursal",
                              style: TextStyle(
                                  fontFamily: 'CronosLPro',
                                  fontSize: 18,
                                  color: kSecondaryColor),
                            ),
                            DropdownSearch<Sucursal>(
                              popupProps: const PopupProps.menu(
                                //showSelectedItems: true,
                                searchFieldProps: TextFieldProps(
                                  style: TextStyle(
                                    color: kSecondaryColor,
                                    fontFamily: 'CrosnoLPro',
                                    fontSize: 16,
                                  ),
                                ),
                                /*textStyle: TextStyle(
                                  color: kSecondaryColor,
                                  fontFamily: 'CrosnoLPro',
                                  fontSize: 30,
                                ),*/
                              ),
                              selectedItem: state.sucursalSeleccionada,
                              asyncItems: (String sucursal) =>
                                  filtrarSucursal(sucursal),
                              itemAsString: (Sucursal sucursal) =>
                                  sucursal.nombreSucursal,
                              onChanged: (Sucursal? sucursal) async {
                                if (sucursal != null) {
                                  filterBloc.add(OnActualizarFiltrosEvent(
                                    idSucursal: sucursal.idSucursal,
                                    nombreCircuito: "",
                                    segmento: "",
                                    servicio: "",
                                  ));

                                  filterBloc.add(OnSucursalSeleccionadaEvent(sucursal));

                                  await filterBloc.getPDVS(
                                    idSucursal: sucursal.idSucursal,
                                  );

                                  await filterBloc.getCircuitos(
                                    idSucursal: sucursal.idSucursal,
                                  );

                                  await filterBloc.getSegmentos(
                                    idSucursal: sucursal.idSucursal,
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Circuito",
                              style: TextStyle(
                                fontFamily: 'CronosLPro',
                                fontSize: 18,
                                color: kSecondaryColor,
                              ),
                            ),
                            DropdownSearch<Circuito>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  style: TextStyle(
                                    color: kSecondaryColor,
                                    fontFamily: 'CrosnoLPro',
                                    fontSize: 16,
                                  ),
                                ),
                                /*textStyle: TextStyle(
                                  color: kSecondaryColor,
                                  fontFamily: 'CrosnoLPro',
                                  fontSize: 30,
                                ),*/
                              ),
                              asyncItems: (String circuito) {
                                return filtrarCircuito(circuito);
                              },
                              itemAsString: (Circuito circuito) =>
                                  circuito.nombreCircuito!,
                              onChanged: (Circuito? circuito) async {
                                if (circuito != null) {
                                  final filterBloc =
                                      BlocProvider.of<FilterBloc>(context);
                                  await filterBloc.getPDVS(
                                    codigoCircuito:
                                        circuito.nombreCircuito.toString(),
                                  );
                                  // se agrega
                                  await filterBloc.getSegmentos(
                                    idSucursal: filterBloc.state.idSucursal,
                                    nombreCircuito:
                                        circuito.nombreCircuito.toString(),
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Segmento",
                              style: TextStyle(
                                fontFamily: 'CronosLPro',
                                fontSize: 18,
                                color: kSecondaryColor,
                              ),
                            ),
                            DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                              ),
                              asyncItems: (String segmento) {
                                return filtrarSegmento(segmento);
                              },
                              selectedItem: state.segmento.isEmpty
                                  ? null
                                  : state.segmento,
                              itemAsString: (String? segmento) => segmento!,
                              onChanged: (String? segmento) async {
                                if (segmento != null) {
                                  filterBloc.add(OnActualizarFiltrosEvent(
                                    idSucursal: filterBloc.state.idSucursal,
                                    nombreCircuito:
                                        filterBloc.state.nombreCircuito,
                                    segmento: segmento,
                                    servicio: "",
                                  ));

                                  await filterBloc.getPDVS(
                                    idSucursal: filterBloc.state.idSucursal,
                                    nombreCircuito:
                                        filterBloc.state.nombreCircuito,
                                    segmento: segmento,
                                  );
                                  await filterBloc.getServicios(
                                    idSucursal: filterBloc.state.idSucursal,
                                    nombreCircuito:
                                        filterBloc.state.nombreCircuito,
                                    segmento: segmento,
                                    servicio: "",
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Servicio",
                              style: TextStyle(
                                fontFamily: 'CronosLPro',
                                fontSize: 18,
                                color: kSecondaryColor,
                              ),
                            ),
                            DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                              ),
                              asyncItems: (String servicio) {
                                return filtrarServicio(servicio);
                              },
                              selectedItem: state.servicio.isEmpty
                                  ? null
                                  : state.servicio,
                              itemAsString: (String? servicio) => servicio!,
                              onChanged: (String? servicio) async {
                                if (servicio != null) {
                                  filterBloc.add(OnActualizarFiltrosEvent(
                                    idSucursal: filterBloc.state.idSucursal,
                                    nombreCircuito:
                                        filterBloc.state.nombreCircuito,
                                    segmento: filterBloc.state.segmento,
                                    servicio: servicio,
                                  ));

                                  await filterBloc.getPDVS(
                                    idSucursal: filterBloc.state.idSucursal,
                                    nombreCircuito:
                                        filterBloc.state.nombreCircuito,
                                    segmento: filterBloc.state.segmento,
                                    servicio: servicio,
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Punto de Venta",
                              style: TextStyle(
                                fontFamily: 'CronosLPro',
                                fontSize: 18,
                                color: kSecondaryColor,
                              ),
                            ),
                            DropdownSearch<Planning>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                /*textStyle: TextStyle(
                                  color: kSecondaryColor,
                                  fontFamily: 'CrosnoLPro',
                                  fontSize: 30,
                                ),*/
                                searchFieldProps: TextFieldProps(
                                  style: TextStyle(
                                    color: kSecondaryColor,
                                    fontFamily: 'CrosnoLPro',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              selectedItem: state.isSelectedPDV
                                  ? state.selectedPDV[0]
                                  : null,
                              items:
                                  !state.cargandoPDVs ? state.pdvs : const [],
                              itemAsString: (Planning pdv) =>
                                  "${pdv.idPdv!} - ${pdv.nombrePdv!}",
                              onChanged: (Planning? pdv) {
                                final filterBloc =
                                    BlocProvider.of<FilterBloc>(context);
                                if (pdv != null) {
                                  filterBloc.add(
                                    OnSelectPDVEvent(
                                      selectedPDV: [pdv],
                                      isSelectedPDV: true,
                                    ),
                                  );
                                } else {
                                  filterBloc.add(
                                    const OnSelectPDVEvent(
                                        isSelectedPDV: false,
                                        selectedPDV: <Planning>[]),
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: BotonAzul(
                                    text: "Ver Detalles",
                                    onPressed: !state.isSelectedPDV ||
                                            state.selectedPDV.isEmpty
                                        ? null
                                        : () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetallePdvPage(
                                                        detallePdv: state
                                                            .selectedPDV[0]),
                                              ),
                                            );
                                          },
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: BotonAzul(
                                    text: "Ver Mapa",
                                    onPressed: state.pdvs.isEmpty
                                        ? null
                                        : () {
                                            mapBloc.add(
                                              OnUpdatePDVsMap(
                                                state.pdvs,
                                              ),
                                            );
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage(
                                                  selectedIndex: 2,
                                                  circuitos: [],
                                                ),
                                              ),
                                            );
                                          },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<List<Dealer>> filtrarDealer(String filtro) async {
    final filterBloc = BlocProvider.of<FilterBloc>(context);
    return filterBloc.state.dealers;
  }

  Future<List<Sucursal>> filtrarSucursal(String filtro) async {
    final filterBloc = BlocProvider.of<FilterBloc>(context);
    return filterBloc.state.sucursales;
  }

  Future<List<Circuito>> filtrarCircuito(String filtro) async {
    final filterBloc = BlocProvider.of<FilterBloc>(context);
    return filterBloc.state.circuitos;
  }

  // !
  Future<List<String>> filtrarSegmento(String filtro) async {
    final filterBloc = BlocProvider.of<FilterBloc>(context);
    return filterBloc.state.segmentos;
  }

  Future<List<String>> filtrarServicio(String filtro) async {
    final filterBloc = BlocProvider.of<FilterBloc>(context);
    return filterBloc.state.servicios;
  }

// !
  Future<List<Planning>> filtrarPDVS(String filtro) async {
    final filterBloc = BlocProvider.of<FilterBloc>(context);
    return filterBloc.state.pdvs;
  }
}
