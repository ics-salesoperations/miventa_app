import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/pages/pages.dart';
import 'package:miventa_app/services/services.dart';
import 'package:miventa_app/widgets/widgets.dart';

import '../models/models.dart';

class FormulariosVisitaScreen extends StatefulWidget {
  final Planning pdv;
  const FormulariosVisitaScreen({
    Key? key,
    required this.pdv,
  }) : super(key: key);

  @override
  State<FormulariosVisitaScreen> createState() =>
      _FormulariosVisitaScreenState();
}

class _FormulariosVisitaScreenState extends State<FormulariosVisitaScreen> {
  late FormularioBloc formularioBloc;
  DBService db = DBService();

  @override
  void initState() {
    super.initState();
    formularioBloc = BlocProvider.of<FormularioBloc>(context);
    formularioBloc.cargarFormsEncuestas(
      pdv: widget.pdv,
    );
  }

  Widget buildSkeleton(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: LoadingSkeleton.rounded(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 40,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(blurRadius: 1, color: Colors.grey, spreadRadius: 0)
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                LoadingSkeleton.rounded(
                  width: double.infinity,
                  height: 60,
                ),
                LoadingSkeleton.rounded(
                  width: double.infinity,
                  height: 60,
                ),
                LoadingSkeleton.rounded(
                  width: double.infinity,
                  height: 60,
                ),
                LoadingSkeleton.rounded(
                  width: double.infinity,
                  height: 60,
                ),
                LoadingSkeleton.rounded(
                  width: double.infinity,
                  height: 60,
                ),
                LoadingSkeleton.rounded(
                  width: double.infinity,
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: HeaderPicoPainter(),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 15, left: 15, right: 15),
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
                  "Realizar Encuestas",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontFamily: 'CronosSPro',
                    fontSize: 28,
                  ),
                ),
                const SizedBox(width: 20),
                Lottie.asset(
                  'assets/lottie/form_page.json',
                  width: 30,
                  height: 30,
                  animate: true,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<FormularioBloc, FormularioState>(
                  builder: (context, state) {
                if (!state.isFrmVisitaListo) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 18.0),
                        child: Center(
                          child: Text(
                            "Encuestas Disponibles",
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontFamily: 'Cronos-Pro',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          children: [
                            ...state.formularios.map(
                              (frm) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return FormularioEncuestaPage(
                                          form: frm,
                                          pdv: widget.pdv,
                                        );
                                      },
                                    ),
                                  ).then((value) async {
                                    await formularioBloc.cargarFormsEncuestas(
                                      pdv: widget.pdv,
                                    );

                                    formularioBloc.add(
                                      const OnCurrentFormReadyEvent(
                                        isCurrentFormReady: false,
                                        currentForm: [],
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  height: 80,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(
                                          0xffcccaaa,
                                        ),
                                        blurRadius: 5,
                                        offset: Offset(
                                          0,
                                          2,
                                        ), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const CircleAvatar(
                                        radius: 25,
                                        backgroundColor: kPrimaryColor,
                                        child: Center(
                                          child: Icon(
                                            Icons.edit_note,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              frm.formName
                                                  .toString()
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'CronosLPro',
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Flexible(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                height: 60,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    140,
                                                child: Text(
                                                  frm.lastDate != null
                                                      ? DateFormat(
                                                              'dd/MM/yyyy HH:mm:ss')
                                                          .format(frm.lastDate!)
                                                      : 'Sin aplicar',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'CronosLPro',
                                                  ),
                                                  maxLines: 2,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      frm.lastDate != null &&
                                              DateFormat('D')
                                                      .format(frm.lastDate!) ==
                                                  DateFormat('D')
                                                      .format(DateTime.now())
                                          ? const Icon(
                                              Icons.check,
                                              size: 22,
                                              color: Colors.green,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    ));
  }
}
