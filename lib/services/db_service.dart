import 'package:intl/intl.dart';
import 'package:miventa_app/localdb/local_database.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/models/resumen_answer.dart';

class DBService {
  /*INICIALIZAR BASE DE DATOS */
  Future<void> inicializarBD() async {
    await LocalDatabase.init();
  }

  /*INICIO FUNCIONES PARA USUARIO*/
  Future<List<Usuario>> getUsuario() async {
    await LocalDatabase.init();

    List<Map<String, dynamic>> usuario =
        await LocalDatabase.query(Usuario.table);

    return usuario.map((item) => Usuario.fromMap(item)).toList();
  }

  Future<bool> addUsuario(Usuario model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.insert(Usuario.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> updateUsuario(Usuario model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.update(Usuario.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> deleteUsuario() async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.delete(Usuario.table);

    return resp > 0 ? true : false;
  }

  /* FIN EVENTOS PARA USUARIO*/

  /* INICIO EVENTOS PARA DETALLE PDV*/
  Future crearDetallePdv(List<Planning> detpdv) async {
    await LocalDatabase.init();
    await LocalDatabase.delete('planning');
    await LocalDatabase.insertListPlan(detpdv);
  }

  Future crearDetalleSolicitudes(List<Solicitudes> datos) async {
    await LocalDatabase.init();
    await LocalDatabase.delete('solicitud');
    await LocalDatabase.insertListSolicitudes(datos);
  }

//crear detalle de la tabla de generentes
  Future crearDetalleGerente(List<SolicitudesGer> datos) async {
    await LocalDatabase.init();
    await LocalDatabase.delete('gerentes');
    await LocalDatabase.insertListSolicitudesGer(datos);
  }

  Future crearDetalleIncentivoPdv(List<IncentivoPdv> datos) async {
    await LocalDatabase.init();

    int idPdv = datos.first.idPdv!;
    await LocalDatabase.delete('incentivo',
        where: 'idPdv = ?', whereArgs: [idPdv]);
    if (datos.isNotEmpty) {
      await LocalDatabase.insertListIncentivoPdv(datos);
    }
  }

  Future crearDetalleIndicadoresVendedor(List<IndicadoresVendedor> datos) async {
    await LocalDatabase.init();

    int anomes = datos.first.anomes!;
    await LocalDatabase.delete('indicadores',
        where: 'anomes = ?', whereArgs: [anomes]);
    if (datos.isNotEmpty) {
      await LocalDatabase.insertListIndicadoresVendedor(datos);
    }
  }

  Future<int> insertardetallePDV(Planning detpdv) async {
    await LocalDatabase.init();
    final resultado = await LocalDatabase.insert(Planning.table, detpdv);

    return resultado;
  }

  Future<List<Planning>> leerDetallePdv(int idPdv) async {
    await LocalDatabase.init();
    List<Map<String, dynamic>> maps = await LocalDatabase.query(
      Planning.table,
      find: 'idPdv = ?',
      findValue: "$idPdv",
    );
    return maps.map((item) => Planning.fromJson(item)).toList();
  }

  Future<List<Planning>> filtrarDetallePdv(String filtro) async {
    await LocalDatabase.init();

    final query = """
                    SELECT *
                    FROM detallepdv
                    WHERE nombrePdv LIKE  '%$filtro%' 
                  """;

    List<Map<String, dynamic>> maps = await LocalDatabase.customQuery(query);

    return maps.map((item) => Planning.fromJson(item)).toList();
  }

  Future<int> actualizarDetallePdv(Planning detpdv) async {
    await LocalDatabase.init();

    return LocalDatabase.update(Planning.table, detpdv);
  }

  Future<int> deleteDetallePdv() async {
    await LocalDatabase.init();

    return LocalDatabase.delete(Planning.table);
  }

  /* FIN EVENTOS PARA DETALLEPDV*/

  /*INICIO DE EVENTOS PARA PLANNING */
  Future crearPlanning(List<Planning> plan) async {
    await LocalDatabase.init();
    LocalDatabase.delete('planning');

    for (var pdv in plan) {
      await LocalDatabase.insert('planning', pdv);
    }
  }

  Future crearSaldoVendedor(List<SaldoVendedor> detpdv) async {
    await LocalDatabase.init();
    await LocalDatabase.delete('saldo');
    await LocalDatabase.insertListSaldo(detpdv);
  }

  Future<int> actualizarPdvPlanning(Planning pdv) async {
    await LocalDatabase.init();

    return LocalDatabase.update(Planning.table, pdv);
  }

  Future<List<Planning>> leerListadoPdv({
    String? idSucursal,
    String? codigoCircuito,
    List<Circuito>? circuitos,
    DateTime? fecha,
    String? usuario,
    bool mapa = false,
    String? nombreCircuito,
    String? segmento,
    String? servicio,
  }) async {
    String where = "";
    String fechaFormatted = "";

    if (idSucursal != null && idSucursal.isNotEmpty) {
      where = " AND idSucursal = $idSucursal";
    }
// inicio nuevo -----------------------------------------------------------------
    if (segmento != null && segmento.isNotEmpty) {
      where += """ AND CASE 
                              WHEN segmentoPdv = 'N/A' THEN 'OTRO'
                              WHEN segmentoPdv = 'null' THEN 'OTRO'
                              WHEN segmentoPdv IS NULL THEN 'OTRO'
                              ELSE segmentoPdv
                           END = '$segmento'""";
    }

    // if (nombreCircuito != null && nombreCircuito.isNotEmpty) {
    //   where = where + " AND nombreCircuito = '$nombreCircuito'";
    // }
    if (servicio != null && servicio.isNotEmpty) {
      where = where + " AND servicios LIKE '%${servicio.toUpperCase()}%'";
    }

    //fin nuevo: ----------------------------------------------------

    if (codigoCircuito != null && codigoCircuito.isNotEmpty) {
      where = where + " AND nombreCircuito = '$codigoCircuito'";
    }

    if (circuitos != null && circuitos.isNotEmpty) {
      final listaCodigos = circuitos.map((item) => item.codigoCircuito);

      final listaCircuitos = listaCodigos.join(",");
      where = where + " AND codigoCircuito IN ($listaCircuitos)";
    }

    if (fecha != null) {
      fechaFormatted = DateFormat('dd-MM-yyyy').format(fecha);
      where = where + " AND fecha = '$fechaFormatted' ";
    }

    if (mapa &&
        (codigoCircuito == null || codigoCircuito.isEmpty) &&
        (circuitos == null || circuitos.isEmpty)) {
      String fechaFormatted = DateFormat('dd-MM-yyyy').format(DateTime.now());
      where = where + " AND fecha = '$fechaFormatted' ";
    }

    if (usuario != "" && usuario != null) {
      where = where + " AND nombreEmpleadoDms = '$usuario'";
    }

    String query = "";

    query = """
                      SELECT MAX(id) id,
                            MAX(anomes) anomes,
                            max(fecha) fecha,
                            codEmpleadoDms,
                            codigoCircuito,
                            anomesActBlncTmy,
                            qbrTmy,
                            anomesActBlncMbl,
                            qbrMbl,
                            fechaActualizacion,
                            nombreEmpleadoDms,
                            visitado,
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
                            longitude,
                            anomesAntVastrix,
                            anomesActVastrix,
                            vastrixMom ,
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
                            nombreEmpleadoDms,
                            visitado,
                            fechaVisita,
                            fechaFD11,
                            fd11, 
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
                            invBlsDisp,
                            invBlsDesc,
                            enListaBlanca,
                            invBlsHist,
                            grsBlsHist,
                            cnvBlsHist,
                            invBlsDispHist,
                            invBlsDescHist,
                            qbrBlsCantAsig,
                            qbrBlsCantAct,
                            qbrBls,
                            qbrBlsAcum,
                            qbrBlsDias,
                            qbrBlsEvalua,
                            invBlsFechaAct,
                            invBlsHistFechaAct
                      FROM planning a 
                      WHERE id>=0
                          $where
                      GROUP BY idDealer,
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
                            longitude,
                            anomesAntVastrix,
                            anomesActVastrix,
                            vastrixMom ,
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
                            fechaVisita,
                            fechaFD11,
                            fd11, 
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
                            invBlsDisp,
                            invBlsDesc,
                            enListaBlanca,
                            invBlsHist,
                            grsBlsHist,
                            cnvBlsHist,
                            invBlsDispHist,
                            invBlsDescHist,
                            qbrBlsCantAsig,
                            qbrBlsCantAct,
                            qbrBls,
                            qbrBlsAcum,
                            qbrBlsDias,
                            qbrBlsEvalua,
                            invBlsFechaAct,
                            invBlsHistFechaAct
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);
    return maps.map((json) {
      return Planning.fromJson(json);
    }).toList();
  }

  Future<List<Fordis11>> leerListadoFD11() async {
    String where = " AND a.fd11 != ''";

    String query = "";

    query = """
                      SELECT 
                            a.fechaFD11,
                            a.nombreCircuito,
                            a.idPdv,
                            a.nombrePdv,
                            a.fd11,
                            CASE
                              WHEN b.instanceId IS NOT NULL AND c.instanceId IS NOT NULL THEN 'SI'
                              ELSE 'NO'
                            END  contestado
                      FROM planning a                         
                        LEFT JOIN (
                          SELECT instanceId,
                                  response fd11
                          FROM formulario_answer
                          WHERE  formId = 31
                                and questionId = 346
                        ) b
                          ON a.fd11 = b.fd11                         
                        LEFT JOIN (
                          SELECT instanceId,
                                  response idPdv
                          FROM formulario_answer
                          WHERE  formId = 31
                                and questionId = 339
                        ) c
                          ON a.idPdv = c.idPdv
                      WHERE id>=0
                          $where
                          
                      GROUP BY  a.fechaFD11,
                            a.nombreCircuito,
                            a.idPdv,
                            a.nombrePdv,
                            a.fd11
                      ORDER BY a.fechaFD11
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((e) => Fordis11.fromJson(e)).toList();
  }

  Future<List<ReporteQuiebre>> leerListadoQuiebreMovil() async {
    String where = " AND a.qbrMbl LIKE 'SI%'";

    String query = "";

    query = """
                      SELECT 
                            a.fechaActualizacion,
                            a.idPdv,
                            a.nombrePdv,
                            a.qbrMbl quiebre,
                            a.anomesActBlncMbl saldo
                      FROM planning a
                      WHERE id>=0
                          $where                          
                      GROUP BY  a.fechaActualizacion,
                            a.idPdv,
                            a.nombrePdv,
                            a.qbrMbl,
                            a.anomesActBlncMbl
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((e) => ReporteQuiebre.fromJson(e)).toList();
  }

  Future<List<ReporteQuiebre>> leerListadoQuiebreTMY() async {
    String where = " AND a.qbrTmy LIKE 'SI%'";

    String query = "";

    query = """
                      SELECT 
                            a.fechaActualizacion,
                            a.idPdv,
                            a.nombrePdv,
                            a.qbrTmy quiebre,
                            a.anomesActBlncTmy saldo
                      FROM planning a
                      WHERE id>=0
                          $where                          
                      GROUP BY  a.fechaActualizacion,
                            a.idPdv,
                            a.nombrePdv,
                            a.qbrTmy,
                            a.anomesActBlncTmy
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((e) => ReporteQuiebre.fromJson(e)).toList();
  }

  Future<List<Solicitudes>> leerSolicitudes(String tipo, String usuario) async {
    String where = "";

    if (tipo == 'PROPIAS') {
      where = where + " AND usuario = '$usuario'";
    } else {
      where = where + " AND usuario != '$usuario'";
    }

    String query = """
                      SELECT 
                            *
                      FROM solicitud a
                      WHERE 1=1
                        $where
                      ORDER BY id DESC
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((e) => Solicitudes.fromMap(e)).toList();
  }

  Future<List<String>> leerUsersSolicitudes(String usuario, String tipo) async {
    String where = "";

    if (tipo == 'PROPIAS') return [];

    where + " AND usuario != '$usuario'";

    String query = """
                      SELECT 
                            usuario
                      FROM solicitud a
                      WHERE 1=1
                        $where
                      GROUP BY usuario
                      ORDER BY usuario
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps
        .map((e) => e['usuario'].toString().replaceAll('APP.DMS.', ''))
        .toList();
  }

  Future<List<Circuito>> leerPlanningCircuitos({DateTime? fecha}) async {
    await LocalDatabase.init();
    String where = "";
    String fechaFormatted = "SIN FORMATO";

    if (fecha != null) {
      fechaFormatted = DateFormat('dd-MM-yyyy').format(fecha);
      where = " AND fecha = '$fechaFormatted' ";
    }

    String query = """
                      SELECT fecha
                          ,codigoCircuito
                          ,nombreCircuito
                          ,COUNT(DISTINCT idPdv) cantidad
                          ,SUM(
                            CASE WHEN visitado == 'SI' THEN 1
                            ELSE 0
                            END
                          ) visitado
                    FROM planning
                    WHERE 1=1
                          $where
                    GROUP BY 
                          fecha
                          ,codigoCircuito
                          ,nombreCircuito
                  """;

    List<Map<String, dynamic>> maps = await LocalDatabase.customQuery(query);

    return maps.map((item) => Circuito.fromJson(item)).toList();
  }

  Future<List<Circuito>> leerPlanningSegmentado({DateTime? fecha}) async {
    await LocalDatabase.init();
    String where = "";
    String fechaFormatted = "SIN FORMATO";

    if (fecha != null) {
      fechaFormatted = DateFormat('dd-MM-yyyy').format(fecha);
      where = " AND fecha = '$fechaFormatted' ";
    }

    String query = """
                    SELECT fecha
                          ,codigoCircuito
                          ,nombreCircuito
                          ,segmentoPdv
                          ,COUNT(DISTINCT idPdv) cantidad
                          ,SUM(
                            CASE WHEN visitado == 'SI' THEN 1
                            ELSE 0
                            END
                          ) visitado
                    FROM planning
                    WHERE 1=1
                          $where
                    GROUP BY 
                          fecha
                          ,codigoCircuito
                          ,nombreCircuito
                          ,segmentoPdv
                  """;

    List<Map<String, dynamic>> maps = await LocalDatabase.customQuery(query);

    return maps.map((item) => Circuito.fromJson(item)).toList();
  }

  Future<List<Sucursal>> leerSucursales() async {
    await LocalDatabase.init();

    const query = """
                    SELECT idSucursal
                          ,nombreSucursal
                    FROM planning
                    GROUP BY 
                          idSucursal
                          ,nombreSucursal 
                  """;

    List<Map<String, dynamic>> maps = await LocalDatabase.customQuery(query);

    return maps.map((item) => Sucursal.fromJson(item)).toList();
  }

  Future<List<Dealer>> leerDealers() async {
    await LocalDatabase.init();

    const query = """
                    SELECT idDealer
                          ,nombreDealer
                    FROM planning
                    GROUP BY 
                          idDealer
                          ,nombreDealer
                  """;

    List<Map<String, dynamic>> maps = await LocalDatabase.customQuery(query);

    return maps.map((item) => Dealer.fromJson(item)).toList();
  }

  Future<List<Circuito>> leerCircuitos() async {
    await LocalDatabase.init();

    const query = """
                    SELECT fecha 
                          ,codigoCircuito
                          ,nombreCircuito
                          ,COUNT(1) cantidad
                    FROM planning
                    GROUP BY 
                          codigoCircuito
                          ,nombreCircuito
                          ,fecha
                  """;

    List<Map<String, dynamic>> maps = await LocalDatabase.customQuery(query);

    return maps.map((item) => Circuito.fromJson(item)).toList();
  }

  Future<List<Circuito>> leerCircuitosFilter({String? idSucursal}) async {
    await LocalDatabase.init();
    String where = "";

    if (idSucursal != null && idSucursal.isNotEmpty) {
      where = " AND idSucursal = $idSucursal";
    }
    String query = """
                    SELECT MAX(fecha) fecha 
                          ,codigoCircuito
                          ,nombreCircuito
                          ,COUNT(1) cantidad
                    FROM planning
                      WHERE id>0
                      $where
                    GROUP BY 
                          codigoCircuito
                          ,nombreCircuito
                  """;

    List<Map<String, dynamic>> maps = await LocalDatabase.customQuery(query);

    return maps.map((item) => Circuito.fromJson(item)).toList();
  }

  Future<Planning> leerPDV(String idPDV) async {
    await LocalDatabase.init();

    String query = """
                    SELECT *
                    FROM planning
                    WHERE idPdv = $idPDV 
                  """;

    List<Map<String, dynamic>> maps = await LocalDatabase.customQuery(query);
    return maps.map((item) => Planning.fromJson(item)).toList()[0];
  }

  Future<List<String>> leerSegmentos({
    String? idSucursal,
    String? nombreCircuito,
    String? segmento,
  }) async {
    await LocalDatabase.init();

    String where = "";

    if (idSucursal != null && idSucursal.isNotEmpty) {
      where = " AND idSucursal = $idSucursal";
    }

    if (segmento != null && segmento.isNotEmpty) {
      where = " AND segmentoPdv = '$segmento'";
    }

    if (nombreCircuito != null && nombreCircuito.isNotEmpty) {
      where = where + " AND nombreCircuito = '$nombreCircuito'";
    }

    String query = """
                    SELECT CASE 
                              WHEN segmentoPdv = 'N/A' THEN 'OTRO'
                              WHEN segmentoPdv = 'null' THEN 'OTRO'
                              WHEN segmentoPdv IS NULL THEN 'OTRO'
                              ELSE segmentoPdv
                           END segmentoPdv
                    FROM planning
                    WHERE id>=0
                        $where
                    GROUP BY 
                          CASE 
                              WHEN segmentoPdv = 'N/A' THEN 'OTRO'
                              WHEN segmentoPdv = 'null' THEN 'OTRO'
                              WHEN segmentoPdv IS NULL THEN 'OTRO'
                              ELSE segmentoPdv
                           END
                  """;

    List<Map<String, dynamic>> maps = await LocalDatabase.customQuery(query);

    return maps.fold<List<String>>(
        [],
        (previousValue, element) =>
            List.from(previousValue)..add(element['segmentoPdv']));
  }

  Future<List<String>> leerServicios({
    String? idSucursal,
    String? nombreCircuito,
    String? segmento,
    String? servicio,
  }) async {
    await LocalDatabase.init();

    String where = "";

    if (idSucursal != null && idSucursal.isNotEmpty) {
      where = " AND idSucursal = $idSucursal";
    }

    if (segmento != null && segmento.isNotEmpty) {
      where = " AND segmentoPdv = '$segmento'";
    }

    if (nombreCircuito != null && nombreCircuito.isNotEmpty) {
      where = where + " AND nombreCircuito = '$nombreCircuito'";
    }
    if (servicio != null && servicio.isNotEmpty) {
      where = where + " AND servicios LIKE '%${servicio.toUpperCase()}%'";
    }

    String query = """
                    SELECT servicios
                    FROM planning
                    WHERE id>=0
                        $where
                    GROUP BY 
                          servicios
                  """;

    List<Map<String, dynamic>> maps = await LocalDatabase.customQuery(query);

    final arreglo = maps.fold<List<String>>(
        [],
        (previousValue, element) =>
            List.from(previousValue)..add(element['servicios']));
    final String arregloUnificado = arreglo.join(",");

    return arregloUnificado.split(",").toSet().toList();
  }

  /*FIN DE EVENTOS PARA PLANNING */

  /*INICIO DE EVENTOS PARA FORMS */
  Future crearFormularios(List<Formulario> forms) async {
    await LocalDatabase.init();
    LocalDatabase.delete('formulario');
    for (var form in forms) {
      await LocalDatabase.insert('formulario', form);
    }
  }

  Future<int> insertarSolicitudAutomatica(SolicitudAutomatica dato) async {
    await LocalDatabase.init();
    return await LocalDatabase.insert('solicitud_automatica', dato);
  }

  Future<List<Formulario>> leerListadoForms() async {
    final List<Map<String, dynamic>> maps =
        await LocalDatabase.query(Formulario.table);
    return maps.map((json) => Formulario.fromMap(json)).toList();
  }

  Future<List<FormularioResumen>> leerResumenForms({
    String? tipo,
    String? formId,
    String? adicionalFilter = '',
    String? segmento = '',
  }) async {
    await LocalDatabase.init();

    String where = "";

    if (tipo != null && tipo.isNotEmpty) {
      where = " AND a.type = '$tipo' ";
    }

    if (formId != null && formId.isNotEmpty) {
      where = where + " AND a.formId = '$formId' ";
    }

    if (segmento != null && segmento.isNotEmpty) {
      where = where + " AND a.subType LIKE '%$segmento%' ";
    }

    final query = """
                    SELECT a.formId,
                           a.formName,
                           a.formDescription,
                           a.type,
                           a.subType,
                           b.lastDate
                    FROM formulario a
                        LEFT JOIN (
                            SELECT 
                                formId,
                                MAX(fechaCreacion) lastDate
                            FROM formulario_answer
                            $adicionalFilter
                            GROUP BY formId
                        ) b 
                          ON a.formId = b.formId
                    WHERE 1=1
                        $where                        
                    GROUP BY a.formId,
                             a.formName,
                             a.formDescription,
                             a.type,
                             a.subType,
                             b.lastDate
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => FormularioResumen.fromMap(json)).toList();
  }

  Future<List<FormularioAnswer>> leerListadoRespuestas() async {
    final List<Map<String, dynamic>> maps = await LocalDatabase.query(
      FormularioAnswer.table,
      find: "enviado = ?",
      findValue: "NO",
    );
    return maps.map((json) => FormularioAnswer.fromMap(json)).toList();
  }

  Future<List<Formulario>> leerFormulario({
    required String idForm,
  }) async {
    await LocalDatabase.init();

    String where = "";

    if (idForm.isNotEmpty) {
      where = " AND formId = $idForm";
    }

    final query = """
                    SELECT *
                    FROM formulario
                    WHERE 1=1
                        $where
                    ORDER BY questionOrder
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => Formulario.fromMap(json)).toList();
  }

  Future<List<ResumenAnswer>> leerRespuestasResumen(
      DateTime start, DateTime end) async {
    await LocalDatabase.init();

    String inicio = DateFormat('yyyyMMdd').format(start);
    String fin = DateFormat('yyyyMMdd').format(end);

    String where =
        " AND SUBSTR(a.fechaCreacion,0,9) BETWEEN '$inicio' AND '$fin' ";

    final query = """
                    SELECT a.instanceId,
                           a.formId,
                           a.fechaCreacion,
                           a.enviado,
                           b.formName,
                           b.formDescription
                    FROM formulario_answer a 
                        INNER JOIN formulario B 
                          ON a.formId = b.formId
                    WHERE 1=1
                        $where
                    GROUP BY 
                          a.instanceId,
                           a.formId,
                           a.fechaCreacion,
                           a.enviado,
                           b.formName,
                           b.formDescription
                    ORDER BY 
                           a.fechaCreacion DESC
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.isEmpty
        ? const []
        : maps.map((json) => ResumenAnswer.fromMap(json)).toList();
  }

  Future<List<DetalleAnswer>> leerRespuestasDetalle(
      {required String instanceId}) async {
    await LocalDatabase.init();

    String where = " AND a.instanceId = '$instanceId' ";

    final query = """
                    SELECT a.instanceId,
                           a.formId,
                           a.respondentId,
                           a.questionId,
                           a.formId,
                           a.response,
                           a.fechaCreacion,
                           a.enviado,
                           b.formName,
                           b.formDescription,
                           b.questionOrder,
                           b.questionType,
                           b.questionText
                    FROM formulario_answer a 
                        INNER JOIN formulario B 
                          ON a.formId = b.formId
                            AND a.questionId = b.questionId
                    WHERE 1=1
                        $where
                    ORDER BY 
                           b.questionOrder
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => DetalleAnswer.fromMap(json)).toList();
  }

  Future<List<DetalleAnswer>> leerSolicitudDetalle({
    required String formId,
    required String fecha,
  }) async {
    await LocalDatabase.init();

    String where = " AND a.formId = '$formId' AND a.fechaCreacion = '$fecha' ";

    final query = """
                    SELECT a.instanceId,
                           a.formId,
                           a.respondentId,
                           a.questionId,
                           a.formId,
                           a.response,
                           a.fechaCreacion,
                           a.enviado,
                           b.formName,
                           b.formDescription,
                           b.questionOrder,
                           b.questionType,
                           b.questionText
                    FROM formulario_answer a 
                        INNER JOIN formulario B 
                          ON a.formId = b.formId
                            AND a.questionId = b.questionId
                    WHERE 1=1
                        $where
                    ORDER BY 
                           b.questionOrder
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => DetalleAnswer.fromMap(json)).toList();
  }

  Future guardarRespuestaFormulario(List<FormularioAnswer> repuesta) async {
    await LocalDatabase.init();
    for (var resp in repuesta) {
      await LocalDatabase.insert('formulario_answer', resp);
    }
  }

  Future guardarVisita(Visita visita) async {
    await LocalDatabase.init();
    await LocalDatabase.insert('visita', visita);
  }

  Future<List<FormularioAnswer>> leerRespuestaFormulario(
      {required String instanceId}) async {
    await LocalDatabase.init();

    String where = " AND a.instanceId = '$instanceId' ";

    final query = """
                    SELECT a.*
                    FROM formulario_answer a 
                    WHERE 1=1
                        AND response IS NOT NULL
                        AND response != 'null'
                        AND response != ''
                        $where
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);
    //return maps.map((json) => FormularioAnswer.fromMap(json)).toList();
    return maps.map((json) {
      return FormularioAnswer.fromMap(json);
    }).toList();
  }

  Future<bool> deleteRespuestaForm(FormularioAnswer model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.deleteForm(FormularioAnswer.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> deleteRespuestasSincronizadas() async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.deleteRespSync(
      FormularioAnswer.table,
    );

    return resp > 0 ? true : false;
  }

  Future<bool> updateInformacionForm(FormularioAnswer model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.update(FormularioAnswer.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> updateEnviados(List<FormularioAnswer> models) async {
    await LocalDatabase.init();

    int resp = 0;
    for (var model in models) {
      resp = await LocalDatabase.update(
        FormularioAnswer.table,
        model.copyWith(enviado: 'SI'),
      );
    }

    return resp > 0 ? true : false;
  }

  /*FIN DE EVENTOS PARA FORMS*/

  /*INICIO DE EVENTOS PARA ACTUALIZACION DE TABLAS*/
  Future<List<Tabla>> leerListadoTablas() async {
    final List<Map<String, dynamic>> maps =
        await LocalDatabase.query(Tabla.table);
    return maps.map((json) => Tabla.fromMap(json)).toList();
  }

  Future<void> updateTabla({
    required String tbl,
  }) async {
    await LocalDatabase.init();

    String where = "";

    if (tbl.isNotEmpty) {
      where = " AND tabla = '$tbl'";
    }

    String update = DateTime.now().toIso8601String();

    String query = """
                    UPDATE tablas
                    SET fechaActualizacion = '$update'
                    WHERE 1=1
                      $where
                    """;

    await LocalDatabase.customQuery(query);
  }

  /*FIN DE EVENTOS PARA FORMS*/

  /*INICIO DE EVENTOS PARA TRACKING DE USUARIO */
  Future<bool> addTrackingHead(TrackingHead model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.insert(TrackingHead.table, model);

    return resp > 0 ? true : false;
  }

  Future<int> actualizarTrackingHead(TrackingHead head) async {
    await LocalDatabase.init();

    return LocalDatabase.update(TrackingHead.table, head);
  }

  Future<bool> addTrackingDet(TrackingDet model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.insert(TrackingDet.table, model);

    return resp > 0 ? true : false;
  }

  Future<List<Tracking>> leerTracking({
    required DateTime start,
    required DateTime end,
    required String idTracking,
  }) async {
    await LocalDatabase.init();

    String where =
        " AND b.fecha BETWEEN '${start.toIso8601String()}' AND '${end.toIso8601String()}' AND a.idTracking = '$idTracking' ";

    final query = """
                    SELECT a.idTracking,
                           a.usuario,
                           b.fecha,
                           b.latitude latitud,
                           b.longitude longitud,
                           a.fechaInicio,
                           a.fechaFin
                    FROM tracking_head a
                        INNER JOIN tracking_det b 
                          on a.idTracking = b.idTracking 
                    WHERE 1=1
                        $where
                    ORDER BY b.fecha
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => Tracking.fromJson(json)).toList();
  }

  Future<List<String>> leerTrackingResumen({
    required DateTime start,
    required DateTime end,
  }) async {
    await LocalDatabase.init();

    String where =
        " AND fecha BETWEEN '${start.toIso8601String()}' AND '${end.toIso8601String()}' ";

    final query = """
                    SELECT a.idTracking
                    FROM tracking_head a
                        INNER JOIN tracking_det b 
                          on a.idTracking = b.idTracking 
                    WHERE 1=1
                        $where
                    GROUP BY a.idTracking
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => json["idTracking"].toString()).toList();
  }

  Future<TrackingHead> getCurrentTrackingHed() async {
    await LocalDatabase.init();

    String where = " AND fechaFin is NULL ";

    final query = """
                    SELECT *
                    FROM tracking_head 
                    WHERE 1=1
                        $where
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => TrackingHead.fromJson(json)).toList().first;
  }

  Future<bool> updateTrackingHead(TrackingHead model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.update(TrackingHead.table, model);

    return resp > 0 ? true : false;
  }

  /*INICIO DE FUNCIONES PARA MODELOS*/
  Future guardarModelos(List<ModeloTangible> modelos) async {
    await LocalDatabase.init();
    LocalDatabase.delete('modelo');

    for (var modelo in modelos) {
      await LocalDatabase.insert('modelo', modelo);
    }
  }

  Future guardarModelosSaldos(List<ModeloTangible> modelos) async {
    await LocalDatabase.init();
    for (var modelo in modelos) {
      LocalDatabase.delete('modelo',
          where: 'modelo = ?', whereArgs: [modelo.modelo]);
      await LocalDatabase.insert('modelo', modelo);
    }
  }

  Future actualizarModelos(List<ModeloTangible> modelos) async {
    await LocalDatabase.init();

    for (var modelo in modelos) {
      await LocalDatabase.updateModelo('modelo', modelo);
    }
  }

  Future<void> limpiarSaldos() async {
    await LocalDatabase.init();

    await LocalDatabase.delete('modelo',
        where: 'tangible IN (\'EPIN\',\'TMY\')');
  }

  Future<List<ModeloTangible>> leerListadoModelos(
      [bool mostarTengible = true, String? idPdv]) async {
    await LocalDatabase.init();
    String where =
        " AND confirmado = 0 AND enviado = 0 and (idPdv = 0 or idPdv = $idPdv)"; //" AND a.instanceId = '$instanceId' ";
    final String query;
    //if (mostarTengible) {
      query = """
                    SELECT
                    *
                    FROM (SELECT a.id, 
                            a.tangible,
                            a.modelo,
                            a.descripcion,
                            a.imagen, 
                            SUM(b.asignado) asignado, 
                            COUNT(*) disponible,
                            MIN(b.serie) serieInicial,
                            MAX(b.serie) serieFinal
                    FROM modelo a 
                        INNER JOIN tangible b 
                          ON a.tangible = b.tangible
                            AND a.modelo = b.modelo
                    WHERE 1=1
                        $where
                    GROUP BY a.id, 
                            a.tangible,
                            a.modelo,
                            a.descripcion,
                            a.imagen, 
                            a.asignado, 
                            a.disponible
                    UNION ALL
                    SELECT -1 AS id, 'EPIN' AS tangible, 'EPIN' AS modelo, 'SALDO EPIN' AS descripcion, '' AS imagen, 0 AS asignado, 1 AS disponible, '0' AS serieInicial, '0' AS serieFinal
                    UNION ALL
                    SELECT -2 AS id, 'TMY' AS tangible, 'TMY' AS modelo, 'SALDO TIGO MONEY' AS descripcion, '' AS imagen, 0 AS asignado, 1 AS disponible, '0' AS serieInicial, '0' AS serieFinal
                    )
                    ORDER BY disponible DESC""";
    /*} else {
      query = """
                    SELECT
                    *
                    FROM (
                    SELECT a.id, 
                            a.tangible,
                            a.modelo,
                            a.descripcion,
                            a.imagen, 
                            SUM(b.asignado) asignado, 
                            COUNT(*) disponible,
                            MIN(b.serie) serieInicial,
                            MAX(b.serie) serieFinal
                    FROM modelo a 
                        INNER JOIN tangible b 
                          ON a.tangible = b.tangible
                            AND a.modelo = b.modelo
                    WHERE 1=1
                        $where
                        AND A.TANGIBLE IN ('SCRATCHCARD')
                    GROUP BY a.id, 
                            a.tangible,
                            a.modelo,
                            a.descripcion,
                            a.imagen, 
                            a.asignado, 
                            a.disponible
                    UNION ALL
                    SELECT -1 AS id, 'EPIN' AS tangible, 'EPIN' AS modelo, 'SALDO EPIN' AS descripcion, '' AS imagen, 0 AS asignado, 1 AS disponible, '0' AS serieInicial, '0' AS serieFinal
                    UNION ALL
                    SELECT -2 AS id, 'TMY' AS tangible, 'TMY' AS modelo, 'SALDO TIGO MONEY' AS descripcion, '' AS imagen, 0 AS asignado, 1 AS disponible, '0' AS serieInicial, '0' AS serieFinal
                    )
                    ORDER BY disponible DESC""";
    }*/

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);
    //return maps.map((json) => FormularioAnswer.fromMap(json)).toList();
    return maps.map((json) {
      return ModeloTangible.fromMap(json);
    }).toList();
  }

  Future<List<ModeloTangible>> leerListadoModelosReasignacion(int idPdv) async {
    await LocalDatabase.init();

    String where =
        "And b.idPdv = $idPdv and enviado = 0"; //" AND a.instanceId = '$instanceId' ";

    final query = """
                    SELECT a.id, 
                            a.tangible,
                            a.modelo,
                            a.descripcion,
                            a.imagen, 
                            SUM(b.asignado) asignado, 
                            SUM(b.descartado) descartado, 
                            COUNT(*) disponible,
                            MIN(b.serie) serieInicial,
                            MAX(b.serie) serieFinal
                    FROM modelo a
                    inner join tangible_reasignacion b
                    on a.tangible = b.tangible
                    and a.modelo = b.modelo
                    WHERE 1=1
                        $where
                    GROUP BY a.id, 
                            a.tangible,
                            a.modelo,
                            a.descripcion,
                            a.imagen, 
                            a.asignado
                    ORDER BY asignado DESC
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);
    //return maps.map((json) => FormularioAnswer.fromMap(json)).toList();
    return maps.map((json) {
      return ModeloTangible.fromMap(json);
    }).toList();
  }

  Future<int> confirmarTangiblesAsignadios({
    required int idPdv,
  }) async {
    await LocalDatabase.init();

    String where =
        " AND idPdv = $idPdv AND confirmado = 0 AND enviado = 0 AND asignado = 1"; //" AND a.instanceId = '$instanceId' ";

    final query = """
                    UPDATE tangible 
                      SET confirmado = 1
                    WHERE 1=1
                        $where
                    """;
    int resultado = 0;

    try {
      resultado = await LocalDatabase.customUpdate(query);
    } catch (e) {
      null;
    }
    //return maps.map((json) => FormularioAnswer.fromMap(json)).toList();
    return resultado;
  }

  Future<int> confirmarTangiblesReasignadios({
    required int idPdv,
  }) async {
    await LocalDatabase.init();

    String where =
        " AND idPdv = $idPdv AND confirmado = 0 AND enviado = 0 AND (asignado = 1 or descartado = 1)"; //" AND a.instanceId = '$instanceId' ";

    final query = """
                    UPDATE tangible_reasignacion
                      SET confirmado = 1
                    WHERE 1=1
                        $where
                    """;
    int resultado = 0;

    try {
      resultado = await LocalDatabase.customUpdate(query);
    } catch (e) {
      null;
    }
    //return maps.map((json) => FormularioAnswer.fromMap(json)).toList();
    return resultado;
  }

  Future<List<ModeloTangible>> leerListadoModelosAsignados(int? idPdv) async {
    await LocalDatabase.init();
    String where = "idPdv = $idPdv";

    //" AND a.instanceId = '$instanceId' ";
    final query = """
                  SELECT  
                    a.tangible, 
                    SUM(
                        CASE 
                            WHEN a.tangible IN ('EPIN', 'TMY') THEN a.asignado
                            ELSE IFNULL(b.asignado, 0)
                        END
                    ) AS asignado, 
                    COUNT(*) AS disponible,
                    MIN(b.serie) AS serieInicial,
                    MAX(b.serie) AS serieFinal
                FROM modelo a 
                LEFT JOIN (
                    SELECT * 
                    FROM tangible 
                    WHERE $where
                ) b 
                    ON a.tangible = b.tangible
                    AND a.modelo = b.modelo
                    AND b.asignado = 1
                    AND b.enviado = 0
                    AND b.confirmado = 0
                GROUP BY  
                    a.tangible
                HAVING SUM(
                    CASE 
                        WHEN a.tangible IN ('EPIN', 'TMY') THEN a.asignado
                        ELSE IFNULL(b.asignado, 0)
                    END
                ) > 0
                ORDER BY SUM(
                    CASE 
                        WHEN a.tangible IN ('EPIN', 'TMY') THEN a.asignado
                        ELSE b.asignado
                    END
                ) DESC;
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);
    //return maps.map((json) => FormularioAnswer.fromMap(json)).toList();
    return maps.map((json) {
      return ModeloTangible.fromMap(json);
    }).toList();
  }

  Future<List<ModeloTangible>> leerListadoModelosSaldo(int? idPdv) async {
    await LocalDatabase.init();
    String where = "";
    if (idPdv != null) {
      where = "AND idPdv = $idPdv";
    }

    //" AND a.instanceId = '$instanceId' ";
    final query = """
                    SELECT  
                            a.tangible, 
                            SUM(IFNULL(b.asignado,a.asignado)) asignado, 
                            COUNT(*) disponible,
                            MIN(b.serie) serieInicial,
                            MAX(b.serie) serieFinal
                    FROM modelo a 
                        LEFT JOIN (select * from tangible where 1=1 $where)  b 
                          ON a.tangible = b.tangible
                            AND a.modelo = b.modelo
                            AND b.asignado = 1
                            AND b.enviado = 0
                            AND b.confirmado = 0
                    WHERE A.MODELO IN ('EPIN', 'TMY')
                    GROUP BY  
                            a.tangible
                    HAVING SUM(IFNULL(b.asignado, a.asignado)) > 0
                    ORDER BY SUM(b.asignado) DESC
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);
    //return maps.map((json) => FormularioAnswer.fromMap(json)).toList();
    return maps.map((json) {
      return ModeloTangible.fromMap(json);
    }).toList();
  }

  Future<List<ModeloTangible>> leerListadoModelosReasignados() async {
    await LocalDatabase.init();

    String where = ""; //" AND a.instanceId = '$instanceId' ";

    final query = """
                    SELECT  
                            a.tangible, 
                            SUM(b.asignado) asignado, 
                            SUM(b.descartado) descartado, 
                            COUNT(*) disponible,
                            MIN(b.serie) serieInicial,
                            MAX(b.serie) serieFinal
                    FROM modelo a 
                        INNER JOIN tangible_reasignacion b 
                          ON a.tangible = b.tangible
                            AND a.modelo = b.modelo
                            AND (b.asignado = 1 or b.descartado = 1)
                            AND b.enviado = 0
                            AND b.confirmado = 0
                    WHERE 1=1
                        $where
                    GROUP BY  
                            a.tangible
                    ORDER BY SUM(b.asignado) DESC
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);
    //return maps.map((json) => FormularioAnswer.fromMap(json)).toList();
    return maps.map((json) {
      return ModeloTangible.fromMap(json);
    }).toList();
  }

  Future<List<SolicitudAutomatica>> leerListadoSolicitudes(
      String idPdv, String tipo) async {
    await LocalDatabase.init();

    String where = " AND idPdv = '" +
        idPdv +
        "' AND tipo = '" +
        tipo +
        "' "; //" AND a.instanceId = '$instanceId' ";

    final query = """
                    SELECT  
                            *
                    FROM solicitud_automatica a 
                    WHERE 1=1
                        $where
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) {
      return SolicitudAutomatica.fromMap(json);
    }).toList();
  }

  Future<int> leerTotalModelos(String? idPdv) async {
    await LocalDatabase.init();

    String where = "and idPdv = $idPdv"; //" AND a.instanceId = '$instanceId' ";

    final query = """
                    SELECT
                            SUM(b.asignado) asignado
                    FROM modelo a 
                        INNER JOIN tangible b 
                          ON a.tangible = b.tangible
                            AND a.modelo = b.modelo
                            AND b.enviado = 0
                            AND b.confirmado = 0
                    WHERE 1=1
                        $where
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);
    //return maps.map((json) => FormularioAnswer.fromMap(json)).toList();
    return maps[0]["asignado"] as int;
  }

  Future<int> leerTotalModelosReasignacion() async {
    await LocalDatabase.init();

    String where = ""; //" AND a.instanceId = '$instanceId' ";

    final query = """
                    SELECT
                            SUM(b.asignado)+SUM(b.descartado) asignado
                    FROM modelo a 
                        INNER JOIN tangible_reasignacion b 
                          ON a.tangible = b.tangible
                            AND a.modelo = b.modelo
                            AND b.enviado = 0
                            AND b.confirmado = 0
                    WHERE 1=1
                        $where
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);
    //return maps.map((json) => FormularioAnswer.fromMap(json)).toList();
    return maps[0]["asignado"] as int;
  }

  Future<List<String>> leerTiposDB() async {
    await LocalDatabase.init();


    const query = """
                    SELECT
                            tangible
                    FROM tangible a 
                    WHERE 1=1
                      AND asignado != 1
                    GROUP BY tangible
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    if (maps.isEmpty) {
      return [];
    } else {
      return maps.map((e) => e['tangible'].toString()).toList();
    }
  }

  Future<List<String>> leerTiposReasignacionDB() async {
    await LocalDatabase.init();

    const query = """
                    SELECT
                            tangible
                    FROM tangible_reasignacion a 
                    WHERE 1=1
                      AND asignado != 1
                    GROUP BY tangible
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    if (maps.isEmpty) {
      return [];
    } else {
      return maps.map((e) => e['tangible'].toString()).toList();
    }
  }

  Future<List<TipoTangibleInfo>> leerDescripcionModelos(
      {String? tangible}) async {
    await LocalDatabase.init();

    String where = ""; //" AND a.instanceId = '$instanceId' ";

    if (tangible != null && tangible.isNotEmpty) {
      where += " AND a.tangible = '$tangible'";
    }

    String query = """
                     SELECT
                       count(*) cantidad,
                      b.descripcion tipo
                    FROM tangible a
                        INNER JOIN modelo b
                            on a.modelo = b.modelo
                    WHERE a.asignado != 1
                      $where
                      GROUP BY b.descripcion

                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => TipoTangibleInfo.fromMap(json)).toList();
  }

  Future<List<TipoTangibleReasignacionInfo>> leerDescripcionModelosReasignacion(
      {String? tangible}) async {
    await LocalDatabase.init();

    String where = ""; //" AND a.instanceId = '$instanceId' ";

    if (tangible != null && tangible.isNotEmpty) {
      where += " AND a.tangible = '$tangible'";
    }

    String query = """
                     SELECT
                       count(*) cantidad,
                      b.descripcion tipo
                    FROM tangible_reasignacion a
                        INNER JOIN modelo b
                            on a.modelo = b.modelo
                    WHERE a.asignado != 1
                      $where
                      GROUP BY b.descripcion

                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps
        .map((json) => TipoTangibleReasignacionInfo.fromMap(json))
        .toList();
  }

  Future<List<ProductoTangible>> leerInventarioDB() async {
    await LocalDatabase.init();

    const query = """
                    SELECT
                      a.*,
                      b.descripcion descModelo
                    FROM tangible a
                        INNER JOIN modelo b
                            on a.modelo = b.modelo
                    WHERE a.asignado != 1

                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => ProductoTangible.fromMap(json)).toList();
  }

  Future<List<ProductoTangibleReasignacion>>
      leerInventarioReasignadoDB() async {
    await LocalDatabase.init();

    const query = """
                    SELECT
                      a.*,
                      b.descripcion descModelo
                    FROM tangible_reasignacion a
                        INNER JOIN modelo b
                            on a.modelo = b.modelo
                    WHERE a.asignado != 1

                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps
        .map((json) => ProductoTangibleReasignacion.fromMap(json))
        .toList();
  }
  /*FIN DE FUNCIONES PARA MODELOS*/

  /*INICIO DE FUNCIONES PARA TANGIBLES */
  Future guardarTangibles(List<ProductoTangible> tangibles) async {
    await LocalDatabase.init();
    LocalDatabase.delete('tangible');

    await LocalDatabase.insertListTangible(tangibles);
  }

  Future guardarTangiblesReasignado(
      List<ProductoTangibleReasignacion> tangibles) async {
    await LocalDatabase.init();
    LocalDatabase.delete('tangible_reasignacion');

    await LocalDatabase.insertListTangibleReasignacion(tangibles);
  }

  Future<int> updateTangible(ProductoTangible tangible) async {
    await LocalDatabase.init();

    return LocalDatabase.update(ProductoTangible.table, tangible);
  }

  Future<int> updateTangibleReasignacion(
      ProductoTangibleReasignacion tangible) async {
    await LocalDatabase.init();

    return LocalDatabase.update(ProductoTangibleReasignacion.table, tangible);
  }

  Future<int> updateTangibleEnviado(List<ProductoTangible> tangibles) async {
    await LocalDatabase.init();

    int resp = 0;

    for (var tangible in tangibles) {
      resp = await LocalDatabase.update(
        ProductoTangible.table,
        tangible.copyWith(enviado: 1),
      );
    }

    return resp;
  }

  Future<int> updateTangibleEnviadoReasignado(
      List<ProductoTangibleReasignacion> tangibles) async {
    await LocalDatabase.init();

    int resp = 0;

    for (var tangible in tangibles) {
      resp = await LocalDatabase.update(
          ProductoTangibleReasignacion.table, tangible.copyWith(enviado: 1));
    }

    return resp;
  }

  Future<int> updateSolicitudAutomatica(SolicitudAutomatica modelo) async {
    await LocalDatabase.init();

    return LocalDatabase.update(SolicitudAutomatica.table, modelo);
  }

  Future<int> updateModeloTangible(ModeloTangible modelo) async {
    await LocalDatabase.init();

    return LocalDatabase.update(ModeloTangible.table, modelo);
  }

  Future<List<ProductoTangible>> getTangible({
    String? serie,
    String? modelo,
    String? tangible,
    bool asignar = false,
  }) async {
    await LocalDatabase.init();

    String where = "";
    String order = " ORDER BY fechaAsignacion ASC, serie";
    if (serie != null && serie.isNotEmpty) {
      where += " AND serie = '$serie'";
    }

    if (tangible != null && tangible.isNotEmpty) {
      where += " AND tangible = '$tangible'";
    }

    if (modelo != null && modelo.isNotEmpty) {
      where += " AND modelo = '$modelo'";
    }

    if (asignar) {
      //where += " AND asignado = 0";
    } else {
      where += " AND asignado = 1 AND confirmado = 0 AND enviado = 0 ";
      order = " ORDER BY fechaAsignacion DESC, serie DESC";
    }

    final query = """
                  SELECT
                  *
                  FROM  
                    (SELECT *
                    FROM tangible 
                    WHERE 1=1
                        $where
                    )$order
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => ProductoTangible.fromMap(json)).toList();
  }

  Future<List<ProductoTangibleReasignacion>> getTangibleReasignacion({
    String? serie,
    String? modelo,
    String? tangible,
    bool asignar = false,
  }) async {
    await LocalDatabase.init();

    String where = "";
    String order = " ORDER BY fechaAsignacion ASC, serie";
    if (serie != null && serie.isNotEmpty) {
      where += " AND serie = '$serie'";
    }

    if (tangible != null && tangible.isNotEmpty) {
      where += " AND tangible = '$tangible'";
    }

    if (modelo != null && modelo.isNotEmpty) {
      where += " AND modelo = '$modelo'";
    }

    if (asignar) {
      //where += " AND asignado = 0";
    } else {
      where += " AND asignado = 1 AND confirmado = 0 AND enviado = 0 ";
      order = " ORDER BY fechaAsignacion DESC, serie DESC";
    }

    final query = """
                    SELECT *
                    FROM tangible_reasignacion  
                    WHERE 1=1
                        $where
                    $order
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);
    return maps
        .map((json) => ProductoTangibleReasignacion.fromMap(json))
        .toList();
  }

  Future<List<ProductoTangibleReasignacion>> getTangibleReasignacionDes({
    String? serie,
    String? modelo,
    String? tangible,
    bool asignar = false,
  }) async {
    await LocalDatabase.init();

    String where = "";
    String order = " ORDER BY fechaAsignacion ASC, serie";
    if (serie != null && serie.isNotEmpty) {
      where += " AND serie = '$serie'";
    }

    if (tangible != null && tangible.isNotEmpty) {
      where += " AND tangible = '$tangible'";
    }

    if (modelo != null && modelo.isNotEmpty) {
      where += " AND modelo = '$modelo'";
    }

    if (asignar) {
      //where += " AND asignado = 0";
    } else {
      where += " AND descartado = 1 AND confirmado = 0 AND enviado = 0 ";
      order = " ORDER BY fechaAsignacion DESC, serie DESC";
    }

    final query = """
                    SELECT *
                    FROM tangible_reasignacion  
                    WHERE 1=1
                        $where
                    $order
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);
    return maps
        .map((json) => ProductoTangibleReasignacion.fromMap(json))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getPendienteConfirmar(
      {required String idPdv}) async {
    await LocalDatabase.init();

    final query = """
                    SELECT idPdv
                          ,COUNT(1) cantidad
                    FROM tangible 
                    WHERE 1=1
                          AND asignado = 1
                          AND confirmado = 0
                          AND enviado = 0
                          AND idPdv != $idPdv
                    GROUP BY idPdv
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps;
  }

  Future<List<ProductoTangible>> getTangibleConfirmado() async {
    await LocalDatabase.init();

    String where = " AND confirmado = 1 AND enviado = 0 ";
    String order = " ORDER BY fechaVenta ";

    final query = """
                    SELECT *
                    FROM tangible 
                    WHERE 1=1
                        $where
                    $order
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => ProductoTangible.fromMap(json)).toList();
  }

  Future<List<ProductoTangibleReasignacion>> getTangibleConfirmadoReasignacion(
      int idPdv) async {
    await LocalDatabase.init();

    String where = " AND idPdv = $idPdv";
    String order = " ORDER BY fechaVenta ";

    final query = """
                    SELECT *
                    FROM tangible_reasignacion 
                    WHERE 1=1
                        $where
                    $order
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps
        .map((json) => ProductoTangibleReasignacion.fromMap(json))
        .toList();
  }

  Future<List<ProductoTangibleReasignacion>> getTangibleReasingacion(
      int idPdv) async {
    await LocalDatabase.init();

    String where = "and idPdv = $idPdv";
    String order = " ORDER BY fechaVenta ";

    final query = """
                    SELECT *
                    FROM tangible_reasignacion  
                    WHERE 1=1
                        $where
                    $order
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps
        .map((json) => ProductoTangibleReasignacion.fromMap(json))
        .toList();
  }

  Future<List<ProductoTangible>> getTangibleModelo({
    required ModeloTangible modelo,
    String? idPdv
  }) async {
    await LocalDatabase.init();

    String where = """ AND tangible = '${modelo.tangible}' 
                       AND modelo = '${modelo.modelo}'
                       AND enviado = 0
                    """;

    if (idPdv !="") {
      where += """ 
          AND (idPdv = $idPdv OR idPdv = 0)
      """;
    }

    String order = " ORDER BY fechaAsignacion ASC, serie, asignado DESC";

    final query = """
                    SELECT *
                    FROM tangible 
                    WHERE 1=1
                        $where
                    $order
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => ProductoTangible.fromMap(json)).toList();
  }

  Future<List<ProductoTangibleReasignacion>> getTangibleModeloReasignacion({
    required ModeloTangible modelo,
    required int idPdv,
  }) async {
    await LocalDatabase.init();

    String where = """ AND tangible = '${modelo.tangible}' 
                       AND modelo = '${modelo.modelo}'
                       AND enviado = 0
                       AND idPdv = $idPdv
                    """;
    String order = " ORDER BY fechaAsignacion ASC, serie, asignado DESC";

    final query = """
                    SELECT *
                    FROM tangible_reasignacion
                    WHERE 1=1
                        $where
                    $order
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps
        .map((json) => ProductoTangibleReasignacion.fromMap(json))
        .toList();
  }

  Future<List<ProductoTangible>> getAllTangible() async {
    await LocalDatabase.init();

    String where = """ 
                      AND asignado = 1
                    """;
    String order = " ORDER BY fechaAsignacion DESC, serie";

    final query = """
                    SELECT *
                    FROM tangible 
                    WHERE 1=1
                        $where
                    $order
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => ProductoTangible.fromMap(json)).toList();
  }

  /*FIN DE FUNCIONES PARA TANGIBLES*/

  /*FUNCIONES PARA SINCONRIZAR */

  Future<List<ResumenSincronizar>> getSincronizarResumen(
    DateTime start,
    DateTime end,
  ) async {
    await LocalDatabase.init();

    String inicio = DateFormat('yyyyMMdd').format(start);
    String fin = DateFormat('yyyyMMdd').format(end);

    String where =
        " AND SUBSTR(a.fechaInicioVisita,0,9) BETWEEN '$inicio' AND '$fin' ";

    String where3 = " AND SUBSTR(a.fecha,0,9) BETWEEN '$inicio' AND '$fin' ";

    String where2 =
        " AND SUBSTR(a.fechaCreacion,0,9) BETWEEN '$inicio' AND '$fin' ";

    String order = " ORDER BY fecha DESC";

    final query = """
                    SELECT *
                    FROM (
                      SELECT 
                            a.fechaInicioVisita fecha,
                            'VISITA' tipo,
                            (b.enviado/b.total)*100 porcentajeSync,
                            a.idPDV idPdv,
                            a.idVisita
                      FROM visita a
                            INNER JOIN (
                              SELECT idVisita
                                    ,SUM(enviado) enviado
                                    ,count(*) total
                              FROM tangible b
                              WHERE confirmado = 1
                              GROUP BY idVisita
                            ) b 
                          ON a.idVisita = b.idVisita
                      WHERE 1=1
                          $where
                      UNION ALL
                      SELECT 
                            a.fecha,
                            a.tipo,
                            a.enviado*100 porcentajeSync,
                            a.idPDV idPdv,
                            a.id
                      FROM solicitud_automatica a
                      WHERE 1=1
                          $where3
                      UNION ALL
                      SELECT 
                          fecha,
                          tipo,
                          (enviado/total)*100 porcentajeSync,
                          idPdv,
                          idVisita
                      FROM (
                          SELECT 
                            a.fechaCreacion fecha,
                            b.formName tipo,
                            COUNT(1) TOTAL,
                            SUM(
                              CASE 
                                WHEN a.enviado == 'SI' THEN 1
                                ELSE 0
                              END
                            ) enviado,
                            MAX(
                            CASE 
                                WHEN b.shortText = 'idPdv' THEN CAST(a.response AS UNSIGNED)
                                ELSE 0
                            END
                            ) idPdv,
                            a.instanceId idVisita
                        FROM formulario_answer a
                          INNER JOIN formulario b 
                            ON a.questionId = b.questionId
                        WHERE 1=1
                            $where2
                        GROUP BY a.fechaCreacion,
                                  b.formName,
                                  A.instanceId
                      )

                    )                    
                    $order
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) {
      return ResumenSincronizar.fromJson(json);
    }).toList();
  }

  Future<List<ProductoTangible>> getDetalleVisita({
    required String idVisita,
  }) async {
    await LocalDatabase.init();

    String where = " AND idVisita = '$idVisita'";

    String order = " ORDER BY fechaVenta ASC";

    final query = """
                    SELECT 
                          a.*,
                          b.descripcion descModelo
                    FROM tangible a
                        INNER JOIN modelo b
                            on a.modelo = b.modelo
                    WHERE 1=1
                        $where
                    $order
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => ProductoTangible.fromMap(json)).toList();
  }

  /*TRACKING DE RED*/
  Future<bool> addInformacion(NetworkInfo model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.insert(NetworkInfo.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> deleteInformacion(NetworkInfo model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.deleteCaptura(NetworkInfo.table, model);

    return resp > 0 ? true : false;
  }

  Future<List<ManualNetworkInfo>> getInformacionManual() async {
    await LocalDatabase.init();

    List<Map<String, dynamic>> manualNetworkInfo =
        await LocalDatabase.query(ManualNetworkInfo.table);
    return manualNetworkInfo
        .map((item) => ManualNetworkInfo.fromMap(item))
        .toList();
  }

  Future<List<NetworkInfo>> getInformacion() async {
    await LocalDatabase.init();

    List<Map<String, dynamic>> networkInfo =
        await LocalDatabase.queryReporteSignal(NetworkInfo.table);
    return networkInfo.map((item) => NetworkInfo.fromMap(item)).toList();
  }

  Future<List<NetworkInfo>> getInformacionPorLectura(String idLectura) async {
    await LocalDatabase.init();
    final query = """
                    SELECT *
                    FROM networkinfo
                    WHERE idLectura = '$idLectura' 
                  """;

    List<Map<String, dynamic>> networkInfo =
        await LocalDatabase.customQuery(query);
    return networkInfo.map((item) => NetworkInfo.fromMap(item)).toList();
  }

  Future<List<int>> getInformacionDia() async {
    await LocalDatabase.init();

    String hoy = DateFormat.yMd().format(DateTime.now());

    final query = """
                    SELECT COUNT(*) cantidad
                    FROM networkinfo
                    WHERE background = 'SI' 
                        AND fechaCorta = '$hoy'               
                    UNION ALL
                    SELECT COUNT(*) cantidad
                    FROM networkinfo
                    WHERE background = 'NO'
                        AND fechaCorta = '$hoy'
                  """;

    List<Map<String, dynamic>> networkInfo =
        await LocalDatabase.customQuery(query);
    return networkInfo
        .map((item) => int.parse(item.entries.first.value.toString()))
        .toList();
  }

  Future<List<int>> getInformacionMes() async {
    await LocalDatabase.init();
    const query = """
                    SELECT COUNT(*) cantidad
                    FROM networkinfo
                    WHERE background = 'SI'
                    UNION ALL
                    SELECT COUNT(*) cantidad
                    FROM networkinfo
                    WHERE background = 'NO'
                  """;

    List<Map<String, dynamic>> networkInfo =
        await LocalDatabase.customQuery(query);
    return networkInfo
        .map((item) => int.parse(item.entries.first.value.toString()))
        .toList();
  }

  Future<List<int>> getInformacionSinSincronizar() async {
    await LocalDatabase.init();
    const query = """
                    SELECT COUNT(*) cantidad
                    FROM networkinfo
                    WHERE background = 'SI'
                          AND enviado = 'NO'
                    UNION ALL
                    SELECT COUNT(*) cantidad
                    FROM networkinfo
                    WHERE background = 'NO'
                          AND enviado = 'NO'
                  """;

    List<Map<String, dynamic>> networkInfo =
        await LocalDatabase.customQuery(query);
    return networkInfo
        .map((item) => int.parse(item.entries.first.value.toString()))
        .toList();
  }

  Future<bool> updateInformacion(NetworkInfo model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.update(NetworkInfo.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> addInformacionManual(ManualNetworkInfo model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.insert(ManualNetworkInfo.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> updateInformacionManual(ManualNetworkInfo model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.update(ManualNetworkInfo.table, model);

    return resp > 0 ? true : false;
  }

  Future<List<SolicitudAutomatica>> leerSolicitudesAutomaticas() async {
    await LocalDatabase.init();
    List<SolicitudAutomatica> solicitudes = const [];

    String where = " AND enviado = 0 ";

    final query = """
                    SELECT *
                    FROM solicitud_automatica 
                    WHERE 1=1
                        $where
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    try {
      solicitudes =
          maps.map((json) => SolicitudAutomatica.fromMap(json)).toList();
    } catch (e) {
      null;
    }

    return solicitudes;
  }

  /*FIN TRACKING DE RED*/

  /*INICIO DE FUNCIONES PARA INCENTIVOS */
  Future<List<IncentivoPdv>> leerIncentivosPorPdv(String idPdv) async {
    await LocalDatabase.init();

    String where = " AND idPdv = '$idPdv' ";

    final query = """
                    SELECT *
                    FROM incentivo 
                    WHERE 1=1
                        $where
                    """;

    final List<Map<String, dynamic>> maps =
        await LocalDatabase.customQuery(query);

    return maps.map((json) => IncentivoPdv.fromMap(json)).toList();
  }

  /*INICIO DE FUNCIONES PARA INDICADORES*/
  Future<List<IndicadoresVendedor>> leerIndicadoresPorVendedor() async {
    await LocalDatabase.init();

    String where = " ";

    final query = """
                    SELECT *
                    FROM indicadores 
                    WHERE 1=1
                        $where
                    """;

    final List<Map<String, dynamic>> maps =
    await LocalDatabase.customQuery(query);

    return maps.map((json) => IndicadoresVendedor.fromMap(json)).toList();
  }

  Future<List<ResumenModelo>> leerResumenPorModelo({
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    await LocalDatabase.init(); // asume getter que abre tu base
    // Formatear fechas a yyyy-MM-dd
    final String? desde = fechaInicio != null
        ? DateFormat('yyyy-MM-dd').format(fechaInicio)
        : null;
    final String? hasta = fechaFin != null
        ? DateFormat('yyyy-MM-dd').format(fechaFin)
        : null;

    // Construir cláusula WHERE dinámica
    String whereClause = 'and a.asignado = 1';
    if (desde != null && hasta != null) {
      whereClause += ' AND date(fechaAsignacion) BETWEEN ? AND ?';
    }


    final query = """
                    SELECT b.descripcion modelo, 
                            count(*) total,
                            a.precio
                    FROM tangible a
                     INNER JOIN modelo b
                            on a.modelo = b.modelo
                    WHERE 1=1
                        $whereClause
                    group by b.descripcion, a.precio
                    """;
    final List<Map<String, dynamic>> maps = await LocalDatabase.customQuery(query);
    return maps.map((m) => ResumenModelo.fromMap(m)).toList();
  }

  Future<void> marcarPendientePorPdvYVisita({
    required int idPdv,
    required String idVisita,
  }) async {
    await LocalDatabase.init();
    final query = """
    UPDATE tangible 
      SET pendiente = 1
    WHERE idPdv = $idPdv
      AND idVisita = '$idVisita'
      AND asignado = 1
      AND confirmado = 0
      AND enviado = 0
  """;
    await LocalDatabase.customUpdate(query);
  }

  Future< List<SaldoReporte>> leerReporteSaldo({
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    await LocalDatabase.init(); // asume getter que abre tu base
    // Formatear fechas a yyyy-MM-dd
    final String? desde = fechaInicio != null
        ? DateFormat('yyyy-MM-dd').format(fechaInicio)
        : null;
    final String? hasta = fechaFin != null
        ? DateFormat('yyyy-MM-dd').format(fechaFin)
        : null;

    // Construir cláusula WHERE dinámica
    String whereClause = '';
    if (desde != null && hasta != null) {
      whereClause += """ AND date(fechaHoraTfr) BETWEEN '$desde' AND '$hasta' """;
    }


    final query = """
                    SELECT 
                           fechaHoraTfr, 
                           idPdv||' - '||nombrePdv nombrePdv,
                           toMovil,
                           montoTfr,
                           saldoPdv,
                           saldoVendedor
                    FROM saldo
                    WHERE 1=1
                        $whereClause
                    order by fechaHoraTfr desc
                    """;
    final List<Map<String, dynamic>> maps = await LocalDatabase.customQuery(query);
    return maps.map((m) => SaldoReporte.fromMap(m)).toList();
  }


}