import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';// donde esté kSecondaryColor

class CardKPI extends StatelessWidget {
  final String titulo;
  final double m0;
  final double m1;
  final double variacion;
  final String anomes;

  const CardKPI({
    required this.titulo,
    required this.m0,
    required this.m1,
    required this.variacion,
    required this.anomes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color colorVar = variacion > 0
        ? Colors.green
        : variacion < 0
        ? Colors.red
        : kSecondaryColor;

    final IconData iconVar = variacion > 0
        ? Icons.arrow_upward
        : variacion < 0
        ? Icons.arrow_downward
        : Icons.remove;

    final formatter = NumberFormat('#,##0.00', 'en_US');

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Borde superior de color
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorVar,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          // Contenido
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMetric('Mes Anterior', m1, formatter),
                    _buildMetric('Mes Actual', m0, formatter),
                    _buildVariation(colorVar, iconVar, formatter),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, double value, NumberFormat formatter) {
    return Column(
      children: [
        Text(
          formatter.format(value),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildVariation(Color color, IconData icon, NumberFormat formatter) {
    return Column(
      children: [
        Icon(icon, color: color),
        Text(
          formatter.format(variacion),
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        const Text('Var.'),
      ],
    );
  }
}
