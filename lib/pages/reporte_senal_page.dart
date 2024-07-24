import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/pages/pages.dart';
import 'package:miventa_app/services/db_service.dart';

/// Example without a datasource
class ReporteSenalPage extends StatefulWidget {
  final AnimationController? animationController;
  const ReporteSenalPage({super.key, this.animationController});

  @override
  State<ReporteSenalPage> createState() => _ReporteSenalPageState();
}

class _ReporteSenalPageState extends State<ReporteSenalPage>
    with TickerProviderStateMixin {
  DBService db = DBService();

  late List<NetworkInfo> informacion;

  Animation<double>? topBarAnimation;

  List<Widget> listWidgets = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    initializeDateFormatting();

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
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

    super.initState();
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
      ),
    );
  }

  Widget getListofWidgets() {
    return FutureBuilder<List<NetworkInfo>>(
      future: db.getInformacion(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        informacion = snapshot.data!;

        return ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(
            top: AppBar().preferredSize.height +
                MediaQuery.of(context).padding.top +
                24,
            bottom: 62 + MediaQuery.of(context).padding.bottom,
          ),
          itemCount: informacion.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            widget.animationController?.forward();
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleLecturaPage(
                        informacion: informacion[index],
                        animationController: widget.animationController!,
                      ),
                    ));
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(28.0),
                    topRight: Radius.circular(28.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: kSecondaryColor,
                      offset: Offset(1.1, 1.1),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 16, right: 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              const Text(
                                " Fecha: ",
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  fontFamily: 'CronosSPro',
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${DateFormat.yMMMEd('es_ES').format(informacion[index].fecha!)} ${DateFormat.Hms('es_ES').format(informacion[index].fecha!)}",
                                style: const TextStyle(
                                  color: kSecondaryColor,
                                  fontFamily: 'CronosLPro',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 16,
                            right: 16,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.signal_cellular_alt_rounded,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              const Text(
                                " Nivel de Señal: ",
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  fontFamily: 'CronosSPro',
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                informacion[index].nivelSignal.toString(),
                                style: const TextStyle(
                                  color: kSecondaryColor,
                                  fontFamily: 'CronosLPro',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          informacion[index].isManual == "SI"
                              ? const Icon(
                                  Icons.edit_note,
                                  color: kSecondaryColor,
                                  size: 22,
                                )
                              : Container(),
                          informacion[index].isManual == "SI"
                              ? const Divider()
                              : Container(),
                          informacion[index].enviado == "SI"
                              ? const Icon(
                                  Icons.check_circle,
                                  color: kSecondaryColor,
                                  size: 22,
                                )
                              : const Icon(
                                  Icons.wifi_off_outlined,
                                  color: kSecondaryColor,
                                  size: 22,
                                )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget getAppBarTracking() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  'Reporte de Lecturas',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'CronosSPro',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20 + 6 - 6 * topBarOpacity,
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
