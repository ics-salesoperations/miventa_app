import 'dart:convert';
import 'package:miventa_app/models/usuario.dart';

UsuarioResponse usuarioResponseFromMap(String str) =>
    UsuarioResponse.fromMap(json.decode(str));

String usuarioResponseToJson(UsuarioResponse data) =>
    json.encode(data.toJson());

class UsuarioResponse {
  String flag;
  Usuario usuario;

  UsuarioResponse({
    required this.flag,
    required this.usuario,
  });

  static UsuarioResponse fromMap(Map<String, dynamic> json) => UsuarioResponse(
        flag: json["flag"],
        usuario: Usuario.fromMap(json["usuario"]),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "usuario": usuario.toJson(),
      };
}
