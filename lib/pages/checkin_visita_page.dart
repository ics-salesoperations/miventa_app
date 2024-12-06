import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/widgets/widgets.dart';
import 'package:miventa_app/pages/pages.dart';
import 'package:miventa_app/models/models.dart';

class VisitaScreen extends StatelessWidget {
  final Planning detallePdv;
  final FormGroup form = FormGroup({
    'seRealizoVenta': FormControl<bool>(value: false),
    'razon': FormControl<String>(),
  });

  VisitaScreen({super.key, required this.detallePdv});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: HeaderPicoPainter(),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 15,
            left: 15,
            right: 15,
          ),
          child: Column(
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
                    "Venta",
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
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ReactiveForm(
                    formGroup: form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "¿Se realizó Venta?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReactiveSwitch(
                              formControlName: 'seRealizoVenta',
                              activeColor: kPrimaryColor,
                            ),
                            const SizedBox(width: 10),
                            ReactiveValueListenableBuilder<bool>(
                              formControlName: 'seRealizoVenta',
                              builder: (context, control, child) {
                                final seRealizoVenta = control.value ?? false;
                                return Text(
                                  seRealizoVenta ? "Sí" : "No",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: kPrimaryColor,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        ReactiveValueListenableBuilder<bool>(
                          formControlName: 'seRealizoVenta',
                          builder: (context, control, child) {
                            final seRealizoVenta = control.value ?? false;
                            if (!seRealizoVenta) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Razón de no realización:",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  ReactiveDropdownField<String>(
                                    formControlName: 'razon',
                                    hint: const Text("Selecciona una razón"),
                                    items: const [
                                      DropdownMenuItem(
                                        value: "Cerrado",
                                        child: Text("Cerrado"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Cuenta con Stock",
                                        child: Text("Cuenta con Stock"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Sin Capital",
                                        child: Text("Sin Capital"),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              final seRealizoVenta =
                                  form.control('seRealizoVenta').value as bool;
                              final razon =
                                  form.control('razon').value as String?;

                              final mensaje = seRealizoVenta
                                  ? "Venta se realizó"
                                  : "Venta no se realizó por: $razon";

                              if (seRealizoVenta) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RealizarVisitaPage(
                                      detallePdv: detallePdv,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Guardar"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              textStyle: const TextStyle(
                                fontFamily: 'CronosLPro',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
