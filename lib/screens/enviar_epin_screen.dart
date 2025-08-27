import 'package:flutter/material.dart';
import 'dart:io' show Platform;
// Para Android, usaremos este paquete que ejecuta el código USSD.
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../app_styles.dart';

// NUEVO WIDGET: Un diálogo con estado.
class UssdModal extends StatefulWidget {
  final String pNumeroEpin; // Recibe la lista de números como un string
  final String pMonto;

  const UssdModal({
    super.key,
    required this.pNumeroEpin,
    required this.pMonto,
  });

  @override
  _UssdModalState createState() => _UssdModalState();
}

class _UssdModalState extends State<UssdModal> {
  final TextEditingController _ussdController =
  TextEditingController(text: "");
  bool _obscureText = true;
  // Estado para guardar el número Epin seleccionado
  String? _numeroEpinSeleccionado;

  // Lista de números que se mostrarán en el dropdown
  late List<String> _listaNumerosEpin;

  @override
  void initState() {
    super.initState();
    // 1. Dividimos el string de números en una lista
    _listaNumerosEpin = widget.pNumeroEpin.split(',');
    // 2. Si la lista no está vacía, seleccionamos el primer número por defecto
    if (_listaNumerosEpin.isNotEmpty) {
      _numeroEpinSeleccionado = _listaNumerosEpin.first;
    }

  }

  // La función para lanzar el código (se mantiene igual)
  Future<void> _launchUssd(String ussdCode) async {
    // ... (tu lógica de launchUssd va aquí sin cambios)
    try {
      if (Platform.isAndroid) {
        String androidCode = ussdCode.replaceAll('#', Uri.encodeComponent('#'));
        await FlutterPhoneDirectCaller.callNumber(androidCode);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al lanzar el código: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Venta de Saldo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Monto:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
          // Un espacio entre la etiqueta y el valor
          const SizedBox(width: 8),
            Text(
              widget.pMonto,
              style: const TextStyle(
                fontFamily: 'CronosLPro',
                color: kSecondaryColor,
                fontSize: 24,
              ),
            ),
           // El DropdownButton para seleccionar el número Epin
          DropdownButton<String>(
            value: _numeroEpinSeleccionado,
            isExpanded: true, // Para que ocupe todo el ancho
            hint: const Text("Seleccione un número"),
            onChanged: (String? nuevoValor) {
              setState(() {
                _numeroEpinSeleccionado = nuevoValor;
              });
            },
            items: _listaNumerosEpin.map<DropdownMenuItem<String>>((String valor) {
              return DropdownMenuItem<String>(
                value: valor,
                child: Text(valor),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // Campo de texto (lo mantenemos por si es necesario)
          TextField(
            controller: _ussdController,
            keyboardType: TextInputType.number,
            obscureText: _obscureText, // Usa la variable de estado aquí
            decoration: InputDecoration(
              labelText: 'Pin USSD',
              hintText: 'Ej: 1234',
              border: const OutlineInputBorder(),
              suffixIcon:
              GestureDetector(
                // Se activa en el momento en que el dedo TOCA el icono
                onTapDown: (_) {
                  setState(() {
                    _obscureText = false;
                  });
                },
                // Se activa cuando el dedo DEJA de tocar el icono
                onTapUp: (_) {
                  setState(() {
                    _obscureText = true;
                  });
                },
                // También es buena idea agregar onLongPressEnd por si el usuario
                // cancela el gesto de otra manera (ej. moviendo el dedo fuera)
                onTapCancel: () {
                  setState(() {
                    _obscureText = true;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text('Enviar'),
          onPressed: () {
            // Validamos que se haya seleccionado un número
            if (_numeroEpinSeleccionado == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Por favor, seleccione un número Epin.')),
              );
              return;
            }

            final String codigoCompleto = '*444*${_ussdController.text}*1*$_numeroEpinSeleccionado*${widget.pMonto}#';
            _launchUssd(codigoCompleto);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}


