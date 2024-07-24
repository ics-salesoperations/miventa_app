import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/screens/processing_screen.dart';
import 'package:miventa_app/widgets/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormularioEncuestaPage extends StatefulWidget {
  final FormularioResumen form;
  final Planning pdv;

  const FormularioEncuestaPage({
    super.key,
    required this.form,
    required this.pdv,
  });

  @override
  State<FormularioEncuestaPage> createState() => _FormularioEncuestaPageState();
}

class _FormularioEncuestaPageState extends State<FormularioEncuestaPage> {
  late FormularioBloc formBloc;

  @override
  void initState() {
    super.initState();
    formBloc = BlocProvider.of<FormularioBloc>(context);
    formBloc.getFormularioEncuesta(
      widget.form.formId.toString(),
      widget.pdv,
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
        painter: HeaderWavesGradientPainter(),
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
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 50,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: BlocBuilder<FormularioBloc, FormularioState>(
                  builder: (context, state) {
                if (!state.isCurrentFormListo) {
                  return buildSkeleton(context);
                }
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1,
                              color: kSecondaryColor,
                              spreadRadius: 0.2)
                        ],
                      ),
                      child: Center(
                        child: Text(
                          state.currentForm[0].formName!,
                          style: const TextStyle(
                            color: kSecondaryColor,
                            fontSize: 22,
                            fontFamily: 'CronosSPro',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
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
                            BoxShadow(
                                blurRadius: 1,
                                color: Colors.grey,
                                spreadRadius: 0)
                          ],
                        ),
                        child: ReactiveForm(
                          formGroup: state.currentFormgroup!,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(
                              top: 5,
                            ),
                            children: [
                              ...(formBloc.contruirCampos(state.currentForm)),
                              ReactiveFormConsumer(
                                builder: (context, form, child) {
                                  return MaterialButton(
                                    child: const Text(
                                      'Enviar',
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 18,
                                        fontFamily: 'CronosLPro',
                                      ),
                                    ),
                                    color: kSecondaryColor,
                                    disabledColor: Colors.grey,
                                    onPressed: form.valid
                                        ? () async {
                                            formBloc.add(OnCurrentFormSaving(
                                              currentForm: state.currentForm,
                                              formGroup: form,
                                            ));

                                            await showDialog(
                                              context: context,
                                              builder: (ctx) =>
                                                  const ProcessingScreen(),
                                            ).then(
                                              (value) {
                                                Navigator.pop(context);
                                              },
                                            );
                                          }
                                        : () {
                                            form.markAllAsTouched();
                                          },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
