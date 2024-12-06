import 'dart:math';

import 'package:intl/intl.dart';
import 'package:miventa_app/models/models.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();

  static Database? _db;

  LocalDatabase._init();

  static int get _version => 5;

  static Future<void> init() async {
    try {
      var databasePath = await getDatabasesPath();
      String _path = p.join(databasePath, 'miventa_app_database.db');
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
      );
    } catch (ex) {
      return;
    }
  }

  static void onCreate(Database db, int version) async {
    const stringType = 'STRING';
    const textType = 'TEXT';
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER';
    const realType = 'REAL';
    String sql = "";

    //creando tabla de control de Actualizaciones
    sql = """
              CREATE TABLE tablas (
                                    id $idType,
                                    tabla $stringType,
                                    descripcion $stringType,
                                    fechaActualizacion $stringType
                                    )
            """;
    await db.execute(sql);

    //creando tabla de usuarios
    sql = """
              CREATE TABLE usuario (
                                    id $idType,
                                    flag $stringType,
                                    iddms $stringType,
                                    usuario $stringType,
                                    nombre $stringType,
                                    identidad $stringType,
                                    territorio $stringType,
                                    perfil $integerType,
                                    telefono $stringType,
                                    correo $stringType,
                                    resultado $stringType,
                                    foto $textType
                                    )
            """;
    await db.execute(sql);

    //creando tabla de gerentes
    sql = """
              CREATE TABLE gerentes (
                                    id $idType,
                                    usuario $stringType,
                                    idDealer $stringType,
                                    idSucursal $stringType
                                    )
            """;
    await db.execute(sql);

    //insertando en tabla tabla de control de Actualizaciones
    // sql = """
    //           INSERT INTO tablas (
    //                                 tabla,
    //                                 descripcion
    //                                 )
    //                                 VALUES ('gerentes', 'Sucursales asignadas')
    //         """;
    // await db.execute(sql);

    /*CREANDO TABLA DE TRACKING DEL USUARIO HEAD*/
    sql = """
                CREATE TABLE tracking_head
                (
                id $idType,
                idTracking $textType,
                usuario $textType,
                fechaInicio $textType,
                fechaFin $textType
                )
      """;
    await db.execute(sql);

    /*CREANDO TABLA DE TRACKING DEL USUARIO DET*/
    sql = """
                CREATE TABLE tracking_det
                (
                id $idType,
                idTracking $textType,
                fecha $textType,
                latitude $realType,
                longitude $realType
                )
      """;
    await db.execute(sql);

    //insertando en tabla tabla de control de Actualizaciones
    sql = """
              INSERT INTO tablas (
                                    tabla,
                                    descripcion
                                    )
                                    VALUES ('planning', 'Planificación')
            """;
    await db.execute(sql);

    /*CREANDO TABLA DE DETALLE PDV*/
    sql = """
                CREATE TABLE planning
                (
                id $idType,
                idDealer $integerType,
                nombreDealer $textType,
                idSucursal $integerType,
                nombreSucursal $textType,
                idPdv $integerType,
                nombrePdv $textType,
                fechaCreacionPdv $textType,
                identidadDueno $textType,
                nombreDueno $textType,
                movilEpin $textType,
                movilActivador $integerType,
                dmsStatus $textType,
                categoria $textType,
                segmentoPdv $textType,
                permitePop $textType,
                miTienda $textType,
                nombreCircuito $textType,
                territorio $textType,
                idDepartamento $integerType,
                departamento $textType,
                ubicacion $textType,
                latitude $realType,
                longitude $realType,
                anomesAntVastrix $realType,
                anomesActVastrix $realType,
                vastrixMom $realType,
                fechaVisitaVen $textType,
                nombreVendedor $textType,
                anomesAntEpin $textType,
                anomesActEpin $textType,
                epinMom $textType,
                anomesAntGross $textType,
                anomesActGross $textType,
                grossMom $textType,
                anomesAntCashin $textType,
                anomesActCashin $textType,
                cashinMom $textType,
                anomesAntCashout $textType,
                anomesActCashout $textType,
                cashoutMom $textType,
                anomesAntPagos $textType,
                anomesActPagos $textType,
                pagosMom $textType,
                codEmpleadoDms $integerType,
                codigoCircuito $integerType,
                anomesActBlncTmy $textType,
                qbrTmy $textType,
                anomesActBlncMbl $textType,
                qbrMbl $textType,
                fechaActualizacion $textType,
                anomes $textType,
                nombreEmpleadoDms $textType,
                fecha $textType,
                visitado $textType,
                fechaVisita $textType,
                fechaFD11 $textType,
                fd11 $textType,
                movilTmy $textType,
                direccion $textType,
                numeroPadre $textType,
                servicios $textType,
                epinMiTienda $textType,
                grsBlsM0 $textType,
                grsBlsM1 $textType,
                grsBlsM2 $textType,
                grsBlsM3 $textType,
                invBls $textType,
                grsBls $textType,
                cnvBls $textType,
                invBlsDisp $textType
                )
      """;
    await db.execute(sql);

    //insertando en tabla tabla de control de Actualizaciones
    sql = """
              INSERT INTO tablas (
                                    tabla,
                                    descripcion
                                    )
                                    VALUES ('formulario', 'Formularios')
            """;
    await db.execute(sql);

    /*CREANDO TABLA DE FORMULARIOS*/
    sql = """
                CREATE TABLE formulario
                (
                id $idType,
                formId $integerType,
                formName $textType,
                formDescription $textType,
                questionId $integerType,
                questionText $textType,
                idQuestionType $integerType,
                questionType $textType,
                required $textType,
                questionOrder $integerType,
                offeredAnswer $textType,
                auto $integerType,
                shortText $textType,
                type $textType,
                subType $textType,
                conditional $integerType,
                parentQuestion $textType,
                parentAnswer $textType
                )
      """;
    await db.execute(sql);

    //insertando en tabla tabla de control de Actualizaciones
    sql = """
              INSERT INTO tablas (
                                    tabla,
                                    descripcion
                                    )
                                    VALUES ('modelo', 'Modelos')
            """;
    await db.execute(sql);

    /*CREANDO TABLA DE MODELOS*/
    sql = """
                CREATE TABLE modelo
                (
                id $idType,
                tangible $textType,
                modelo $textType,
                descripcion $textType,
                imagen $textType,
                asignado $integerType,
                disponible $integerType,
                serieInicial $textType,
                serieFinal $textType,
                descartado $integerType
                )
      """;
    await db.execute(sql);

    //insertando en tabla tabla de control de Actualizaciones
    sql = """
              INSERT INTO tablas (
                                    tabla,
                                    descripcion
                                    )
                                    VALUES ('tangible', 'Producto')
            """;
    await db.execute(sql);

    /*CREANDO TABLA DE FORMULARIOS*/
    sql = """
                CREATE TABLE tangible
                (
                id $idType,
                tangible $textType,
                modelo $textType,
                descModelo $textType,
                serie $textType,
                fechaAsignacion $textType,
                asignado $integerType,
                confirmado $integerType,
                enviado $integerType,
                idPdv $integerType,
                idVisita $textType,
                fechaVenta $textType
                )
      """;
    await db.execute(sql);

    sql = """
                CREATE TABLE tangible_reasignacion
                (
                id $idType,
                idPdv $integerType,
                tangible $textType,
                modelo $textType,
                descModelo $textType,
                serie $textType,
                fechaAsignacion $textType,
                asignado $integerType,
                confirmado $integerType,
                enviado $integerType,
                idVisita $textType,
                fechaVenta $textType,
                descartado $integerType
                )
      """;
    await db.execute(sql);

    /*CREANDO TABLA DE RESPUESTA DE FORMULARIOS*/
    sql = """
                CREATE TABLE formulario_answer
                (
                id $idType,
                instanceId $textType,
                formId $integerType,
                respondentId $textType,
                questionId $integerType,
                response $textType,
                fechaCreacion $textType,
                enviado $textType
                )
      """;
    await db.execute(sql);

    /*CREANDO TABLA DE REGISTRO DE VISITAS*/
    sql = """
                CREATE TABLE visita
                (
                id $idType,
                fechaInicioVisita $textType,
                fechaFinVisita $textType,
                idPDV $integerType,
                usuario $textType,
                latitud $realType,
                longitud $realType,
                enviado $textType,
                idVisita $textType
                )
      """;
    await db.execute(sql);

    //creando tabla de informacion de red automatico
    sql = """
              CREATE TABLE networkinfo (
                                    id $idType,
                                    marca $stringType,
                                    modelo $stringType,
                                    idLectura $textType,
                                    telefono $stringType,
                                    datos $stringType,
                                    localizacion $stringType,
                                    latitud $stringType,
                                    longitud $stringType,
                                    estadoRed $stringType,
                                    tipoRed $stringType,
                                    tipoTelefono $integerType,
                                    esRoaming $stringType,
                                    nivelSignal $stringType,
                                    dB $stringType,
                                    enviado $stringType,
                                    fecha $stringType,
                                    rsrp $stringType,
                                    rsrq $stringType,
                                    rssi $stringType,
                                    rsrpAsu $stringType,
                                    rssiAsu $stringType,
                                    cqi $stringType,
                                    snr $stringType,
                                    cid $stringType,
                                    eci $stringType,
                                    enb $stringType,
                                    networkIso $stringType,
                                    networkMcc $stringType,
                                    networkMnc $stringType,
                                    pci $stringType,
                                    cgi $stringType,
                                    ci $stringType,
                                    lac $stringType,
                                    psc $stringType,
                                    rnc $stringType,
                                    operatorName $stringType,
                                    isManual $stringType,
                                    background $stringType,
                                    fechaCorta $stringType
                                    )
            """;

    await db.execute(sql);

    //creando tabla de informacion de red manual
    sql = """
              CREATE TABLE manualnetworkinfo (
                                    id $idType,
                                    idLectura $textType,
                                    departamento $stringType,
                                    municipio $stringType,
                                    zona $stringType,
                                    ambiente $stringType,
                                    tipoAmbiente $stringType,
                                    descripcionAmbiente $stringType,
                                    comentarios $stringType,
                                    colonia $stringType,
                                    fallaDesde $stringType,
                                    horas $stringType,
                                    tipoAfectacion $stringType,
                                    afectacion $stringType,
                                    fotografia $textType,
                                    enviado $stringType,
                                    mbSubida $realType,
                                    mbBajada $realType
                                    )
            """;
    //creando tabla de IncentivoPdv ingresadas
    await db.execute(sql);

    sql = """
              CREATE TABLE solicitud (
                                    id $idType,
                                    codigo $stringType,
                                    idPdv $stringType,
                                    formId $stringType,
                                    formName $stringType,
                                    fecha $stringType,
                                    fechaRespuesta $stringType,
                                    comentarios $stringType,
                                    estado $stringType,
                                    usuario $stringType
                                    )
            """;

    await db.execute(sql);

    /*CREANDO TABLA DE SERVICIO BLISTER*/
    sql = """
                CREATE TABLE solicitud_automatica
                (
                id $idType,
                fecha $textType,
                usuario $textType,
                idPdv $stringType,
                tipo $textType,
                enviado $integerType
                )
      """;
    await db.execute(sql);

    /*CREANDO TABLA DE INCENTIVOS*/
    sql = """
                CREATE TABLE incentivo
                (
                id $idType,
                idPdv $integerType,
                incentivo $textType,
                meta $integerType)
      """;
    await db.execute(sql);
  }

  static void onUpgrade(Database db, int oldVersion, int version) async {
    const stringType = 'STRING';
    const textType = 'TEXT';
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER';
    const realType = 'REAL';
    String sql = "";

    if (oldVersion <= 1) {
      try {
        /*CREANDO TABLA DE SERVICIO BLISTER*/
        sql = """
                    CREATE TABLE solicitud_automatica
                    (
                    id $idType,
                    fecha $textType,
                    usuario $textType,
                    idPdv $stringType,
                    tipo $textType,
                    enviado $integerType
                    )
          """;
        /*CREANDO TABLA DE INCENTIVOS*/
        sql = """
                    CREATE TABLE incentivo
                    (
                    id $idType,
                    idPdv $integerType,
                    incentivo $textType,
                    meta $integerType)
          """;
        await db.execute(sql);
      } catch (_) {}
    } else if (oldVersion <= 2) {
      try {
        /*CREANDO TABLA DE REASIGNACION*/
        sql = """
                    CREATE TABLE tangible_reasignacion
                    (
                    id $idType,
                    idPdv $integerType,
                    tangible $textType,
                    modelo $textType,
                    descModelo $textType,
                    serie $textType,
                    fechaAsignacion $textType,
                    asignado $integerType,
                    confirmado $integerType,
                    enviado $integerType,
                    idVisita $textType,
                    fechaVenta $textType
                    )
          """;
        await db.execute(sql);
      } catch (_) {}
    } else if (oldVersion <= 3) {
      try {
        /*CREANDO TABLA DE REASIGNACION*/
        sql = """
                    alter table tangible_reasignacion add column descartado integer
          """;
        await db.execute(sql);
        sql = """
                    alter table modelo add column descartado integer
          """;
        await db.execute(sql);
      } catch (_) {}
    } else if (oldVersion <= 4) {
      try {
        sql = """
                    alter table plannig add column (
                    grsBlsM0 text, 
                    grsBlsM1 text, 
                    grsBlsM2 text, 
                    grsBlsM3 text, 
                    invBls text, 
                    grsBls text, 
                    cnvBls text, 
                    invBlsDisp text)""";
        await db.execute(sql);
      } catch (_) {}
    }
  }

  static Future<List<Map<String, dynamic>>> customQuery(String query) async {
    List<Map<String, dynamic>> resp = await _db!.rawQuery(query);
    return resp;
  }

  static Future<int> customUpdate(String query) async {
    int resp = await _db!.rawUpdate(query);
    return resp;
  }

  static Future<List<Map<String, dynamic>>> query(String table,
      {String find = 'id>=?', String findValue = '0'}) async {
    final resp = await _db!.query(table, where: find, whereArgs: [findValue]);
    /*final resp = await _db!.query(
      table,
    );*/
    return resp;
  }

  static Future<List<Map<String, dynamic>>> queryReporteSignal(String table,
      {String find = '1=?', int findValue = 1}) async {
    return _db!.query(
      table,
      where: find,
      whereArgs: [findValue],
      orderBy: "id DESC",
    );
  }

  static Future<int> insert(String table, Model model) async {
    final resp = await _db!.insert(table, model.toJson());
    return resp;
  }

  static Future<int> insertListPlan(List<Planning> datos) async {
    int resp = 0;

    Batch ba = _db!.batch();
    String query = """
                      INSERT INTO planning 
                      (
                        idDealer,
                        nombreDealer,
                        idSucursal,
                        nombreSucursal,
                        idPdv,
                        nombrePdv,
                        fechaCreacionPdv,
                        identidadDueno,
                        nombreDueno,
                        movilEpin,
                        movilActivador,
                        dmsStatus,
                        categoria,
                        segmentoPdv,
                        permitePop,
                        miTienda,
                        nombreCircuito,
                        territorio,
                        idDepartamento,
                        departamento,
                        ubicacion,
                        latitude,
                        longitude ,
                        anomesAntVastrix,
                        anomesActVastrix,
                        vastrixMom,
                        fechaVisitaVen,
                        nombreVendedor,
                        anomesAntEpin,
                        anomesActEpin,
                        epinMom,
                        anomesAntGross,
                        anomesActGross,
                        grossMom,
                        anomesAntCashin,
                        anomesActCashin,
                        cashinMom,
                        anomesAntCashout,
                        anomesActCashout,
                        cashoutMom,
                        anomesAntPagos,
                        anomesActPagos,
                        pagosMom,
                        codEmpleadoDms,
                        codigoCircuito,
                        anomesActBlncTmy,
                        qbrTmy,
                        anomesActBlncMbl,
                        qbrMbl,
                        fechaActualizacion,
                        anomes,
                        nombreEmpleadoDms,
                        fecha,
                        visitado,
                        fechaVisita, 
                        fd11,
                        fechaFd11,
                        movilTmy,
                        direccion,
                        numeroPadre,
                        servicios,
                        epinMiTienda,
                        grsBlsM0,
                        grsBlsM1,
                        grsBlsM2,
                        grsBlsM3,
                        invBls,
                        grsBls,
                        cnvBls,
                        invBlsDisp
                      )
                      VALUES
                      (
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?, 
                        ?,
                        ?,
                        ?,
                        ?,
                        ?
                      )
                    """;

    for (var dato in datos) {
      ba.rawInsert(query, [
        dato.idDealer,
        dato.nombreDealer,
        dato.idSucursal,
        dato.nombreSucursal,
        dato.idPdv,
        dato.nombrePdv,
        dato.fechaCreacionPdv,
        dato.identidadDueno,
        dato.nombreDueno,
        dato.movilEpin,
        dato.movilActivador,
        dato.dmsStatus,
        dato.categoria,
        dato.segmentoPdv,
        dato.permitePop,
        dato.miTienda,
        dato.nombreCircuito,
        dato.territorio,
        dato.idDepartamento,
        dato.departamento,
        dato.ubicacion,
        dato.latitude,
        dato.longitude,
        dato.anomesAntVastrix,
        dato.anomesActVastrix,
        dato.vastrixMom,
        dato.fechaVisitaVen,
        dato.nombreVendedor,
        dato.anomesAntEpin,
        dato.anomesActEpin,
        dato.epinMom,
        dato.anomesAntGross,
        dato.anomesActGross,
        dato.grossMom,
        dato.anomesAntCashin,
        dato.anomesActCashin,
        dato.cashinMom,
        dato.anomesAntCashout,
        dato.anomesActCashout,
        dato.cashoutMom,
        dato.anomesAntPagos,
        dato.anomesActPagos,
        dato.pagosMom,
        dato.codEmpleadoDms,
        dato.codigoCircuito,
        dato.anomesActBlncTmy,
        dato.qbrTmy,
        dato.anomesActBlncMbl,
        dato.qbrMbl,
        dato.fechaActualizacion,
        dato.anomes,
        dato.nombreEmpleadoDms,
        DateFormat('dd-MM-yyyy').format(dato.fecha!),
        dato.visitado,
        dato.fechaVisita?.toIso8601String(),
        dato.fd11,
        (dato.fechaFD11 != null)
            ? DateFormat('dd-MM-yyyy HH:mm:ss').format(dato.fechaFD11!)
            : null,
        dato.movilTmy,
        dato.direccion,
        dato.numeroPadre,
        dato.servicios,
        dato.epinMiTienda.toString() == 'null'
            ? '0'
            : dato.epinMiTienda.toString(),
        dato.grsBlsM0.toString() == 'null' ? '0' : dato.grsBlsM0.toString(),
        dato.grsBlsM1.toString() == 'null' ? '0' : dato.grsBlsM1.toString(),
        dato.grsBlsM2.toString() == 'null' ? '0' : dato.grsBlsM2.toString(),
        dato.grsBlsM3.toString() == 'null' ? '0' : dato.grsBlsM3.toString(),
        dato.invBls.toString() == 'null' ? '0' : dato.invBls.toString(),
        dato.grsBls.toString() == 'null' ? '0' : dato.grsBls.toString(),
        dato.cnvBls.toString() == 'null' ? '0' : dato.cnvBls.toString(),
        dato.invBlsDisp.toString() == 'null' ? '0' : dato.invBlsDisp.toString()
      ]);
    }
    //await _db!.execute(query, datos);
    await ba.commit(noResult: true);

    return resp;
  }

  static Future<int> insertListTangible(List<ProductoTangible> datos) async {
    int resp = 0;

    Batch ba = _db!.batch();
    String query = """
                      INSERT INTO tangible 
                      (
                        tangible,
                        modelo,
                        descModelo,
                        serie,
                        fechaAsignacion,
                        asignado,
                        confirmado,
                        enviado,
                        idPdv,
                        idVisita,
                        fechaVenta
                      )
                      VALUES
                      (
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?
                      )
                    """;

    for (var dato in datos) {
      ba.rawInsert(query, [
        dato.producto,
        dato.modelo,
        dato.descModelo,
        dato.serie,
        //dato.fechaAsignacion?.toIso8601String(),
        (dato.fechaAsignacion == null)
            ? null
            : DateFormat('dd-MM-yyyy HH:mm:ss').format(dato.fechaAsignacion!),
        dato.asignado,
        dato.confirmado,
        dato.enviado,
        dato.idPdv,
        dato.idVisita,
        //dato.fechaVenta?.toIso8601String()
        (dato.fechaVenta == null)
            ? null
            : DateFormat('dd-MM-yyyy HH:mm:ss').format(dato.fechaVenta!),
      ]);
    }
    //await _db!.execute(query, datos);
    await ba.commit(noResult: true);

    return resp;
  }

  static Future<int> insertListTangibleReasignacion(
      List<ProductoTangibleReasignacion> datos) async {
    int resp = 0;

    Batch ba = _db!.batch();
    String query = """
                      INSERT INTO tangible_reasignacion 
                      (
                        idPdv,
                        tangible,
                        modelo,
                        descModelo,
                        serie,
                        fechaAsignacion,
                        asignado,
                        confirmado,
                        enviado,
                        idVisita,
                        fechaVenta
                      )
                      VALUES
                      (
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?
                      )
                    """;

    for (var dato in datos) {
      print('Insertando reasignacion');
      print(dato.toString());
      ba.rawInsert(query, [
        dato.idPdv,
        dato.producto,
        dato.modelo,
        dato.descModelo,
        dato.serie,
        //dato.fechaAsignacion?.toIso8601String(),
        (dato.fechaAsignacion == null)
            ? null
            : DateFormat('dd-MM-yyyy HH:mm:ss').format(dato.fechaAsignacion!),
        dato.asignado,
        dato.confirmado,
        dato.enviado,
        dato.idVisita,
        //dato.fechaVenta?.toIso8601String()
        (dato.fechaVenta == null)
            ? null
            : DateFormat('dd-MM-yyyy HH:mm:ss').format(dato.fechaVenta!),
      ]);
    }
    //await _db!.execute(query, datos);
    await ba.commit(noResult: true);

    return resp;
  }

  static Future<int> insertListSolicitudes(List<Solicitudes> datos) async {
    int resp = 0;

    Batch ba = _db!.batch();
    String query = """
                      INSERT INTO solicitud 
                      (
                        codigo,
                        idPdv,
                        formId,
                        formName,
                        fecha,
                        fechaRespuesta,
                        comentarios,
                        estado,
                        usuario
                      )
                      VALUES
                      (
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?,
                        ?
                      )
                    """;

    for (var dato in datos) {
      ba.rawInsert(query, [
        dato.codigo,
        dato.idPdv,
        dato.formId,
        dato.formName,
        (dato.fecha == null)
            ? null
            : DateFormat('yyyy-MM-dd HH:mm:ss').format(dato.fecha!),
        (dato.fechaRespuesta == null)
            ? null
            : DateFormat('yyyy-MM-dd HH:mm:ss').format(dato.fechaRespuesta!),
        dato.comentarios,
        dato.estado,
        dato.usuario,
      ]);
    }
    //await _db!.execute(query, datos);
    await ba.commit(noResult: true);

    return resp;
  }

  // gerentes
  static Future<int> insertListSolicitudesGer(
      List<SolicitudesGer> datos) async {
    Batch ba = _db!.batch();
    String query = """
    INSERT INTO gerentes 
    (
      idDealer, 
      idSucursal
    )
    VALUES
    (
      ?,
      ?
    )
    """;

    for (var dato in datos) {
      ba.rawInsert(query, [dato.idDealer, dato.idSucursal]);
    }
    await ba.commit(noResult: true);
  
    return datos.length;
  }
  
  static Future<int> insertListIncentivoPdv(List<IncentivoPdv> datos) async {
    int resp = 0;

    Batch ba = _db!.batch();
    String query = """
                      INSERT INTO incentivo 
                      (
                        idPdv,
                        incentivo,
                        meta
                      ) 
                      VALUES
                      (
                        ?,
                        ?,
                        ?
                      )
                    """;

    for (var dato in datos) {
      ba.rawInsert(query, [dato.idPdv, dato.incentivo, dato.meta]);
    }
    //await _db!.execute(query, datos);

    await ba.commit(noResult: true);

    return resp;
  }

  static Future<int> update(String table, Model model) async {
    return _db!
        .update(table, model.toJson(), where: 'id=?', whereArgs: [model.id]);
  }

  static Future<int> updateModelo(String table, ModeloTangible model) async {
    return _db!.update(table, model.toJson(),
        where: 'tangible=? AND modelo=?',
        whereArgs: [model.tangible, model.modelo]);
  }

  static Future<int> delete(String table,
      {String? where, List<Object?>? whereArgs}) async {
    return _db!.delete(table, where: where, whereArgs: whereArgs);
  }

  static Future<int> deleteForm(String table, Model model) async {
    return _db!
        .update(table, model.toJson(), where: 'id=?', whereArgs: [model.id]);
  }

  static Future<int> deleteCaptura(String table, Model model) async {
    return _db!
        .update(table, model.toJson(), where: 'id=?', whereArgs: [model.id]);
  }

  static Future<int> deleteRespSync(String table) async {
    return _db!.delete(table, where: " enviado = ?", whereArgs: ["SI"]);
  }
}


