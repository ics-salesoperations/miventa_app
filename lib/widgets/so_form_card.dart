// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/db_service.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SOFormCard extends StatefulWidget {
  final ResumenSincronizar res;

  const SOFormCard({
    Key? key,
    required this.res,
  }) : super(key: key);

  @override
  State<SOFormCard> createState() => _SOFormCardState();
}

class _SOFormCardState extends State<SOFormCard> {
  DBService db = DBService();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
          colors: [
            kPrimaryColor,
            kSecondaryColor,
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 18,
                      child: FaIcon(
                        FontAwesomeIcons.calendarDays,
                        size: 16,
                        color: kThirdColor,
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.white,
                      width: 10,
                    ),
                    const Text(
                      "FECHA:      ",
                      style: TextStyle(
                        color: kFourColor,
                        fontFamily: 'CronossPro',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy HH:mm:ss')
                          .format(widget.res.fecha!),
                      style: const TextStyle(
                        color: kSecondaryColor,
                        fontFamily: 'CronosLPro',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 18,
                      child: FaIcon(
                        FontAwesomeIcons.store,
                        size: 16,
                        color: kThirdColor,
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.white,
                      width: 10,
                    ),
                    const Text(
                      "ID PDV:     ",
                      style: TextStyle(
                        color: kFourColor,
                        fontFamily: 'CronossPro',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.res.idPdv.toString() == 'null'
                          ? '0'
                          : widget.res.idPdv.toString(),
                      style: const TextStyle(
                        color: kSecondaryColor,
                        fontFamily: 'CronosSPro',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 18,
                      child: FaIcon(
                        widget.res.tipo == 'VISITA'
                            ? FontAwesomeIcons.house
                            : FontAwesomeIcons.fileInvoice,
                        size: 16,
                        color: kThirdColor,
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.white,
                      width: 10,
                    ),
                    const Text(
                      "TIPO:         ",
                      style: TextStyle(
                        color: kFourColor,
                        fontFamily: 'CronossPro',
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.res.tipo.toString(),
                        style: const TextStyle(
                          color: kSecondaryColor,
                          fontFamily: 'CronosSPro',
                          fontSize: 16,
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            //height: 40,
            width: 40,
            child: CircularPercentIndicator(
              radius: 20,
              circularStrokeCap: CircularStrokeCap.round,
              percent: (widget.res.porcentajeSync! / 100),
              backgroundColor: kFourColor,
              animationDuration: 1000,
              center: Text(
                "${widget.res.porcentajeSync}%",
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'CronosLPro',
                  fontSize: 12,
                ),
              ),
              backgroundWidth: 5,
              lineWidth: 7,
              linearGradient: LinearGradient(
                colors: [
                  kThirdColor,
                  kThirdColor.withOpacity(0.9),
                  kThirdColor.withOpacity(0.8),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          const FaIcon(
            FontAwesomeIcons.angleRight,
            size: 28,
            color: kPrimaryColor,
          )
        ],
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(10),
    //   child: Card(
    //     clipBehavior: Clip.antiAlias,
    //     child: Column(
    //       children: <Widget>[
    //         SizedBox(
    //           height: 5,
    //           child: Container(
    //             decoration: BoxDecoration(
    //               color:
    //                   res.porcentajeSync == 100 ? Colors.grey : kPrimaryColor,
    //               shape: BoxShape.rectangle,
    //             ),
    //           ),
    //         ),
    //         // ScrollOnExpand(
    //         //   scrollOnExpand: true,
    //         //   scrollOnCollapse: false,
    //         //   child: ExpandablePanel(
    //         //     theme: const ExpandableThemeData(
    //         //       headerAlignment: ExpandablePanelHeaderAlignment.center,
    //         //       tapBodyToCollapse: true,
    //         //     ),
    //         //     header: Padding(
    //         //       padding: const EdgeInsets.all(10),
    //         //       child: Text(
    //         //         DateFormat('dd/MM/yyyy H:m:s').format(fecha),
    //         //         style: const TextStyle(
    //         //           color: Colors.black,
    //         //           fontSize: 16,
    //         //           fontWeight: FontWeight.w400,
    //         //           fontFamily: 'Cronos-Pro',
    //         //         ),
    //         //       ),
    //         //     ),
    //         //     collapsed: Row(
    //         //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         //       children: [
    //         //         Text(
    //         //           res.tipo.toString(),
    //         //           softWrap: true,
    //         //           maxLines: 2,
    //         //           overflow: TextOverflow.ellipsis,
    //         //           style: TextStyle(
    //         //             color: kSecondaryColor.withOpacity(0.8),
    //         //             fontSize: 16,
    //         //             fontWeight: FontWeight.w500,
    //         //             fontFamily: 'Cronos-Pro',
    //         //           ),
    //         //         ),
    //         //         Text(
    //         //           res.porcentajeSync != 100 ? "Enviado" : "Sin Enviar",
    //         //           softWrap: true,
    //         //           maxLines: 2,
    //         //           overflow: TextOverflow.ellipsis,
    //         //           style: const TextStyle(
    //         //             color: kSecondaryColor,
    //         //             fontSize: 16,
    //         //             fontWeight: FontWeight.w400,
    //         //             fontFamily: 'Cronos-Pro',
    //         //           ),
    //         //         ),
    //         //       ],
    //         //     ),
    //         //     expanded: Container(
    //         //       height: 200,
    //         //       width: MediaQuery.of(context).size.width * 0.75,
    //         //       child: FutureBuilder<List<DetalleAnswer>>(
    //         //           future:
    //         //               db.leerRespuestasDetalle(instanceId: res.idVisita!),
    //         //           builder: (context, snapshot) {
    //         //             if (!snapshot.hasData) {
    //         //               return CircularProgressIndicator();
    //         //             }
    //         //             List<DetalleAnswer> detalle = const [];
    //         //             detalle = snapshot.data!;
    //         //             return ListView.builder(
    //         //               itemCount: detalle.length,
    //         //               itemBuilder: (ctx, index) {
    //         //                 final tipo = detalle[index].questionType;
    //         //                 Uint8List bytes = Uint8List(100000);
    //         //                 if (tipo == "Fotografia") {
    //         //                   bytes = base64.decode(detalle[index].response!);
    //         //                 }

    //         //                 return tipo == "Fotografia"
    //         //                     ? Column(children: [
    //         //                         Row(
    //         //                           children: [
    //         //                             Flexible(
    //         //                               child: Text(
    //         //                                 detalle[index].questionText!,
    //         //                                 style: const TextStyle(
    //         //                                   fontFamily: 'CronosLPro',
    //         //                                   fontSize: 14,
    //         //                                   color: kSecondaryColor,
    //         //                                 ),
    //         //                                 maxLines: 3,
    //         //                               ),
    //         //                             ),
    //         //                           ],
    //         //                         ),
    //         //                         SizedBox(
    //         //                           height: 120,
    //         //                           width: 120,
    //         //                           child: FittedBox(
    //         //                             fit: BoxFit.cover,
    //         //                             child: Image.memory(
    //         //                               bytes,
    //         //                               width: 120,
    //         //                               height: 120,
    //         //                             ),
    //         //                           ),
    //         //                         ),
    //         //                         const Divider(),
    //         //                       ])
    //         //                     : Column(
    //         //                         children: [
    //         //                           Row(
    //         //                               mainAxisAlignment:
    //         //                                   MainAxisAlignment.spaceBetween,
    //         //                               children: [
    //         //                                 Flexible(
    //         //                                   child: Text(
    //         //                                     detalle[index].questionText!,
    //         //                                     style: const TextStyle(
    //         //                                       fontFamily: 'CronosLPro',
    //         //                                       fontSize: 14,
    //         //                                       color: kSecondaryColor,
    //         //                                     ),
    //         //                                     maxLines: 3,
    //         //                                   ),
    //         //                                 ),
    //         //                                 const SizedBox(
    //         //                                   width: 15,
    //         //                                 ),
    //         //                                 Flexible(
    //         //                                   child: Text(
    //         //                                     detalle[index].response!,
    //         //                                     style: const TextStyle(
    //         //                                       fontFamily: 'CronosLPro',
    //         //                                       fontSize: 14,
    //         //                                       color: kSecondaryColor,
    //         //                                     ),
    //         //                                     textAlign: TextAlign.right,
    //         //                                   ),
    //         //                                 ),
    //         //                               ]),
    //         //                           const Divider(),
    //         //                         ],
    //         //                       );
    //         //               },
    //         //             );
    //         //           }),
    //         //     ),
    //         //     builder: (_, collapsed, expanded) {
    //         //       return Padding(
    //         //         padding:
    //         //             const EdgeInsets.only(left: 10, right: 10, bottom: 10),
    //         //         child: Expandable(
    //         //           collapsed: collapsed,
    //         //           expanded: expanded,
    //         //           theme: const ExpandableThemeData(
    //         //             crossFadePoint: 0,
    //         //             iconColor: kPrimaryColor,
    //         //             inkWellBorderRadius: BorderRadius.all(
    //         //               Radius.circular(30),
    //         //             ),
    //         //           ),
    //         //         ),
    //         //       );
    //         //     },
    //         //   ),
    //         // ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
