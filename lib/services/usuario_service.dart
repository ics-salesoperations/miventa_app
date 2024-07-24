import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miventa_app/global/environment.dart';
import 'package:miventa_app/models/usuario.dart';
import 'package:miventa_app/services/auth_service.dart';
import 'package:miventa_app/services/db_service.dart';

import '../models/usuario_response.dart';

class UsuarioService with ChangeNotifier {
  DBService dbService = DBService();
  final AuthService _authService = AuthService();

  Future<bool> guardarUsuario() async {
    try {
      final resp = await http
          .get(Uri.parse('${Environment.apiURL}/usuario/info'), headers: {
        'Content-Type': 'application/json',
        'token': await _authService.getToken()
      });

      final usuarioResponse = usuarioResponseFromMap(resp.body);

      //eliminando usuario antes de insertar
      await dbService.deleteUsuario();

      //guardar usuario en base de datos local
      await dbService.addUsuario(usuarioResponse.usuario);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Usuario> getInfoUsuario() async {
    try {
      final usuario = await dbService.getUsuario();
      print(usuario);
      return usuario.first;
    } catch (e) {
      print("ha ocurrido un error");
      print(":::::::::EROROROOR::::::::" + e.toString());
      Usuario usuario = Usuario(
        flag: "false",
        idDms: "0",
        usuario: "0",
        nombre: "nombre2",
        identidad: "identidad",
        territorio: "territorio",
        perfil: 0,
        telefono: "telefono",
        correo: "correo",
        resultado: "fallido",
      );

      return usuario;
    }
  }
}
