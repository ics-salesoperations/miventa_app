import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/screens/screens.dart';
import 'package:miventa_app/services/db_service.dart';
import 'package:miventa_app/widgets/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../models/models.dart';
//import 'package:elegant_notification/elegant_notification.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({Key? key}) : super(key: key);
  @override
  _ReportesPageState createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  late SyncBloc syncBloc;
  late AuthBloc _authBloc;

  DBService db = DBService();
  final formulario = FormGroup({
    'rango': FormControl<DateTimeRange>(
        validators: [Validators.required],
        value: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        )),
  });

  List<ProductoTangible> registros = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_Es', null);
    syncBloc = BlocProvider.of<SyncBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    syncBloc.init();
  }

  @override
  Widget build(BuildContext context) {
    final usuario = _authBloc.state.usuario;

    return Scaffold(
        body: CustomPaint(
      painter: HeaderPicoPainter(),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).padding.bottom + 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
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
                      size: 22,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Reportes",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: 'CronosSPro',
                          fontSize: 28,
                        ),
                      ),
                      Lottie.asset(
                        'assets/lottie/buscar.json',
                        width: 50,
                        height: 50,
                        animate: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 2)
                  ],
                ),
                child: Column(
                  children: [
                    ReporteCard(
                      title: "FORDIS 11 Pendientes",
                      icon: Icons.warning_amber_rounded,
                      iconColor: kSecondaryColor,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReporteFordis11Screen(),
                            ));
                      },
                    ),
                    ReporteCard(
                      title: "PDVs con Quiebre Móvil",
                      icon: Icons.warning_amber_rounded,
                      iconColor: kPrimaryColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReporteQuiebreMovilScreen(),
                          ),
                        );
                      },
                    ),
                    ReporteCard(
                      title: "PDVs con Quiebre TMY",
                      icon: Icons.warning_rounded,
                      iconColor: kThirdColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReporteQuiebreTMYScreen(),
                          ),
                        );
                      },
                    ),
                    ReporteCard(
                      title: "Mis solicitudes Ingresadas",
                      icon: Icons.book_online,
                      iconColor: kSecondaryColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ReporteSolicitudesScreen(
                              tipo: 'PROPIAS',
                            ),
                          ),
                        );
                      },
                    ),
                    usuario.perfil != 89
                        ? ReporteCard(
                            title: "Solicitudes de mis vendedores",
                            icon: Icons.book_online,
                            iconColor: kSecondaryColor,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ReporteSolicitudesScreen(
                                    tipo: 'PERSONAS A CARGO',
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class ReporteCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;

  const ReporteCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 5,
            )
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'CronosLPro',
                fontSize: 18,
                color: kSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
