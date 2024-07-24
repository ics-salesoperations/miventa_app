import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/actualizar/actualizar_bloc.dart';
import 'package:miventa_app/blocs/auth/auth_bloc.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/screens/screens.dart';
import 'package:miventa_app/services/db_service.dart';

import '../widgets/headers.dart';

/// Example without a datasource
class ReporteSolicitudesScreen extends StatefulWidget {
  final String tipo;
  const ReporteSolicitudesScreen({
    super.key,
    required this.tipo,
  });

  @override
  State<ReporteSolicitudesScreen> createState() =>
      _ReporteSolicitudesScreenState();
}

class _ReporteSolicitudesScreenState extends State<ReporteSolicitudesScreen> {
  final DBService db = DBService();
  late ActualizarBloc _actualizarBloc;
  late AuthBloc _authBloc;

  List<Solicitudes> datos = [];
  List<String> usuarios = [];
  String mensaje = "";
  String selectedUser = "";

  @override
  void initState() {
    _actualizarBloc = BlocProvider.of<ActualizarBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _cargaInicial();

    super.initState();
  }

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
            bottom: MediaQuery.of(context).padding.bottom + 5,
          ),
          child: Column(
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
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    widget.tipo == 'PROPIAS'
                        ? "Mis solicitudes ingresadas"
                        : "Lista de solicitudes",
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontFamily: 'CronosSPro',
                      fontSize: 28,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: const [BoxShadow(color: Colors.black38)],
                  ),
                  child: RefreshIndicator(
                    onRefresh: _refreshSolicitudes,
                    triggerMode: RefreshIndicatorTriggerMode.onEdge,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      children: [
                        mensaje == ""
                            ? Container()
                            : Center(
                                child: Column(
                                  children: [
                                    const CircularProgressIndicator(
                                      color: kSecondaryColor,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      mensaje,
                                      style: const TextStyle(
                                        fontFamily: 'CronosLPro',
                                        fontSize: 14,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Wrap(
                          children: [
                            ...usuarios.map((e) => Container(
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: selectedUser == e
                                        ? kPrimaryColor
                                        : kSecondaryColor,
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(3),
                                  child: GestureDetector(
                                    onTap: () {
                                      filtrarLista(e);
                                      setState(() {
                                        selectedUser = e;
                                      });
                                    },
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                        fontFamily: 'CronosLPro',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        ...datos.map((e) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => DetalleSolicitudScreen(
                                  solicitud: e,
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              padding: const EdgeInsets.all(8),
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.usuario.toString(),
                                          style: const TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 16,
                                            fontFamily: 'CronosSPro',
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          'PDV: ' + e.idPdv.toString(),
                                          style: const TextStyle(
                                            color: kSecondaryColor,
                                            fontSize: 16,
                                            fontFamily: 'CronosLPro',
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            e.formName.toString(),
                                            style: const TextStyle(
                                              color: kSecondaryColor,
                                              fontSize: 16,
                                              fontFamily: 'CronosLPro',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          '#' + e.codigo.toString(),
                                          style: const TextStyle(
                                            color: kSecondaryColor,
                                            fontSize: 18,
                                            fontFamily: 'CronosSPro',
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          DateFormat('dd/MM/yyyy HH:mm:ss')
                                              .format(e.fecha!),
                                          style: const TextStyle(
                                            color: kSecondaryColor,
                                            fontSize: 16,
                                            fontFamily: 'CronosLPro',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: kThirdColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        margin: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Text(
                                          e.estado.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'CronosSPro',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
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

  Future<void> _refreshSolicitudes() async {
    final usuario = _authBloc.state.usuario;
    mensaje = "Espere, estamos actualizando los datos...";

    if (usuario.perfil != 89) {
      await _actualizarBloc.actualizarSolicitudesSup();
    } else {
      await _actualizarBloc.actualizarSolicitudes();
    }

    final datos2 = await db.leerSolicitudes(
      widget.tipo,
      usuario.usuario.toString(),
    );
    setState(() {
      datos = datos2;
      /*datos.sort(
        (a, b) {
          DateTime fecha1 = a.fecha!;
          DateTime fecha2 = b.fecha!;
          return fecha2.compareTo(fecha1);
        },
      );*/
    });
    mensaje = "";
  }

  Future<void> filtrarLista(String usr) async {
    final usuario = _authBloc.state.usuario;

    final datos2 = await db.leerSolicitudes(
      widget.tipo,
      usuario.usuario.toString(),
    );
    setState(() {
      datos = datos2
          .where((element) => element.usuario.toString().contains(usr))
          .toList();
    });
  }

  Future<void> _cargaInicial() async {
    final usuario = _authBloc.state.usuario;
    mensaje = "Espere, estamos actualizando los datos...";
    List<Solicitudes> datos2 = await db.leerSolicitudes(
      widget.tipo,
      usuario.usuario.toString(),
    );

    List<String> usuarios2 =
        await db.leerUsersSolicitudes(usuario.usuario.toString(), widget.tipo);

    if (datos.isEmpty) {
      if (usuario.perfil != 89) {
        await _actualizarBloc.actualizarSolicitudesSup();
      } else {
        await _actualizarBloc.actualizarSolicitudes();
      }

      datos2 = await db.leerSolicitudes(
        widget.tipo,
        usuario.usuario.toString(),
      );
    }

    setState(() {
      /*datos.sort(
        (a, b) {
          DateTime fecha1 = a.fecha!;
          DateTime fecha2 = b.fecha!;
          return fecha2.compareTo(fecha1);
        },
      );*/
      datos = datos2;
      usuarios = usuarios2;
    });
    mensaje = "";
  }
}
