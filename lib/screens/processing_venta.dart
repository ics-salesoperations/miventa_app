import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';

class ProcessingVenta extends StatefulWidget {
  final Planning pdv;

  const ProcessingVenta({
    Key? key,
    required this.pdv,
  }) : super(key: key);

  @override
  State<ProcessingVenta> createState() => _ProcessingVentaState();
}

class _ProcessingVentaState extends State<ProcessingVenta> {
  late CarritoBloc _carritoBloc;
  late VisitaBloc _visitaBloc;

  @override
  void initState() {
    super.initState();
    _carritoBloc = BlocProvider.of<CarritoBloc>(context);
    _visitaBloc = BlocProvider.of<VisitaBloc>(context);
    _visitaBloc.enviarDatos(
      formId: _visitaBloc.state.formId,
      instanceId: _visitaBloc.state.instanceId,
      fechaCreacion: _visitaBloc.state.fechaCreacion,
      respondentId: _visitaBloc.state.respondentId,
      pdv: widget.pdv,
    );
    _carritoBloc.procesarVisita(
      idPdv: _visitaBloc.state.idPdv,
      idVisita: _visitaBloc.state.idVisita,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.08,
                left: MediaQuery.of(context).size.width * 0.05),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  'assets/lottie/enviando.json',
                  height: 200,
                ),
                const Text(
                  "Enviando datos...",
                  style: TextStyle(
                    fontFamily: 'CronosSPro',
                    fontSize: 22,
                    color: kPrimaryColor,
                  ),
                ),
                BlocBuilder<CarritoBloc, CarritoState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            state.mensaje,
                            style: const TextStyle(
                              color: kSecondaryColor,
                              fontFamily: 'CronosLPro',
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        MaterialButton(
                          elevation: 4,
                          color: Colors.white,
                          onPressed: state.mensaje ==
                                  'Actualizando datos sincronizados.'
                              ? null
                              : () {
                                  Navigator.pop(context);
                                },
                          child: const Text(
                            "Cerrar",
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontFamily: 'CronosLPro',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        state.mensaje != 'Actualizando datos sincronizados.'
                            ? Container()
                            : const Text(
                                "Botón deshabilitado para procesar información. Por favor espera..",
                                style: TextStyle(
                                  color: kThirdColor,
                                  fontFamily: 'CronosLPro',
                                  fontSize: 16,
                                ),
                              )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
