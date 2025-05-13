// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.flag,
    required this.usuario,
    required this.token,
    required this.exp,
    this.mensaje
  });

  String flag;
  String usuario;
  String token;
  int exp;
  String? mensaje;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    flag: json["flag"],
    usuario: json["usuario"],
    token: json["token"],
    exp: json["exp"],
    mensaje: json["mensaje"]
  );

  Map<String, dynamic> toJson() => {
    "flag": flag,
    "usuario": usuario,
    "token": token,
    "exp": exp,
    "mensaje": mensaje
  };
}
