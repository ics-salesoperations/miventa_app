import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/screens/screens.dart';
import 'package:miventa_app/widgets/widgets.dart';

class InventarioReasignacionPage extends StatefulWidget {
  final Planning detallePdv;

  const InventarioReasignacionPage({
    super.key,
    required this.detallePdv,
  });

  @override
  State<InventarioReasignacionPage> createState() =>
      _InventarioReasignacionPageState();
}

class _InventarioReasignacionPageState extends State<InventarioReasignacionPage>
    with SingleTickerProviderStateMixin {
  late Planning detallePdv;
  late AnimationController controller;
  late ActualizarBloc _actualizarBloc;
  late VisitaBloc _visitaBloc;
  late AuthBloc _authBloc;
  _InventarioReasignacionPageState();

  late CarritoReasignacionBloc _carritoBloc;
  @override
  void initState() {
    super.initState();
    detallePdv = widget.detallePdv;
    _carritoBloc = BlocProvider.of<CarritoReasignacionBloc>(context);
    _actualizarBloc = BlocProvider.of<ActualizarBloc>(context);
    _visitaBloc = BlocProvider.of<VisitaBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);

    if (detallePdv.idPdv != null) {
      _actualizarBloc.actualizarTangibleReasignacion(idPdv: detallePdv.idPdv!);
    }
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _carritoBloc.init(detallePdv.idPdv!);

    _visitaBloc.iniciarVisita(
      detallePdv,
      "20",
      _authBloc.state.usuario.usuario.toString(),
    );

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
                    builder: (context) => CestaReasignacionPdvScreen(
                      pdv: widget.detallePdv,
                    ),
                  ).then((value) async {
                    final m = await _carritoBloc
                        .getModelosReasignacion(widget.detallePdv.idPdv!);
                    await _carritoBloc.crearFrmProductos(m);
                    await _carritoBloc.actualizaTotal();
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
                      child: BlocBuilder<CarritoReasignacionBloc,
                          CarritoReasignacionState>(
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
            VisitaPDVHeader(detalle: detallePdv, titulo: "Reasignación a PDV"),
            BlocBuilder<CarritoReasignacionBloc, CarritoReasignacionState>(
              builder: (context, state) {
                if (state.cargandoModelos || state.cargandoFrmProductos) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ReasignacionContentScreen(
                  controller: controller,
                  modelos: state.modelos,
                  selectedCat: state.selectedCat,
                );
              },
            ),
            const ReasignacionPDVCategoria(),
          ],
        ),
      ),
    );
  }
}
