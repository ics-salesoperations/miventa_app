import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';

class ProcessingPreventa extends StatefulWidget {
  final Planning pdv;

  const ProcessingPreventa({
    Key? key,
    required this.pdv,
  }) : super(key: key);

  @override
  State<ProcessingPreventa> createState() => _ProcessingPreventaState();
}

class _ProcessingPreventaState extends State<ProcessingPreventa> {
  late CarritoBloc _carritoBloc;
  late VisitaBloc _visitaBloc;
  late AuthBloc   _authBloc;

  @override
  void initState() {
    super.initState();
    _carritoBloc = BlocProvider.of<CarritoBloc>(context);
    _visitaBloc = BlocProvider.of<VisitaBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);

    // Aquí llamas tu nueva función para marcar preventa
    _carritoBloc.marcarPreventa(
      idPdv: _visitaBloc.state.idPdv,
      idVisita: _visitaBloc.state.idVisita,
    );

    _carritoBloc.getModelosSaldo(pdv: widget.pdv).then((modelos) {
      _visitaBloc.enviarCheckinSaldos(
        idPdv: widget.pdv.idPdv.toString(),
        usuario: _authBloc.state.usuario.usuario!,
        fecha: DateTime.now(),
        tipoTransaccion: 'VENTA',
        modelos: modelos,
      );
    });
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
                  "Procesando Preventa...",
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
                          onPressed: () {
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
