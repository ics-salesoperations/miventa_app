import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class Planning extends Model {
  static String table = 'planning';

  Planning({
    id,
    this.idDealer,
    this.nombreDealer,
    this.idSucursal,
    this.nombreSucursal,
    this.idPdv,
    this.nombrePdv,
    this.fechaCreacionPdv,
    this.nombreDueno,
    this.identidadDueno,
    this.movilEpin,
    this.movilActivador,
    this.dmsStatus,
    this.categoria,
    this.segmentoPdv,
    this.permitePop,
    this.miTienda,
    this.nombreCircuito,
    this.territorio,
    this.idDepartamento,
    this.departamento,
    this.ubicacion,
    this.longitude,
    this.latitude,
    this.fechaVisitaVen,
    this.nombreVendedor,
    this.anomesAntEpin,
    this.anomesActEpin,
    this.epinMom,
    this.anomesAntVastrix,
    this.anomesActVastrix,
    this.vastrixMom,
    this.anomesAntGross,
    this.anomesActGross,
    this.grossMom,
    this.anomesAntCashin,
    this.anomesActCashin,
    this.cashinMom,
    this.anomesAntCashout,
    this.anomesActCashout,
    this.cashoutMom,
    this.anomesAntPagos,
    this.anomesActPagos,
    this.pagosMom,
    this.anomesActBlncTmy,
    this.qbrTmy,
    this.anomesActBlncMbl,
    this.qbrMbl,
    this.fechaActualizacion,
    this.anomes,
    this.fecha,
    this.codEmpleadoDms,
    this.nombreEmpleadoDms,
    this.codigoCircuito,
    this.visitado = 'NO',
    this.fechaVisita,
    this.fechaFD11,
    this.fd11,
    this.movilTmy,
    this.direccion,
    this.numeroPadre,
    this.servicios,
    this.epinMiTienda,
  }) : super(id);

  int? idDealer;
  String? nombreDealer;
  int? idSucursal;
  String? nombreSucursal;
  int? idPdv;
  String? nombrePdv;
  String? fechaCreacionPdv;
  String? nombreDueno;
  String? identidadDueno;
  String? movilEpin;
  int? movilActivador;
  String? dmsStatus;
  String? categoria;
  String? segmentoPdv;
  String? permitePop;
  String? miTienda;
  String? nombreCircuito;
  String? territorio;
  int? idDepartamento;
  String? departamento;
  String? ubicacion;
  double? longitude;
  double? latitude;
  String? fechaVisitaVen;
  String? nombreVendedor;
  String? anomesAntEpin;
  String? anomesActEpin;
  String? epinMom;
  String? anomesAntVastrix;
  String? anomesActVastrix;
  String? vastrixMom;
  String? anomesAntGross;
  String? anomesActGross;
  String? grossMom;
  String? anomesAntCashin;
  String? anomesActCashin;
  String? cashinMom;
  String? anomesAntCashout;
  String? anomesActCashout;
  String? cashoutMom;
  String? anomesAntPagos;
  String? anomesActPagos;
  String? pagosMom;
  String? anomesActBlncTmy;
  String? qbrTmy;
  String? anomesActBlncMbl;
  String? qbrMbl;
  String? fechaActualizacion;
  String? anomes;
  DateTime? fecha;
  int? codEmpleadoDms;
  String? nombreEmpleadoDms;
  int? codigoCircuito;
  String? visitado;
  DateTime? fechaVisita;
  DateTime? fechaFD11;
  String? fd11;
  String? movilTmy;
  String? direccion;
  String? numeroPadre;
  String? servicios;
  String? epinMiTienda;

  Planning copyWith({
    int? id,
    int? idDealer,
    String? nombreDealer,
    int? idSucursal,
    String? nombreSucursal,
    int? idPdv,
    String? nombrePdv,
    String? fechaCreacionPdv,
    String? nombreDueno,
    String? identidadDueno,
    String? movilEpin,
    int? movilActivador,
    String? dmsStatus,
    String? categoria,
    String? segmentoPdv,
    String? permitePop,
    String? miTienda,
    String? nombreCircuito,
    String? territorio,
    int? idDepartamento,
    String? departamento,
    String? ubicacion,
    double? longitude,
    double? latitude,
    String? fechaVisitaVen,
    String? nombreVendedor,
    String? anomesAntEpin,
    String? anomesActEpin,
    String? epinMom,
    String? anomesAntVastrix,
    String? anomesActVastrix,
    String? vastrixMom,
    String? anomesAntGross,
    String? anomesActGross,
    String? grossMom,
    String? anomesAntCashin,
    String? anomesActCashin,
    String? cashinMom,
    String? anomesAntCashout,
    String? anomesActCashout,
    String? cashoutMom,
    String? anomesAntPagos,
    String? anomesActPagos,
    String? pagosMom,
    String? anomesActBlncTmy,
    String? qbrTmy,
    String? anomesActBlncMbl,
    String? qbrMbl,
    String? fechaActualizacion,
    String? anomes,
    DateTime? fecha,
    int? codEmpleadoDms,
    String? nombreEmpleadoDms,
    int? codigoCircuito,
    String? visitado,
    DateTime? fechaVisita,
    DateTime? fechaFD11,
    String? fd11,
    String? movilTmy,
    String? direccion,
    String? numeroPadre,
    String? servicios,
    String? epinMiTienda,
  }) =>
      Planning(
        id: id ?? this.id,
        idDealer: idDealer ?? this.idDealer,
        nombreDealer: nombreDealer ?? this.nombreDealer,
        idSucursal: idSucursal ?? this.idSucursal,
        nombreSucursal: nombreSucursal ?? this.nombreSucursal,
        idPdv: idPdv ?? this.idPdv,
        nombrePdv: nombrePdv ?? this.nombrePdv,
        fechaCreacionPdv: fechaCreacionPdv ?? this.fechaCreacionPdv,
        nombreDueno: nombreDueno ?? this.nombreDueno,
        identidadDueno: identidadDueno ?? this.identidadDueno,
        movilEpin: movilEpin ?? this.movilEpin,
        movilActivador: movilActivador ?? this.movilActivador,
        dmsStatus: dmsStatus ?? this.dmsStatus,
        categoria: categoria ?? this.categoria,
        segmentoPdv: segmentoPdv ?? this.segmentoPdv,
        permitePop: permitePop ?? this.permitePop,
        miTienda: miTienda ?? this.miTienda,
        nombreCircuito: nombreCircuito ?? this.nombreCircuito,
        territorio: territorio ?? this.territorio,
        idDepartamento: idDepartamento ?? this.idDepartamento,
        departamento: departamento ?? this.departamento,
        ubicacion: ubicacion ?? this.ubicacion,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        fechaVisitaVen: fechaVisitaVen ?? this.fechaVisitaVen,
        nombreVendedor: nombreVendedor ?? this.nombreVendedor,
        anomesAntEpin: anomesAntEpin ?? this.anomesAntEpin,
        anomesActEpin: anomesActEpin ?? this.anomesActEpin,
        epinMom: epinMom ?? this.epinMom,
        anomesAntVastrix: anomesAntVastrix ?? this.anomesAntVastrix,
        anomesActVastrix: anomesActVastrix ?? this.anomesActVastrix,
        vastrixMom: vastrixMom ?? this.vastrixMom,
        anomesAntGross: anomesAntGross ?? this.anomesAntGross,
        anomesActGross: anomesActGross ?? this.anomesActGross,
        grossMom: grossMom ?? this.grossMom,
        anomesAntCashin: anomesAntCashin ?? this.anomesAntCashin,
        anomesActCashin: anomesActCashin ?? this.anomesActCashin,
        cashinMom: cashinMom ?? this.cashinMom,
        anomesAntCashout: anomesAntCashout ?? this.anomesAntCashout,
        anomesActCashout: anomesActCashout ?? this.anomesActCashout,
        cashoutMom: cashoutMom ?? this.cashoutMom,
        anomesAntPagos: anomesAntPagos ?? this.anomesAntPagos,
        anomesActPagos: anomesActPagos ?? this.anomesActPagos,
        pagosMom: pagosMom ?? this.pagosMom,
        anomesActBlncTmy: anomesActBlncTmy ?? this.anomesActBlncTmy,
        qbrTmy: qbrTmy ?? this.qbrTmy,
        anomesActBlncMbl: anomesActBlncMbl ?? this.anomesActBlncMbl,
        qbrMbl: qbrMbl ?? this.qbrMbl,
        fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
        anomes: anomes ?? this.anomes,
        fecha: fecha ?? this.fecha,
        codEmpleadoDms: codEmpleadoDms ?? this.codEmpleadoDms,
        nombreEmpleadoDms: nombreEmpleadoDms ?? this.nombreEmpleadoDms,
        codigoCircuito: codigoCircuito ?? this.codigoCircuito,
        visitado: visitado ?? this.visitado,
        fechaVisita: fechaVisita ?? this.fechaVisita,
        fechaFD11: fechaFD11 ?? this.fechaFD11,
        fd11: fd11 ?? this.fd11,
        movilTmy: movilTmy ?? this.movilTmy,
        direccion: direccion ?? this.direccion,
        numeroPadre: numeroPadre ?? this.numeroPadre,
        servicios: servicios ?? this.servicios,
        epinMiTienda: epinMiTienda ?? this.epinMiTienda,
      );

  factory Planning.fromJson(Map<String, dynamic> json) {
    return Planning(
      id: json["id"],
      fecha: DateFormat('dd-MM-yyyy').parse(json["fecha"]),
      idDealer: json["idDealer"],
      nombreDealer: json["nombreDealer"].toString(),
      idSucursal: json["idSucursal"],
      nombreSucursal: json["nombreSucursal"].toString(),
      idPdv: json["idPdv"],
      nombrePdv: json["nombrePdv"].toString(),
      fechaCreacionPdv: json["fechaCreacionPdv"].toString(),
      nombreDueno: json["nombreDueno"].toString(),
      identidadDueno: json["identidadDueno"].toString(),
      movilEpin: json["movilEpin"].toString(),
      movilActivador: json["movilActivador"],
      dmsStatus: json["dmsStatus"].toString(),
      categoria: json["categoria"].toString(),
      segmentoPdv: json["segmentoPdv"].toString(),
      permitePop: json["permitePop"].toString(),
      miTienda: json["miTienda"].toString(),
      nombreCircuito: json["nombreCircuito"].toString(),
      territorio: json["territorio"].toString(),
      idDepartamento: json["idDepartamento"],
      departamento: json["departamento"].toString(),
      ubicacion: json["ubicacion"].toString(),
      longitude: json["longitude"] == null ? 0 : json["longitude"].toDouble(),
      latitude: json["latitude"] == null ? 0 : json["latitude"].toDouble(),
      fechaVisitaVen: json["fechaVisitaVen"].toString(),
      nombreVendedor: json["nombreVendedor"].toString(),
      anomesAntEpin: json["anomesAntEpin"].toString(),
      anomesActEpin: json["anomesActEpin"].toString(),
      epinMom: json["epinMom"].toString(),
      anomesAntVastrix: json["anomesAntVastrix"].toString(),
      anomesActVastrix: json["anomesActVastrix"].toString(),
      vastrixMom: json["vastrixMom"].toString(),
      anomesAntGross: json["anomesAntGross"].toString(),
      anomesActGross: json["anomesActGross"].toString(),
      grossMom: json["grossMom"].toString(),
      anomesAntCashin: json["anomesAntCashin"].toString(),
      anomesActCashin: json["anomesActCashin"].toString(),
      cashinMom: json["cashinMom"].toString(),
      anomesAntCashout: json["anomesAntCashout"].toString(),
      anomesActCashout: json["anomesActCashout"].toString(),
      cashoutMom: json["cashoutMom"].toString(),
      anomesAntPagos: json["anomesAntPagos"].toString(),
      anomesActPagos: json["anomesActPagos"].toString(),
      pagosMom: json["pagosMom"].toString(),
      anomesActBlncTmy: json["anomesActBlncTmy"].toString(),
      qbrTmy: json["qbrTmy"].toString(),
      anomesActBlncMbl: json["anomesActBlncMbl"].toString(),
      qbrMbl: json["qbrMbl"].toString(),
      fechaActualizacion: json["fechaActualizacion"].toString(),
      anomes: json["anomes"].toString(),
      codEmpleadoDms: json["codEmpleadoDms"],
      nombreEmpleadoDms: json["nombreEmpleadoDms"].toString(),
      codigoCircuito: json["codigoCircuito"],
      visitado: json["visitado"],
      fechaVisita: json["fechaVisita"] == null
          ? null
          : DateTime.parse(json["fechaVisita"]),
      fechaFD11: json["fechaFD11"] == null
          ? null
          : DateFormat('dd-MM-yyyy HH:mm:ss').parse(json["fechaFD11"]),
      fd11: json["fd11"],
      movilTmy: json["movilTmy"].toString(),
      direccion: json["direccion"].toString(),
      numeroPadre: json["numeroPadre"].toString(),
      servicios: json["servicios"] ?? "",
      epinMiTienda: json["epinMiTienda"].toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "idDealer": idDealer,
      "nombreDealer": nombreDealer,
      "idSucursal": idSucursal,
      "nombreSucursal": nombreSucursal,
      "idPdv": idPdv,
      "nombrePdv": nombrePdv,
      "fechaCreacionPdv": fechaCreacionPdv,
      "nombreDueno": nombreDueno,
      "identidadDueno": identidadDueno,
      "movilEpin": movilEpin,
      "movilActivador": movilActivador,
      "dmsStatus": dmsStatus,
      "categoria": categoria,
      "segmentoPdv": segmentoPdv,
      "permitePop": permitePop,
      "miTienda": miTienda,
      "nombreCircuito": nombreCircuito,
      "territorio": territorio,
      "idDepartamento": idDepartamento,
      "departamento": departamento,
      "ubicacion": ubicacion,
      "longitude": longitude,
      "latitude": latitude,
      "fechaVisitaVen": fechaVisitaVen,
      "nombreVendedor": nombreVendedor,
      "anomesAntEpin": anomesAntEpin,
      "anomesActEpin": anomesActEpin,
      "epinMom": epinMom,
      "anomesAntVastrix": anomesAntVastrix,
      "anomesActVastrix": anomesActVastrix,
      "vastrixMom": vastrixMom,
      "anomesAntGross": anomesAntGross,
      "anomesActGross": anomesActGross,
      "grossMom": grossMom,
      "anomesAntCashin": anomesAntCashin,
      "anomesActCashin": anomesActCashin,
      "cashinMom": cashinMom,
      "anomesAntCashout": anomesAntCashout,
      "anomesActCashout": anomesActCashout,
      "cashoutMom": cashoutMom,
      "anomesAntPagos": anomesAntPagos,
      "anomesActPagos": anomesActPagos,
      "pagosMom": pagosMom,
      "anomesActBlncTmy": anomesActBlncTmy,
      "qbrTmy": qbrTmy,
      "anomesActBlncMbl": anomesActBlncMbl,
      "qbrMbl": qbrMbl,
      "fechaActualizacion": fechaActualizacion,
      "anomes": anomes,
      "fecha": DateFormat('dd-MM-yyyy').format(fecha!),
      "codEmpleadoDms": codEmpleadoDms,
      "nombreEmpleadoDms": nombreEmpleadoDms,
      "codigoCircuito": codigoCircuito,
      "visitado": visitado ?? "NO",
      "fechaVisita":
          fechaVisita != null ? fechaVisita!.toIso8601String() : null,
      "fechaFD11": fechaFD11 != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').format(fechaFD11!)
          : null,
      "fd11": fd11,
      "movilTmy": movilTmy,
      "direccion": direccion,
      "numeroPadre": numeroPadre,
      "servicios": servicios,
      "epinMiTienda":
          epinMiTienda.toString() == 'null' ? '0' : epinMiTienda.toString(),
    };
  }
}
