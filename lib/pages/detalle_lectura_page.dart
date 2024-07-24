import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/pages/registro_manual_page.dart';
import 'package:miventa_app/widgets/widgets.dart';

class DetalleLecturaPage extends StatefulWidget {
  final NetworkInfo informacion;
  final AnimationController animationController;
  const DetalleLecturaPage(
      {super.key,
      required this.informacion,
      required this.animationController});

  @override
  State<DetalleLecturaPage> createState() => _DetalleLecturaPageState();
}

class _DetalleLecturaPageState extends State<DetalleLecturaPage>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listWidgets = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    initializeDateFormatting();

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(
          0,
          0.5,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            getListofWidgets(),
            getAppBarTracking(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.edit),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegistroManualPage(
                    id: widget.informacion.idLectura.toString(),
                  ),
                ));
          },
        ),
      ),
    );
  }

  Widget getListofWidgets() {
    NetworkInfo info = widget.informacion;
    return Container(
      margin: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            14,
        left: 10,
        right: 10,
      ),
      child: ListView.builder(
        controller: scrollController,
        itemCount: 26,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          widget.animationController.forward();
          switch (index) {
            case 0:
              return InfoElementList(
                label: "Fecha:",
                value:
                    "${DateFormat.yMMMEd('es_ES').format(info.fecha!)} ${DateFormat.Hms('es_ES').format(info.fecha!)}",
              );
            case 1:
              return InfoElementList(
                label: "Código:",
                value: info.idLectura!,
              );
            case 2:
              return InfoElementList(
                label: "Marca:",
                value: info.marca!,
              );
            case 3:
              return InfoElementList(
                label: "Modelo:",
                value: info.modelo!,
              );
            case 4:
              return InfoElementList(
                label: "Estado Red:",
                value: info.estadoRed!,
              );
            case 5:
              return InfoElementList(
                label: "Tipo Red:",
                value: info.tipoRed!,
              );
            case 6:
              return InfoElementList(
                label: "Operador:",
                value: info.operatorName!,
              );
            case 7:
              return InfoElementList(
                label: "Tipo Telefono:",
                value: info.tipoTelefono!,
              );
            case 8:
              return InfoElementList(
                label: "Nivel de Señal:",
                value: info.nivelSignal!,
              );
            case 9:
              return InfoElementList(
                label: "dBm:",
                value: info.dB!,
              );
            case 10:
              return InfoElementList(
                label: "Pais:",
                value: info.networkIso!,
              );
            case 11:
              return InfoElementList(
                label: "Sitio:",
                value: info.enb!,
              );
            case 12:
              return InfoElementList(
                label: "Celda:",
                value: info.cid!,
              );
            case 13:
              return InfoElementList(
                label: "Datos:",
                value: info.datos!,
              );
            case 14:
              return InfoElementList(
                label: "SNR:",
                value: info.snr!,
              );
            case 15:
              return InfoElementList(
                label: "RSRP:",
                value: info.rsrp!,
              );
            case 16:
              return InfoElementList(
                label: "RSRP ASU:",
                value: info.rsrpAsu!,
              );
            case 17:
              return InfoElementList(
                label: "RSRQ:",
                value: info.rsrq!,
              );
            case 18:
              return InfoElementList(
                label: "RSSI:",
                value: info.rssi!,
              );
            case 19:
              return InfoElementList(
                label: "RSSI ASU:",
                value: info.rssiAsu!,
              );
            case 20:
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InfoElementList(
                    label: "Localización:",
                    value: info.localizacion!,
                  ),
                  info.localizacion == 'Habilitado'
                      ? IconButton(
                          onPressed: () => MapsLauncher.launchCoordinates(
                              double.parse(info.latitud!),
                              double.parse(info.longitud!),
                              'Estoy aquí'),
                          icon: const Icon(
                            Icons.location_on_rounded,
                            color: kPrimaryColor,
                          ),
                        )
                      : Container(),
                ],
              );
            case 21:
              return InfoElementList(
                label: "Latitud:",
                value: info.latitud!,
              );
            case 22:
              return InfoElementList(
                label: "Longitud:",
                value: info.longitud!,
              );
            case 23:
              return InfoElementList(
                label: "Enviado:",
                value: info.enviado!,
              );
            case 24:
              return InfoElementList(
                label: "Reportado:",
                value: info.isManual!,
              );
            /*return InfoElementList(
                label: "Fecha Corta:",
                value: info.fechaCorta!,
              );*/
            default:
              return const SizedBox(
                height: 10,
              );
          }
        },
      ),
    );
  }

  Widget getAppBarTracking() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: kPrimaryColor //FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Detalle',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'CronosSPro',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22 + 6 - 6 * topBarOpacity,
                                      letterSpacing: 1.2,
                                      color:
                                          kSecondaryColor //FitnessAppTheme.darkerText,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.signal_cellular_4_bar_rounded,
                                  color:
                                      kSecondaryColor, //FitnessAppTheme.grey,
                                  size: 22 + 6 - 6 * topBarOpacity,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
