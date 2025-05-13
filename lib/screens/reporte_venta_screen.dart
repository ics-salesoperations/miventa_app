import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:miventa_app/services/db_service.dart';
import 'package:miventa_app/models/models.dart';

// … (modelo ResumenModelo)

class ReporteResumenModeloScreen extends StatefulWidget {
  const ReporteResumenModeloScreen({super.key});
  @override
  _ReporteResumenModeloScreenState createState() =>
      _ReporteResumenModeloScreenState();
}

class _ReporteResumenModeloScreenState
    extends State<ReporteResumenModeloScreen> {
  final DBService db = DBService();
  List<ResumenModelo> resumen = [];
  String mensaje = '';
  DateTime? _desde, _hasta;

  @override
  void initState() {
    super.initState();
    _cargaResumen();
  }

  Future<void> _cargaResumen() async {
    setState(() => mensaje = 'Cargando resumen...');
    final lista = await db.leerResumenPorModelo(
      fechaInicio: _desde,
      fechaFin: _hasta,
    );
    setState(() {
      resumen = lista;
      mensaje = '';
    });
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

  Future<void> _exportarPdf() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen por Modelo'),
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
          children: [SizedBox(height: 200), Center(child: Text(mensaje))],
        )
            : resumen.isEmpty
            ? ListView(
          children: const [
            SizedBox(height: 200),
            Center(child: Text('No hay datos para este rango')),
          ],
        )
            : ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: resumen.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, i) {
            final r = resumen[i];
            return ListTile(
              title: Text(
                r.modelo,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Total: ${r.total}'),
              trailing: Text(
                r.precio == 0 ? '-' :'\L${r.precio.toStringAsFixed(2)}' ,
                style: const TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.picture_as_pdf),
        tooltip: 'Exportar a PDF',
        onPressed: _exportarPdf,
      ),
    );
  }
}
