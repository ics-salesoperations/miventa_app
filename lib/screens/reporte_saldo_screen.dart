import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:miventa_app/services/db_service.dart';
import 'package:miventa_app/models/models.dart';
import 'package:data_table_2/data_table_2.dart';

// … (modelo ResumenModelo)

class ReporteResumenSaldoScreen extends StatefulWidget {
  const  ReporteResumenSaldoScreen({super.key});
  @override
  _ReporteResumenSaldoScreenState createState() =>
      _ReporteResumenSaldoScreenState();
}

class _ReporteResumenSaldoScreenState
    extends State<ReporteResumenSaldoScreen> {
  final DBService db = DBService();

  // Formateador para Lempiras
  final currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: 'L ',decimalDigits: 0);

  List<SaldoReporte> resumen = [];
  String mensaje = '';
  DateTime? _desde, _hasta;

  // 1. Estado para controlar la fila de fecha que está expandida
  String? _expandedFecha;

  // 2. Función _generarFilasConSubtotales modificada para ser colapsible
  List<DataRow> _generarFilasConSubtotales(List<SaldoReporte> lista) {
    final Map<String, List<SaldoReporte>> agrupadoPorDia = {};
    for (var r in lista) {
      final fecha = DateFormat('MMM dd').format(r.fechaHoraTfr);
      agrupadoPorDia.putIfAbsent(fecha, () => []).add(r);
    }

    final List<DataRow> filas = [];

    agrupadoPorDia.forEach((fecha, registros) {
      final isExpanded = _expandedFecha == fecha;
      final totalDia = registros.fold<double>(0, (prev, r) =>
      prev + (double.tryParse(r.montoTfr.replaceAll(',', '')) ?? 0));

      // Fila de Subtotal
      filas.add(DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
              (states) {
            if (isExpanded) return Theme.of(context).colorScheme.primary.withOpacity(0.1);
            return Colors.grey[200];
          },
        ),
        cells: [
          DataCell(
            // La celda ahora contiene el detector del toque.
            Row(
              children: [
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  size: 20,
                  color: Colors.black54,
                ),
                const SizedBox(width: 8),
                Text(fecha, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            onTap: () {
              setState(() {
                _expandedFecha = isExpanded ? null : fecha;
              });
            },
          ),
          const DataCell(Text('')),
          DataCell(Text(
            currencyFormatter.format(totalDia),
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
          const DataCell(Text('')),
        ],
      ));

      // Las filas de detalle no cambian
      if (isExpanded) {
        for (var r in registros) {
          filas.add(DataRow(cells: [
            DataCell(Padding(
              padding: const EdgeInsets.only(left: 38.0),
              child: Text(DateFormat('dd HH:mm').format(r.fechaHoraTfr)),
            )),
            DataCell(Container(
              width: 100,
              alignment: Alignment.centerLeft,
              child: Text(r.nombrePdv, softWrap: true),
            )),
            DataCell(Text(currencyFormatter.format(double.tryParse(r.montoTfr)))),
            DataCell(Text(currencyFormatter.format(double.tryParse(r.saldoPdv)))),
          ]));
        }
      }
    });

    return filas;
  }



  @override
  void initState() {
    super.initState();
    _cargaResumen();
  }

  Future<void> _cargaResumen() async {
    setState(() => mensaje = 'Cargando resumen...');
    final lista = await db.leerReporteSaldo(
      fechaInicio: _desde,
      fechaFin: _hasta,
    );


    setState(() {
      resumen = lista;
      mensaje = '';
    });

    double totalMontoTfr = 0;
    for (var r in resumen) {
      final monto = double.tryParse(r.montoTfr.replaceAll(',', '')) ?? 0;
      totalMontoTfr += monto;
    }

  }

  Future<void> _seleccionarFecha(BuildContext ctx, bool esDesde) async {
    final ahora = DateTime.now();
    final inicial = esDesde ? (_desde ?? ahora) : (_hasta ?? ahora);
    final res = await showDatePicker(
      context: ctx,
      initialDate: inicial,
      firstDate: DateTime(2020),
      lastDate: ahora,
    );
    if (res != null) {
      setState(() {
        if (esDesde) _desde = res; else _hasta = res;
      });
      await _cargaResumen();
    }
  }

  /*Future<void> _exportarPdf() async {
    final pdf = pw.Document();
    // Encabezados y filas
    final data = resumen.map((r) => [
      r.modelo,
      r.total.toString(),
      r.precio == 0 ?   '-':r.precio.toStringAsFixed(2),
    ]).toList();

    pdf.addPage(
      pw.Page(
        build: (_) => pw.Column(
          children: [
            pw.Text(
              'Resumen por Modelo\n'
                  '(${_desde!=null?DateFormat('dd/MM/yyyy').format(_desde!):'--'}'
                  ' - '
                  '${_hasta!=null?DateFormat('dd/MM/yyyy').format(_hasta!):'--'})',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 12),
            pw.Table.fromTextArray(
              headers: ['Modelo', 'Total', 'Precio'],
              data: data,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellAlignment: pw.Alignment.centerLeft,
              headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
            ),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (_) => pdf.save(),
      name: 'resumen_modelo.pdf',
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    // El widget build no necesita cambios, ya que la lógica está encapsulada
    // en _generarFilasConSubtotales.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Venta Epin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            tooltip: 'Fecha inicio',
            onPressed: () => _seleccionarFecha(context, true),
          ),
          IconButton(
            icon: const Icon(Icons.date_range_outlined),
            tooltip: 'Fecha fin',
            onPressed: () => _seleccionarFecha(context, false),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _cargaResumen,
        child: mensaje.isNotEmpty
            ? ListView(
          children: [
            const SizedBox(height: 200),
            Center(child: Text(mensaje))
          ],
        )
            : resumen.isEmpty
            ? ListView(
          children: const [
            SizedBox(height: 200),
            Center(child: Text('No hay datos para este rango')),
          ],
        )
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: DataTable2(
                columnSpacing: 20.0,
                headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.3)),
                columns: const [
                  DataColumn2(
                      label: Text('Fecha',
                          style:
                          TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn2(
                      label: Text('PDV',
                          style:
                          TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn2(
                      label: Text('Monto',
                          style:
                          TextStyle(fontWeight: FontWeight.bold)),
                      numeric: true),
                  DataColumn2(
                      label: Text('Saldo PDV',
                          style:
                          TextStyle(fontWeight: FontWeight.bold)),
                      numeric: true),
                ],
                rows: [
                  ..._generarFilasConSubtotales(resumen),
                  // Fila total general
                  DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>(
                            (_) => Colors.blueGrey[200]),
                    cells: [
                      const DataCell(Text('TOTAL',
                          style: TextStyle(
                              fontWeight: FontWeight.bold))),
                      const DataCell(Text('')),
                      DataCell(Text(
                        currencyFormatter.format(resumen.fold<double>(
                            0,
                                (prev, r) =>
                            prev +
                                (double.tryParse(r.montoTfr
                                    .replaceAll(',', '')) ??
                                    0))),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      )),
                      const DataCell(Text('')),
                    ],
                  ),
                ],
              ),
            ),
      ),

      /* floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.picture_as_pdf),
        tooltip: 'Exportar a PDF',
        onPressed: _exportarPdf,
      )*/
    );
  }
}
