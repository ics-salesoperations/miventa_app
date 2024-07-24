import 'dart:convert';

import 'package:miventa_app/models/model.dart';

Usuario usuarioFromMap(String str) => Usuario.fromMap(json.decode(str));
String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario extends Model {
  static String table = 'usuario';

  String? flag;
  String? idDms;
  String? usuario;
  String? nombre;
  String? identidad;
  String? territorio;
  int? perfil;
  String? telefono;
  String? correo;
  String? resultado;
  String? foto;

  Usuario({
    id,
    this.flag,
    this.idDms,
    this.usuario,
    this.nombre,
    this.identidad,
    this.territorio,
    this.perfil,
    this.telefono,
    this.correo,
    this.resultado,
    this.foto,
  }) : super(id);

  Usuario copyWith({
    int? id,
    String? flag,
    String? idDms,
    String? usuario,
    String? nombre,
    String? identidad,
    String? territorio,
    int? perfil,
    String? telefono,
    String? correo,
    String? resultado,
    String? foto,
  }) =>
      Usuario(
        id: id ?? this.id,
        flag: flag ?? this.flag,
        idDms: idDms ?? this.idDms,
        usuario: usuario ?? this.usuario,
        nombre: nombre ?? this.nombre,
        identidad: identidad ?? this.identidad,
        territorio: territorio ?? this.territorio,
        perfil: perfil ?? this.perfil,
        telefono: telefono ?? this.telefono,
        correo: correo ?? this.correo,
        resultado: resultado ?? this.resultado,
        foto: foto ?? this.foto,
      );

  static Usuario fromMap(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      flag: json['flag'].toString(),
      idDms: json['iddms'].toString(),
      usuario: json['usuario'].toString(),
      nombre: json['nombre'].toString(),
      identidad: json['identidad'].toString(),
      territorio: json['territorio'].toString(),
      perfil: json['perfil'],
      telefono: json['telefono'].toString(),
      correo: json['correo'].toString(),
      resultado: json['resultado'].toString(),
      foto: json['foto'].toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id,
      "flag": flag,
      "iddms": idDms,
      "usuario": usuario,
      "nombre": nombre,
      "identidad": identidad,
      "territorio": territorio,
      "perfil": perfil,
      "telefono": telefono,
      "correo": correo,
      "resultado": resultado,
      "foto": foto,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
