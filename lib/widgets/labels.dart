import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String mensaje;
  final String pregunta;

  const Labels(
      {Key? key,
      required this.ruta,
      required this.mensaje,
      required this.pregunta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Text(pregunta,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              )),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            //para detectar acciones del usuario en el contenido
            child: Text(mensaje,
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
          ),
        ],
    );
  }
}
