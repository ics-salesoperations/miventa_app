import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';

class ValidacionVisitaScreen extends StatefulWidget {
  final Planning pdv;
  const ValidacionVisitaScreen({Key? key, required this.pdv}) : super(key: key);

  @override
  State<ValidacionVisitaScreen> createState() => _ValidacionVisitaScreenState();
}

class _ValidacionVisitaScreenState extends State<ValidacionVisitaScreen> {
  late VisitaBloc visitaBloc;
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    visitaBloc = BlocProvider.of<VisitaBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);

    visitaBloc.iniciarVisita(
      widget.pdv,
      "20",
      authBloc.state.usuario.usuario.toString(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 250,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: BlocBuilder<VisitaBloc, VisitaState>(
          builder: (context, state) {
            if (!state.frmVisitaListo) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.errores.isEmpty) {
              Navigator.pop(context, true);
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/visita_sospechosa.json',
                    width: 200,
                    height: 200,
                    animate: true,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        "¡Algo ha ocurrido!",
                        style: TextStyle(
                          fontFamily: 'CronosLPro',
                          fontSize: 22,
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 200,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffcccaaa),
                          blurRadius: 5,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListView(children: [
                      Center(
                        child: Text(
                          "Hemos detectado los siguientes problemas asociados a la visita:",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'CronosLPro',
                            color: kPrimaryColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const Divider(),
                      ...state.errores.map(
                        (elemento) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.warning,
                                  color: kThirdColor,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    elemento,
                                    style: TextStyle(
                                      fontFamily: 'CronosLPro',
                                      fontSize: 14,
                                      color: kSecondaryColor.withOpacity(0.7),
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Center(
                      child: Text(
                        "Esta visita está sujeta a revisión, ¿Estás seguro que deseas continuar?",
                        style: TextStyle(
                          fontFamily: 'CronosLPro',
                          fontSize: 16,
                          color: kThirdColor,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        elevation: 4,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text(
                          "Si",
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontFamily: 'CronosLPro',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      MaterialButton(
                        elevation: 4,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontFamily: 'CronosLPro',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
