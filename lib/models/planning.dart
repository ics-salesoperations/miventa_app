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
    this.grsBlsM0,
    this.grsBlsM1,
    this.grsBlsM2,
    this.grsBlsM3,
    this.invBls,
    this.grsBls,
    this.cnvBls,
    this.invBlsDisp,
    this.invBlsDesc,
    this.enListaBlanca,
    this.invBlsHist,
    this.grsBlsHist,
    this.cnvBlsHist,
    this.invBlsDispHist,
    this.invBlsDescHist,
    this.qbrBlsCantAsig,
    this.qbrBlsCantAct,
    this.qbrBls,
    this.qbrBlsAcum,
    this.qbrBlsDias,
    this.qbrBlsEvalua,
    this.invBlsFechaAct,
    this.invBlsHistFechaAct,
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
  String? grsBlsM0;
  String? grsBlsM1;
  String? grsBlsM2;
  String? grsBlsM3;
  String? invBls;
  String? grsBls;
  String? cnvBls;
  String? invBlsDisp;
  String? invBlsDesc;
  String? enListaBlanca;
  String? invBlsHist;
  String? grsBlsHist;
  String? cnvBlsHist;
  String? invBlsDispHist;
  String? invBlsDescHist;
  String? qbrBlsCantAsig;
  String? qbrBlsCantAct;
  String? qbrBls;
  String? qbrBlsAcum;
  String? qbrBlsDias;
  String? qbrBlsEvalua;
  String? invBlsFechaAct;
  String? invBlsHistFechaAct;

  Planning copyWith(
          {int? id,
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
          String? grsBlsM0,
          String? grsBlsM1,
          String? grsBlsM2,
          String? grsBlsM3,
          String? invBls,
          String? grsBls,
          String? cnvBls,
          String? invBlsDisp,
          String? invBlsDesc,
          String? enListaBlanca,
          String? invBlsHist,
          String? grsBlsHist,
          String? cnvBlsHist,
          String? invBlsDispHist,
          String? invBlsDescHist,
          String? qbrBlsCantAsig,
          String? qbrBlsCantAct,
          String? qbrBls,
          String? qbrBlsAcum,
          String? qbrBlsDias,
          String? qbrBlsEvalua,
          String? invBlsFechaAct,
          String? invBlsHistFechaAct,
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
        grsBlsM0: grsBlsM0 ?? this.grsBlsM0,
        grsBlsM1: grsBlsM1 ?? this.grsBlsM1,
        grsBlsM2: grsBlsM2 ?? this.grsBlsM2,
        grsBlsM3: grsBlsM3 ?? this.grsBlsM3,
        invBls: invBls ?? this.invBls,
        grsBls: grsBls ?? this.grsBls,
        cnvBls: cnvBls ?? this.cnvBls,
        invBlsDisp: invBlsDisp ?? this.invBlsDisp,
        invBlsDesc: invBlsDesc ?? this.invBlsDesc,
        enListaBlanca: enListaBlanca ?? this.enListaBlanca,
        invBlsHist: invBlsHist ?? this.invBlsHist,
        grsBlsHist: grsBlsHist ?? this.grsBlsHist,
        cnvBlsHist: cnvBlsHist ?? this.cnvBlsHist,
        invBlsDispHist: invBlsDispHist ?? this.invBlsDispHist,
        invBlsDescHist: invBlsDescHist ?? this.invBlsDescHist,
        qbrBlsCantAsig: qbrBlsCantAsig ?? this.qbrBlsCantAsig,
        qbrBlsCantAct: qbrBlsCantAct ?? this.qbrBlsCantAct,
        qbrBls: qbrBls ?? this.qbrBls,
        qbrBlsAcum: qbrBlsAcum ?? this.qbrBlsAcum,
        qbrBlsDias: qbrBlsDias ?? this.qbrBlsDias,
        qbrBlsEvalua: qbrBlsEvalua ?? this.qbrBlsEvalua,
        invBlsFechaAct: invBlsFechaAct ?? this.invBlsFechaAct,
        invBlsHistFechaAct: invBlsHistFechaAct ?? this.invBlsHistFechaAct,
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
      grsBlsM0: json["grsBlsM0"].toString(),
      grsBlsM1: json["grsBlsM1"].toString(),
      grsBlsM2: json["grsBlsM2"].toString(),
      grsBlsM3: json["grsBlsM3"].toString(),
      invBls: json["invBls"].toString(),
      grsBls: json["grsBls"].toString(),
      cnvBls: json["cnvBls"].toString(),
      invBlsDisp: json["invBlsDisp"].toString(),
      invBlsDesc: json["invBlsDesc"].toString(),
      enListaBlanca: json["enListaBlanca"] ?? "NO",
      invBlsHist: json["invBlsHist"].toString(),
      grsBlsHist: json["grsBlsHist"].toString(),
      cnvBlsHist: json["cnvBlsHist"].toString(),
      invBlsDispHist: json["invBlsDispHist"].toString(),
      invBlsDescHist: json["invBlsDescHist"].toString(),
      qbrBlsCantAsig: json["qbrBlsCantAsig"].toString(),
      qbrBlsCantAct: json["qbrBlsCantAct"].toString(),
      qbrBls: json["qbrBls"].toString(),
      qbrBlsAcum: json["qbrBlsAcum"].toString(),
      qbrBlsDias: json["qbrBlsDias"].toString(),
      qbrBlsEvalua: json["qbrBlsEvalua"].toString(),
      invBlsFechaAct: json["invBlsFechaAct"].toString(),
      invBlsHistFechaAct: json["invBlsHistFechaAct"].toString(),
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
      "grsBlsM0": grsBlsM0,
      "grsBlsM1": grsBlsM1,
      "grsBlsM2": grsBlsM2,
      "grsBlsM3": grsBlsM3,
      "invBls": invBls,
      "grsBls": grsBls,
      "cnvBls": cnvBls,
      "invBlsDisp": invBlsDisp,
      "invBlsDesc": invBlsDesc,
      "enListaBlanca": enListaBlanca ?? "NO",
      "invBlsHist": invBlsHist,
      "grsBlsHist": grsBlsHist,
      "cnvBlsHist": cnvBlsHist,
      "invBlsDispHist": invBlsDispHist,
      "invBlsDescHist": invBlsDescHist,
      "qbrBlsCantAsig": qbrBlsCantAsig,
      "qbrBlsCantAct": qbrBlsCantAct,
      "qbrBls": qbrBls,
      "qbrBlsAcum": qbrBlsAcum,
      "qbrBlsDias": qbrBlsDias,
      "qbrBlsEvalua": qbrBlsEvalua,
      "invBlsFechaAct": invBlsFechaAct,
      "invBlsHistFechaAct": invBlsHistFechaAct,
    };
  }
}
