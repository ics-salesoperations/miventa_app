import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/pages/detallepdv_page.dart';
import 'package:miventa_app/services/db_service.dart';

import '../widgets/headers.dart';

/// Example without a datasource
class ReporteFordis11Screen extends StatelessWidget {
  ReporteFordis11Screen({super.key});

  final DBService db = DBService();

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
                  const Text(
                    "FORDIS11 pendientes",
                    style: TextStyle(
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
                child: FutureBuilder<List<Fordis11>>(
                    future: db.leerListadoFD11(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      List<Fordis11> datos = snapshot.data!;
                      datos
                          .sort(((a, b) => a.fechaFD11.compareTo(b.fechaFD11)));

                      return DataTable2(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 600,
                        dataTextStyle: const TextStyle(
                          fontFamily: 'CronosLPro',
                          fontSize: 14,
                          color: kSecondaryColor,
                        ),
                        headingTextStyle: const TextStyle(
                          fontFamily: 'CronosSPro',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: const [
                              BoxShadow(color: Colors.black38)
                            ]),
                        columns: const [
                          DataColumn2(
                            label: Text('#'),
                            size: ColumnSize.S,
                          ),
                          DataColumn(
                            label: Text('Fecha'),
                          ),
                          DataColumn2(
                            label: Text('Circuito'),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Text('ID PDV'),
                            size: ColumnSize.S,
                          ),
                          DataColumn(
                            label: Text('Nombre PDV'),
                          ),
                          DataColumn2(
                            label: Text('Descripción'),
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Text('Contestado'),
                            size: ColumnSize.S,
                          ),
                        ],
                        rows: List<DataRow>.generate(
                          datos.length,
                          (index) => DataRow(
                            onLongPress: () async {
                              final pdv = await db
                                  .leerPDV(datos[index].idPdv.toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetallePdvPage(
                                    detallePdv: pdv,
                                  ),
                                ),
                              );
                            },
                            cells: [
                              DataCell(
                                Text((index + 1).toString()),
                              ),
                              DataCell(
                                Text(
                                  DateFormat('dd-MM-yyyy HH:mm:ss')
                                      .format(datos[index].fechaFD11),
                                ),
                              ),
                              DataCell(
                                Text(
                                  datos[index].nombreCircuito.toString(),
                                ),
                              ),
                              DataCell(
                                Text(
                                  datos[index].idPdv.toString(),
                                ),
                              ),
                              DataCell(
                                Text(
                                  datos[index].nombrePdv,
                                ),
                              ),
                              DataCell(
                                Text(
                                  datos[index].fd11,
                                ),
                              ),
                              DataCell(
                                Text(
                                  datos[index].contestado,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
