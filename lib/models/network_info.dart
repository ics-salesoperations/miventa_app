import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:miventa_app/models/models.dart';

NetworkInfo networkInfoFromMap(String str) =>
    NetworkInfo.fromMap(json.decode(str));
String networkInfoToJson(NetworkInfo data) => json.encode(data.toJson());

class NetworkInfo extends Model {
  static String table = 'networkinfo';
  String? idLectura;
  String? telefono;
  String? marca;
  String? modelo;
  String? datos;
  String? localizacion;
  String? latitud;
  String? longitud;
  String? estadoRed;
  String? tipoRed;
  String? tipoTelefono;
  String? esRoaming;
  String? nivelSignal;
  String? dB;
  String? enviado;
  DateTime? fecha;
  String? rsrp;
  String? rsrq;
  String? rssi;
  String? rsrpAsu;
  String? rssiAsu;
  String? cqi;
  String? snr;
  String? cid;
  String? eci;
  String? enb;
  String? networkIso;
  String? networkMcc;
  String? networkMnc;
  String? pci;
  //propiedades para 3G
  String? cgi;
  String? ci;
  String? lac;
  String? psc;
  String? rnc;
  String? operatorName;
  String? isManual;
  String? background;
  String? fechaCorta;

  NetworkInfo({
    id,
    this.idLectura,
    this.telefono,
    this.marca,
    this.modelo,
    this.datos,
    this.localizacion,
    this.latitud,
    this.longitud,
    this.estadoRed,
    this.tipoRed,
    this.tipoTelefono,
    this.esRoaming,
    this.nivelSignal,
    this.dB,
    this.enviado,
    this.fecha,
    this.rsrp,
    this.rsrq,
    this.rssi,
    this.rsrpAsu,
    this.rssiAsu,
    this.cqi,
    this.snr,
    this.cid,
    this.eci,
    this.enb,
    this.networkIso,
    this.networkMcc,
    this.networkMnc,
    this.pci,
    this.cgi,
    this.ci,
    this.lac,
    this.psc,
    this.rnc,
    this.operatorName,
    this.isManual = "NO",
    this.background = "NO",
    this.fechaCorta,
  }) : super(id);

  static NetworkInfo fromMap(Map<String, dynamic> json) {
    return NetworkInfo(
      id: json['id'],
      idLectura: json['idLectura'].toString(),
      telefono: json['telefono'].toString(),
      marca: json['marca'].toString(),
      modelo: json['modelo'].toString(),
      datos: json['datos'].toString(),
      localizacion: json['localizacion'].toString(),
      latitud: json['latitud'].toString(),
      longitud: json['longitud'].toString(),
      estadoRed: json['estadoRed'].toString(),
      tipoRed: json['tipoRed'].toString(),
      tipoTelefono: json['tipoTelefono'].toString(),
      esRoaming: json['esRoaming'],
      nivelSignal: json['nivelSignal'].toString(),
      dB: json['dB'].toString(),
      enviado: json['enviado'].toString(),
      fecha: DateTime.parse(json["fecha"]),
      rsrp: json['rsrp'].toString(),
      rsrq: json['rsrq'].toString(),
      rssi: json['rssi'].toString(),
      rsrpAsu: json['rsrpAsu'].toString(),
      rssiAsu: json['rssiAsu'].toString(),
      cqi: json['cqi'].toString(),
      snr: json['snr'].toString(),
      cid: json['cid'].toString(),
      eci: json['eci'].toString(),
      enb: json['enb'].toString(),
      networkIso: json['networkIso'].toString(),
      networkMcc: json['networkMcc'].toString(),
      networkMnc: json['networkMnc'].toString(),
      pci: json['pci'].toString(),
      cgi: json['cgi'].toString(),
      ci: json['ci'].toString(),
      lac: json['lac'].toString(),
      psc: json['psc'].toString(),
      rnc: json['rnc'].toString(),
      operatorName: json['operatorName'].toString(),
      isManual: json['isManual'].toString(),
      background: json['background'].toString(),
      fechaCorta: DateFormat.yMd().format(DateTime.parse(json["fecha"])),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id,
      "idLectura": idLectura,
      "telefono": telefono,
      "marca": marca,
      "modelo": modelo,
      "datos": datos,
      "localizacion": localizacion,
      "latitud": latitud,
      "longitud": longitud,
      "estadoRed": estadoRed,
      "tipoRed": tipoRed,
      "tipoTelefono": tipoTelefono,
      "esRoaming": esRoaming,
      "nivelSignal": nivelSignal,
      "dB": dB,
      "enviado": enviado,
      "fecha": fecha?.toIso8601String(),
      "rsrp": rsrp,
      "rsrq": rsrq,
      "rssi": rssi,
      "rsrpAsu": rsrpAsu,
      "rssiAsu": rssiAsu,
      "cqi": cqi,
      "snr": snr,
      "cid": cid,
      "eci": eci,
      "enb": enb,
      "networkIso": networkIso,
      "networkMcc": networkMcc,
      "networkMnc": networkMnc,
      "pci": pci,
      "cgi": cgi,
      "ci": ci,
      "lac": lac,
      "psc": psc,
      "rnc": rnc,
      "operatorName": operatorName,
      "isManual": isManual,
      "background": background,
      "fechaCorta": fechaCorta,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  NetworkInfo copyWith({
    int? id,
    String? idLectura,
    String? telefono,
    String? marca,
    String? modelo,
    String? datos,
    String? localizacion,
    String? latitud,
    String? longitud,
    String? estadoRed,
    String? tipoRed,
    String? tipoTelefono,
    String? esRoaming,
    String? nivelSignal,
    String? dB,
    String? enviado,
    DateTime? fecha,
    String? rsrp,
    String? rsrq,
    String? rssi,
    String? rsrpAsu,
    String? rssiAsu,
    String? cqi,
    String? snr,
    String? cid,
    String? eci,
    String? enb,
    String? networkIso,
    String? networkMcc,
    String? networkMnc,
    String? pci,
    String? cgi,
    String? ci,
    String? lac,
    String? psc,
    String? rnc,
    String? operatorName,
    String? isManual,
    String? background,
    String? fechaCorta,
  }) =>
      NetworkInfo(
        id: id ?? this.id,
        idLectura: idLectura ?? this.idLectura,
        telefono: telefono ?? this.telefono,
        marca: marca ?? this.marca,
        modelo: modelo ?? this.modelo,
        datos: datos ?? this.datos,
        localizacion: localizacion ?? this.localizacion,
        latitud: latitud ?? this.latitud,
        longitud: longitud ?? this.longitud,
        estadoRed: estadoRed ?? this.estadoRed,
        tipoRed: tipoRed ?? this.tipoRed,
        tipoTelefono: tipoTelefono ?? this.tipoTelefono,
        esRoaming: esRoaming ?? this.esRoaming,
        nivelSignal: nivelSignal ?? this.nivelSignal,
        dB: dB ?? this.dB,
        enviado: enviado ?? this.enviado,
        fecha: fecha ?? this.fecha,
        rsrp: rsrp ?? this.rsrp,
        rsrq: rsrq ?? this.rsrq,
        rssi: rssi ?? this.rssi,
        rsrpAsu: rsrpAsu ?? this.rsrpAsu,
        rssiAsu: rssiAsu ?? this.rssiAsu,
        cqi: cqi ?? this.cqi,
        snr: rssi ?? this.snr,
        cid: cid ?? this.cid,
        eci: eci ?? this.eci,
        enb: enb ?? this.enb,
        networkIso: networkIso ?? this.networkIso,
        networkMcc: networkMcc ?? this.networkMcc,
        networkMnc: networkMnc ?? this.networkMnc,
        pci: pci ?? this.pci,
        cgi: cgi ?? this.cgi,
        ci: ci ?? this.ci,
        lac: lac ?? this.lac,
        psc: psc ?? this.psc,
        rnc: rnc ?? this.rnc,
        operatorName: operatorName ?? this.operatorName,
        isManual: isManual ?? this.isManual,
        background: background ?? this.background,
        fechaCorta: fechaCorta ?? this.fechaCorta,
      );
}
