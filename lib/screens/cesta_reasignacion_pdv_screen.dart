import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/screens/screens.dart';
import '../blocs/blocs.dart';

class CestaReasignacionPdvScreen extends StatefulWidget {
  final Planning pdv;

  const CestaReasignacionPdvScreen({Key? key, required this.pdv})
      : super(key: key);

  @override
  State<CestaReasignacionPdvScreen> createState() =>
      _CestaReasignacionPdvScreenState();
}

class _CestaReasignacionPdvScreenState
    extends State<CestaReasignacionPdvScreen> {
  late CarritoReasignacionBloc _carritoBloc;
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _carritoBloc = BlocProvider.of<CarritoReasignacionBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _carritoBloc.getModelosAsignados(pdv: widget.pdv);
  }

  IconData _getIcon(String tangible) {
    switch (tangible) {
      case "SMARTHPHONES":
        return FontAwesomeIcons.mobileScreen;
      case "SCRATCHCARD":
        return FontAwesomeIcons.creditCard;
      case "SIMCARD":
        return FontAwesomeIcons.simCard;
      case "BLISTER":
        return FontAwesomeIcons.addressCard;
      case "ACCESS CARD MFS":
        return FontAwesomeIcons.creditCard;
      default:
        return FontAwesomeIcons.cartPlus;
    }
  }

  Widget _buildModeloItem(ModeloTangible modelo, int index, bool isAsignado) {
    final cantidad = isAsignado ? modelo.asignado : modelo.descartado;
    final actionText = isAsignado ? " - a reasignar" : " - a descartar";

    return SlideInLeft(
      delay: Duration(milliseconds: index * 100),
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: kThirdColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: 60,
              margin: const EdgeInsets.only(left: 15),
              child: FaIcon(
                _getIcon(modelo.tangible.toString()),
                color: Colors.white,
                size: 22,
              ),
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 50),
              child: Text(
                modelo.modelo.toString() == 'SMARTHPHONES'
                    ? 'SMARTPHONES'
                    : modelo.tangible.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'CronosSPro',
                  color: kSecondaryColor,
                ),
              ),
            ),
            Positioned(
              right: -10,
              top: 10,
              child: FaIcon(
                _getIcon(modelo.tangible.toString()),
                color: Colors.black12,
                size: 90,
              ),
            ),
            Positioned(
              right: 12,
              top: 0,
              child: SizedBox(
                height: 60,
                child: Align(
                  child: Text(
                    "$cantidad$actionText",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'CronosSPro',
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.only(
            top: media.padding.top + 10,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.white10,
                offset: Offset(1, 2),
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.only(
                      left: 60,
                      right: 12,
                      top: 12,
                      bottom: 12,
                    ),
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            color: Colors.black12,
                          )
                        ]),
                    child: Text(
                      widget.pdv.idPdv.toString() +
                          " - " +
                          widget.pdv.nombrePdv.toString(),
                      style: const TextStyle(
                        color: kSecondaryColor,
                        fontFamily: 'CronosSPro',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 10,
                    top: 30,
                    child: Icon(
                      FontAwesomeIcons.bagShopping,
                      size: 55,
                      color: kSecondaryColor,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          false,
                        );
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.circleXmark,
                        color: kSecondaryColor,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Resumen de Reasignación",
                style: TextStyle(
                  color: kFourColor,
                  fontSize: 22,
                  fontFamily: 'CronosSPro',
                ),
              ),
              Expanded(
                child: Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(252, 251, 248, 242),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: BlocBuilder<CarritoReasignacionBloc,
                      CarritoReasignacionState>(
                    builder: (context, state) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.modelosAsignados.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final modelo = state.modelosAsignados[index];
                          final items = <Widget>[
                            if (modelo.asignado > 0)
                              _buildModeloItem(modelo, index, true),
                            if (modelo.descartado > 0)
                              _buildModeloItem(modelo, index, false),
                            const SizedBox
                                .shrink(), // Espaciador u otro widget adicional
                          ];
                          return Column(
                            children: items,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<CarritoReasignacionBloc, CarritoReasignacionState>(
                builder: (context, state) {
                  if (state.validandoBlister) {
                    return _buildLoadingIndicator(state.mensaje);
                  }
                  return _buildConfirmationButton();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(String mensaje) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          kSecondaryColor,
          kSecondaryColor.withOpacity(0.9),
          kSecondaryColor.withOpacity(0.8),
          kPrimaryColor
        ]),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(width: 10),
          Text(
            mensaje,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'CronosLPro',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationButton() {
    return MaterialButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ProcessingVentaReasignacion(pdv: widget.pdv),
        );
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kSecondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: const Text(
          "Confirmar Modificación",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'CronosPro',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
