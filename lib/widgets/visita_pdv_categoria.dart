import 'package:animate_do/animate_do.dart';
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';

class VisitaPDVCategoria extends StatefulWidget {
  const VisitaPDVCategoria({super.key});

  @override
  State<VisitaPDVCategoria> createState() => _VisitaPDVCategoriaState();
}

class _VisitaPDVCategoriaState extends State<VisitaPDVCategoria> {
  late CarritoBloc _carritoBloc;

  @override
  void initState() {
    super.initState();
    _carritoBloc = BlocProvider.of<CarritoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 65,
        right: 5,
        left: 5,
      ),
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kPrimaryColor.withOpacity(0.85),
                kPrimaryColor.withOpacity(0.95),
                kPrimaryColor,
              ]),
          borderRadius: const BorderRadius.all(
            Radius.circular(45),
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black26,
            )
          ]),
      child: BlocBuilder<CarritoBloc, CarritoState>(
        builder: (context, state) {
          if (state.cargandoModelos) {
            return const CircularProgressIndicator();
          }

          List<String?> categorias = _carritoBloc.state.modelos
              .groupListsBy((element) => element.tangible)
              .keys
              .toList();
          return SizedBox(
            height: 35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...categorias
                    .map((elemento) => FadeIn(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            child: Column(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 50,
                                    margin: const EdgeInsets.all(5),
                                    padding:
                                        state.selectedCat == elemento.toString()
                                            ? const EdgeInsets.all(13)
                                            : const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: state.selectedCat ==
                                                elemento.toString()
                                            ? kThirdColor
                                            : Colors.white.withOpacity(0.8),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(90),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 6,
                                            offset: state.selectedCat ==
                                                    elemento.toString()
                                                ? const Offset(1, 12)
                                                : const Offset(1, 6),
                                          )
                                        ]),
                                    child: FaIcon(
                                      elemento.toString() == "SMARTHPHONES"
                                          ? FontAwesomeIcons.mobileScreen
                                          : elemento.toString() == "SCRATCHCARD"
                                              ? FontAwesomeIcons.creditCard
                                              : elemento.toString() == "SIMCARD"
                                                  ? FontAwesomeIcons.simCard
                                                  : elemento.toString() ==
                                                          "BLISTER"
                                                      ? FontAwesomeIcons
                                                          .addressCard
                                                      : elemento.toString() ==
                                                              "ACCESS CARD MFS"
                                                          ? FontAwesomeIcons
                                                              .creditCard
                                                          : FontAwesomeIcons
                                                              .cartPlus,
                                      color: state.selectedCat ==
                                              elemento.toString()
                                          ? kSecondaryColor
                                          : Colors.grey,
                                      size: 22,
                                    ),
                                  ),
                                  onTap: () async {
                                    final m = await _carritoBloc.getModelos();
                                    await _carritoBloc.crearFrmProductos(m);
                                    await _carritoBloc.actualizaTotal();
                                    _carritoBloc.add(
                                      OnCambiarCategoriaEvent(
                                        categoria: elemento.toString(),
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  elemento.toString() == "SMARTHPHONES"
                                      ? "SMARTPHONES"
                                      : elemento.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Cronos-Pro',
                                    color:
                                        state.selectedCat == elemento.toString()
                                            ? kSecondaryColor
                                            : kSecondaryColor.withOpacity(0.7),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
