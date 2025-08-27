import 'package:flutter/material.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/widgets/widgets.dart';
import 'package:miventa_app/app_styles.dart';

Widget buildBlisterResumen(Planning pdv, double screenWidth) {
  const TextStyle headerStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: kPrimaryColor,
  );

  const TextStyle labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );

  const TextStyle valueStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  Widget infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text(label, style: labelStyle)),
          Expanded(flex: 3, child: Text(value ?? '-', style: valueStyle)),
        ],
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Resumen de Blister Histórico ${pdv.invBlsHistFechaAct.toString() == "null" ? "SIN DATOS" : pdv.invBlsHistFechaAct!.replaceFirst('00:00:00', '')}", style: headerStyle),
        const SizedBox(height: 12),
        BuildKpiInfoDisplay(
            mesAct: pdv.invBlsHist.toString(),
            mesAnt: pdv.grsBlsHist.toString(),
            mom: pdv.cnvBlsHist.toString(),
            valor_1: "Activación Blister",
            valor_2: "Conversión Blister",
            title: "Asignación Blister",
            icono: 'assets/Iconos/cashOut.svg',
            screenWidth: screenWidth,
        ),
        buildUserInfoDisplay(
          getValue: pdv.invBlsDispHist.toString() == "null"
              ? "SIN DATOS"
              : pdv.invBlsDispHist.toString(),
          title: "Inventario Disponible",
          icono: 'assets/Iconos/info_dollar.svg',
          screenWidth: screenWidth,
        ),
        buildUserInfoDisplay(
          getValue: pdv.invBlsDescHist.toString() == "null"
              ? "SIN DATOS"
              : pdv.invBlsDescHist.toString(),
          title: "Inventario Descartado",
          icono: 'assets/Iconos/info_dollar.svg',
          screenWidth: screenWidth,
        ),
        const Divider(height: 24),
        const Text(
            "Detalle de Quiebre Blíster",
            style: headerStyle
        ),
        const SizedBox(height: 12),
        buildUserInfoDisplay(
          getValue: pdv.qbrBlsCantAsig.toString() == "null"
              ? "SIN DATOS"
              : pdv.qbrBlsCantAsig.toString(),
          title: "Series Asignadas con Quiebre",
          icono: 'assets/Iconos/info_dollar.svg',
          screenWidth: screenWidth,
        ),
        buildUserInfoDisplay(
          getValue: pdv.qbrBlsCantAct.toString() == "null"
              ? "SIN DATOS"
              : pdv.qbrBlsCantAct.toString(),
          title: "Series Activadas con Quiebre",
          icono: 'assets/Iconos/info_dollar.svg',
          screenWidth: screenWidth,
        ),
        buildUserInfoDisplay(
          getValue: pdv.qbrBls.toString() == "null"
              ? "SIN DATOS"
              : pdv.qbrBls == '1' ? 'Sí' : 'No',
          title: "Quiebre Blister",
          icono: 'assets/Iconos/info_dollar.svg',
          screenWidth: screenWidth,
        ),
        buildUserInfoDisplay(
          getValue: pdv.qbrBlsDias.toString() == "null"
              ? "SIN DATOS"
              : pdv.qbrBlsDias.toString(),
          title: "Quiebre acumulado (%)",
          icono: 'assets/Iconos/info_dollar.svg',
          screenWidth: screenWidth,
        ),
        buildUserInfoDisplay(
          getValue: pdv.qbrBlsDias.toString() == "null"
              ? "SIN DATOS"
              : pdv.qbrBlsDias.toString(),
          title: "Días Quiebre",
          icono: 'assets/Iconos/info_dollar.svg',
          screenWidth: screenWidth,
        ),
        buildUserInfoDisplay(
          getValue: pdv.qbrBlsEvalua.toString() == "null"
              ? "SIN DATOS"
              : pdv.qbrBlsEvalua == '1' ? 'Sí' : 'No',
          title: "¿Aplica a quiebre?",
          icono: 'assets/Iconos/info_dollar.svg',
          screenWidth: screenWidth,
        ),
      ],
    ),
  );
}
