import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:miventa_app/models/models.dart';

import 'pages.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}



class _InicioPageState extends State<InicioPage> {
  late NavigationBloc navBloc;
  //final List<Map<String, dynamic>> kpis = getIndicadoresVendedor(detallePdv.idPdv.toString());
  late Future<List<IndicadoresVendedor>> _futureIndicadoresVendedor;

  late ActualizarBloc _actualizarBloc;

  List<IndicadoresVendedor> indicadoresVendedor = [];



  @override
  void initState() {
    super.initState();
    navBloc = BlocProvider.of<NavigationBloc>(context);
    _actualizarBloc = BlocProvider.of<ActualizarBloc>(context);
    _futureIndicadoresVendedor = BlocProvider.of<ActualizarBloc>(context)
        .getIndicadoresVendedor();


  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            25,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(253, 253, 252, 251),
            blurRadius: 1,
            offset: Offset(1, 1),
          )
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 188,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: kThirdColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 52,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(45),
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/pdv.svg',
                              width: 45,
                              height: 45,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Mi Venta",
                            style: TextStyle(
                                color: kSecondaryColor,
                                fontFamily: 'CronosSPro',
                                fontSize: 32),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 10,
              ),
               child: FutureBuilder<List<IndicadoresVendedor>>(
                  future: _futureIndicadoresVendedor,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return Container();
                    } else {
                      List<IndicadoresVendedor> indicadoresVendedor = snapshot.data!;
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height *
                              0.17, // Ajusta la altura según sea necesario
                          viewportFraction: 0.9,
                          enableInfiniteScroll: true,
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                        ),
                        items:  indicadoresVendedor.map((kpi) {
                          return CardKPI(
                            titulo: capitalizeFirstLetter(kpi.indicador),
                            m0: kpi.m0 ?? 0.0,
                            m1: kpi.m1 ?? 0.0,
                            variacion: kpi.varianza ?? 0.0,
                            anomes: '0',
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
            ),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _HomeMenuCard(
                  asset: 'assets/Iconos/mirutahoy.svg',
                  label: 'Planificación',
                  iconSize: const Size(45, 45),
                  onTap: () {
                    Navigator.pushNamed(context, 'planificacion');
                  },
                ),
                _HomeMenuCard(
                  asset: 'assets/Iconos/actualizar.svg',
                  label: 'Actualizar',
                  onTap: () async {
                      final result = await Navigator.pushNamed(context, 'actualizar');
                      if (result == true) {
                        setState(() {
                          _futureIndicadoresVendedor =
                              _actualizarBloc.getIndicadoresVendedor();
                        });
                      }
                  },
                ),
                _HomeMenuCard(
                  asset: 'assets/Iconos/modificaciones.svg',
                  label: 'Modificaciones',
                  onTap: () {
                    Navigator.pushNamed(context, 'modificaciones');
                  },
                ),
                _HomeMenuCard(
                  asset: 'assets/Iconos/formularios.svg',
                  label: 'Formularios',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FormulariosPage(),
                      ),
                    );
                  },
                ),
                _HomeMenuCard(
                  asset: 'assets/Iconos/sincronizar.svg',
                  label: 'Sincronizar',
                  onTap: () {
                    Navigator.pushNamed(context, 'sincronizar');
                  },
                ),
                _HomeMenuCard(
                  asset: 'assets/Iconos/report.svg',
                  label: 'Reportes',
                  onTap: () {
                    Navigator.pushNamed(context, 'reportes');
                  },
                ),
                _HomeMenuCard(
                  asset: 'assets/Iconos/profile.svg',
                  label: 'Mi Perfil',
                  onTap: () {
                    Navigator.pushNamed(context, 'perfil');
                  },
                ),
                _HomeMenuCard(
                  asset: 'assets/Iconos/sincronizar.svg',
                  label: 'Inventario',
                  onTap: () {
                    Navigator.pushNamed(context, 'inventario');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeMenuCard extends StatelessWidget {
  final String asset;
  final String label;
  final Color labelColor;
  final Color itemColor;
  final VoidCallback onTap;
  final Size iconSize;

  const _HomeMenuCard({
    required this.asset,
    required this.label,
    required this.onTap,
    this.labelColor = kSecondaryColor,
    this.itemColor = Colors.white,
    this.iconSize = const Size(70, 70),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: itemColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              offset: Offset(0.2, 0.2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: SvgPicture.asset(
                asset,
                width: iconSize.width,
                height: iconSize.height,
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'CronosLPro',
                  fontSize: 18,
                  color: labelColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Función para capitalizar la primera letra
String capitalizeFirstLetter(String? text) {
  if (text!.isEmpty) {
    return text;
  }
  // Divide la cadena en palabras usando el espacio como delimitador.
  List<String> words = text.split(' ');

  // Capitaliza la primera letra de cada palabra y las une nuevamente.
  String result = words.map((word) {
    if (word.isEmpty) {
      return word;
    }
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');

  return result;
}