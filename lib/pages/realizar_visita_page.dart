import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/screens/screens.dart';
import 'package:miventa_app/widgets/widgets.dart';

class RealizarVisitaPage extends StatefulWidget {
  final Planning detallePdv;

  const RealizarVisitaPage({
    super.key,
    required this.detallePdv,
  });

  @override
  State<RealizarVisitaPage> createState() => _RealizarVisitaPageState();
}

class _RealizarVisitaPageState extends State<RealizarVisitaPage>
    with SingleTickerProviderStateMixin {
  late Planning detallePdv;
  late AnimationController controller;

  _RealizarVisitaPageState();

  late CarritoBloc _carritoBloc;
  late VisitaBloc _visitaBloc;

  @override
  void initState() {
    super.initState();
    detallePdv = widget.detallePdv;
    _carritoBloc = BlocProvider.of<CarritoBloc>(context);
    _visitaBloc = BlocProvider.of<VisitaBloc>(context);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _carritoBloc.init(_visitaBloc.state.mostrarTangible, _visitaBloc.state.idPdv.toString());

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      body: CustomPaint(
        painter: HeaderCurvoPainter(),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 10,
              child: InkWell(
                splashColor: kPrimaryColor,
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                  size: 25,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              right: 15,
              child: InkWell(
                splashColor: kPrimaryColor,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CestaPdvScreen(
                      pdv: widget.detallePdv,
                    ),
                  ).then((value) async {
                    final m = await _carritoBloc
                        .getModelos(_visitaBloc.state.mostrarTangible,_visitaBloc.state.idPdv.toString());
                    print('modelos:$m');
                    await _carritoBloc.crearFrmProductos(m);
                    await _carritoBloc.actualizaTotal(_visitaBloc.state.idPdv.toString());
                  });
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      FontAwesomeIcons.cartShopping,
                      color: kThirdColor,
                      size: 25,
                    ),
                    Positioned(
                      right: -5,
                      top: -5,
                      child: BlocBuilder<CarritoBloc, CarritoState>(
                        builder: (context, state) {
                          if (state.cargandoModelos ||
                              state.cargandoFrmProductos) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return Bounce(
                            controller: (ctrl) => controller,
                            from: 10,
                            duration: const Duration(
                              seconds: 1,
                            ),
                            child: CircleAvatar(
                              minRadius: 8,
                              backgroundColor: kPrimaryColor,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    state.total.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Cronos-Pro',
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VisitaPDVHeader(detalle: detallePdv, titulo: "Gestion del PDV"),
            BlocBuilder<CarritoBloc, CarritoState>(
              builder: (context, state) {
                if (state.cargandoModelos || state.cargandoFrmProductos) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return VisitaContentScreen(
                  controller: controller,
                  modelos: state.modelos,
                  selectedCat: state.selectedCat,
                  pdv: widget.detallePdv,
                );
              },
            ),
            const VisitaPDVCategoria(),
          ],
        ),
      ),
    );
  }
}
