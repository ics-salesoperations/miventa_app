import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/pages/detallepdv_page.dart';
import 'package:miventa_app/services/db_service.dart';

import '../widgets/headers.dart';

/// Example without a datasource
class ReporteQuiebreMovilScreen extends StatelessWidget {
  ReporteQuiebreMovilScreen({super.key});

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
                    "PDVs en Quiebre Móvil",
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
                child: FutureBuilder<List<ReporteQuiebre>>(
                    future: db.leerListadoQuiebreMovil(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      List<ReporteQuiebre> datos = snapshot.data!;
                      datos.sort(
                        (a, b) {
                          double saldo1 =
                              double.parse(a.saldo.replaceFirst('L ', ''));
                          double saldo2 =
                              double.parse(b.saldo.replaceFirst('L ', ''));
                          return saldo1.compareTo(saldo2);
                        },
                      );

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
                            label: Text('Fecha Actualización'),
                          ),
                          DataColumn2(
                            label: Text('ID PDV'),
                            size: ColumnSize.S,
                          ),
                          DataColumn(
                            label: Text('Nombre PDV'),
                          ),
                          DataColumn2(
                            label: Text('Quiebre'),
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Text('Saldo'),
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
                                      .format(datos[index].fechaActualizacion),
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
                                  datos[index].quiebre,
                                ),
                              ),
                              DataCell(
                                Text(
                                  "L " + datos[index].saldo,
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
