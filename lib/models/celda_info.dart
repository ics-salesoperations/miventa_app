import 'dart:convert';

CeldaInfo celdaInfoFromMap(String str) => CeldaInfo.fromMap(json.decode(str));
String celdaInfoToJson(CeldaInfo data) => json.encode(data.toJson());

class CeldaInfo {
  String? tipo;
  String? dbm;
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

  CeldaInfo({
    this.tipo,
    this.dbm,
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
  });

  static CeldaInfo fromMap(Map<String, dynamic> json) {
    return CeldaInfo(
      tipo: json['tipo'].toString(),
      dbm: json['dbm'].toString(),
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
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "tipo": tipo,
      "dbm": dbm,
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
    };

    return map;
  }

  CeldaInfo copyWith({
    String? tipo,
    String? dbm,
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
  }) =>
      CeldaInfo(
        tipo: tipo ?? this.tipo,
        dbm: dbm ?? this.dbm,
        rsrp: rsrp ?? this.rsrp,
        rsrq: rsrq ?? this.rsrq,
        rssi: rssi ?? this.rssi,
        rsrpAsu: rsrpAsu ?? this.rsrpAsu,
        rssiAsu: rssiAsu ?? this.rssiAsu,
        cqi: cqi ?? this.cqi,
        snr: snr ?? this.snr,
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
      );
}
