import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/pages/detallepdv_page.dart';

class BottomMapModal extends StatelessWidget {
  final Planning detalle;
  //final BuildContext ctx;

  const BottomMapModal({Key? key, required this.detalle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Detalle del Punto de Venta",
            style: TextStyle(
              color: kSecondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 24,
              fontFamily: 'CronosSPro',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "ID PDV: ",
                style: TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'Cronos-Pro',
                  fontSize: 16,
                  //backgroundColor: kThirdColor,
                  //fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                detalle.idPdv!.toString(),
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'CronosLPro',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Nombre PDV: ",
                style: TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'Cronos-Pro',
                  fontSize: 16,
                  //backgroundColor: kThirdColor,
                  //fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                detalle.nombrePdv!,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'CronosLPro',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Segmento: ",
                style: TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'Cronos-Pro',
                  fontSize: 16,
                  //backgroundColor: kThirdColor,
                  //fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                detalle.segmentoPdv!,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'CronosLPro',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Estado: ",
                style: TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'Cronos-Pro',
                  fontSize: 16,
                  //backgroundColor: kThirdColor,
                  //fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                detalle.dmsStatus!,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontFamily: 'CronosLPro',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetallePdvPage(
                        detallePdv: detalle,
                      ),
                    ),
                  );
                },
                elevation: 1,
                color: kPrimaryColor,
                child: const Text(
                  "Más información",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'CronosLPro',
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                elevation: 1,
                color: kPrimaryColor,
                child: const Text(
                  "Cerrar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'CronosLPro',
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
