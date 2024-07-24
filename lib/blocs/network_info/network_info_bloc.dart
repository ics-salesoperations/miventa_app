import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cell_info/CellResponse.dart';
import 'package:cell_info/cell_info.dart';
import 'package:cell_info/models/common/cell_type.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:miventa_app/global/environment.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

part 'network_info_event.dart';
part 'network_info_state.dart';

class NetworkInfoBloc extends Bloc<NetworkInfoEvent, NetworkInfoState> {
  DBService db = DBService();
  StreamSubscription? gpsServiceSubscription;
  // Lifted from Default carrier configs and max range of RSRP
  final List rsrpThresholds = [
    -115, // SIGNAL_STRENGTH_POOR
    -105, // SIGNAL_STRENGTH_MODERATE
    -95, // SIGNAL_STRENGTH_GOOD
    -85, // SIGNAL_STRENGTH_GREAT
  ];
  // Lifted from Default carrier configs and max range of RSRQ
  final List rsrqThresholds = [
    -19,
    /* SIGNAL_STRENGTH_POOR */
    -17,
    /* SIGNAL_STRENGTH_MODERATE */
    -14,
    /* SIGNAL_STRENGTH_GOOD */
    -12, /* SIGNAL_STRENGTH_GREAT */
  ];
  // Lifted from Default carrier configs and max range of RSSNR
  final List rssiThresholds = [
    -3,
    /* SIGNAL_STRENGTH_POOR */
    1,
    /* SIGNAL_STRENGTH_MODERATE */
    5,
    /* SIGNAL_STRENGTH_GOOD */
    13, /* SIGNAL_STRENGTH_GREAT */
  ];

  NetworkInfoBloc()
      : super(const NetworkInfoState(
          actualizado: false,
          activado: false,
          guardando: false,
          enviando: false,
        )) {
    on<ActualizarNuevaInfoEvent>((event, emit) {
      return emit(
        state.copyWith(
          actualizado: event.actualizado,
          info: event.info,
        ),
      );
    });
    on<ToogleActivadoEvent>((event, emit) {
      return emit(
        state.copyWith(
          activado: event.activado,
        ),
      );
    });
    on<OnGuardandoEvent>((event, emit) {
      return emit(
        state.copyWith(
          guardando: event.guardando,
          mensaje: event.mensaje,
        ),
      );
    });
    on<OnEnviandoEvent>((event, emit) {
      return emit(
        state.copyWith(
          enviando: event.enviando,
          mensaje: event.mensaje,
        ),
      );
    });
  }

  Future<void> init({required bool esBackground}) async {
    final info = await actualizarDatos(esBackground: esBackground);
    await enviarDatos();
    await enviarDatosManuales();
    add(ActualizarNuevaInfoEvent(info: info, actualizado: true));

    final activado = await verificarActivado();
    add(ToogleActivadoEvent(
      activado: activado,
    ));
  }

  Future<bool> verificarActivado() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? actual = prefs.getBool('activadoMiVenta');
    if (actual == null) {
      return false;
    } else {
      return actual;
    }
  }

  Future<void> toogleActivado() async {
    final prefs = await SharedPreferences.getInstance();
    bool estadoFinal;
    final bool? actual = prefs.getBool('activadoMiVenta');
    if (actual == null) {
      await prefs.setBool('activadoMiVenta', true);
      estadoFinal = true;
    } else {
      await prefs.setBool('activadoMiVenta', !actual);
      estadoFinal = !actual;
    }

    add(ToogleActivadoEvent(
      activado: estadoFinal,
    ));
  }

  Future<NetworkInfo> actualizarDatos({required bool esBackground}) async {
    final telephony = Telephony.instance;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    DataState networkState = await telephony.cellularDataState;
    String strnetworkState = networkState.name;
    String? operatorName = await telephony.simOperatorName;
    var networkType = await telephony.dataNetworkType;
    //PhoneType phoneType = await telephony.phoneType;
    bool? isNetworkRoaming = await telephony.isNetworkRoaming;

    String nivelSenal = "";

    try {
      List<SignalStrength> signalLevel = await telephony.signalStrengths;
      nivelSenal = signalLevel[0].name;
    } catch (e) {
      nivelSenal = "No Soportado";
    }

    String datosHabilitados = await _checkDataStatus();
    String localizacionHabilitada = await _checkGpsStatus();
    final signal = await _getSignal();

    LatLng coordenadas = await _getLocation();

    final androidInfo = await deviceInfoPlugin.androidInfo;

    final fechaCaptura = DateTime.now();
    final UsuarioService userService = UsuarioService();
    final Usuario usuario = await userService.getInfoUsuario();
    final String telefono = usuario.telefono.toString();
    final String userId = usuario.usuario.toString();

    final idCaptura =
        "$telefono|${fechaCaptura.year}${fechaCaptura.month}${fechaCaptura.day}${fechaCaptura.hour}${fechaCaptura.minute}${fechaCaptura.second}${fechaCaptura.microsecond}";

    NetworkInfo info = NetworkInfo(
      idLectura: idCaptura,
      telefono: telefono,
      marca: androidInfo.manufacturer,
      modelo: androidInfo.model,
      datos: datosHabilitados.toString(),
      localizacion: localizacionHabilitada,
      tipoRed: networkType.name,
      estadoRed: strnetworkState,
      fecha: fechaCaptura,
      esRoaming: isNetworkRoaming! ? 'SI' : 'NO',
      tipoTelefono: userId,
      nivelSignal: nivelSenal,
      longitud: coordenadas.longitude.toString(),
      latitud: coordenadas.latitude.toString(),
      dB: signal.dbm,
      rsrp: signal.rsrp,
      rsrq: signal.rsrq,
      rssi: signal.rssi,
      enviado: 'NO',
      rsrpAsu: signal.rsrpAsu,
      rssiAsu: signal.rssiAsu,
      cqi: signal.cqi,
      snr: signal.snr,
      cid: signal.cid,
      eci: signal.eci,
      enb: signal.enb,
      networkIso: signal.networkIso,
      networkMcc: signal.networkMcc,
      networkMnc: signal.networkMnc,
      pci: signal.pci,
      operatorName: operatorName.toString(),
      background: esBackground ? "SI" : "NO",
    );

    await db.addInformacion(info);

    return info;
  }

  Future<String> _checkDataStatus() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.mobile) {
        return "Mobile";
      }

      if (connectivityResult == ConnectivityResult.wifi) {
        return "Wifi";
      }
    } catch (e) {
      return "No Identificado";
    }

    return "No Habilitado";
  }

  Future<LatLng> _getLocation() async {
    LatLng localizacion;
    try {
      Position position = await Geolocator.getCurrentPosition();
      localizacion = LatLng(position.latitude, position.longitude);
    } catch (e) {
      localizacion = const LatLng(0, 0);
    }

    return localizacion;
  }

  Future<String> _checkGpsStatus() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();

    if (isEnabled) {
      return 'Habilitado';
    }

    if (!isEnabled) {
      return 'Deshabilitado';
    }

    return 'Error';
  }

  Future<CeldaInfo> _getSignal() async {
    CellsResponse cellsResponse;
    CeldaInfo celda = CeldaInfo();
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String? platformVersion = await CellInfo.getCellInfo;
      final body = json.decode(platformVersion ?? "");

      cellsResponse = CellsResponse.fromJson(body);

      //Validamos que se pueda leer al menos una SIMCARD
      if (cellsResponse.primaryCellList!.isNotEmpty) {
        CellType currentCellInFirstChip = cellsResponse.primaryCellList![0];
        if (currentCellInFirstChip.type == "LTE") {
          //4G
          celda = CeldaInfo(
            tipo: currentCellInFirstChip.type,
            dbm: currentCellInFirstChip.lte!.signalLTE!.dbm.toString(),
            rsrp: currentCellInFirstChip.lte!.signalLTE!.rsrp.toString(),
            rsrq: currentCellInFirstChip.lte!.signalLTE!.rsrq.toString(),
            rssi: currentCellInFirstChip.lte!.signalLTE!.rssi.toString(),
            rsrpAsu: currentCellInFirstChip.lte!.signalLTE!.rsrpAsu.toString(),
            rssiAsu: currentCellInFirstChip.lte!.signalLTE!.rssiAsu.toString(),
            cqi: currentCellInFirstChip.lte!.signalLTE!.cqi.toString(),
            snr: currentCellInFirstChip.lte!.signalLTE!.snr.toString(),
            cid: currentCellInFirstChip.lte!.cid!.toString(),
            eci: currentCellInFirstChip.lte!.eci!.toString(),
            enb: currentCellInFirstChip.lte!.enb!.toString(),
            networkIso: currentCellInFirstChip.lte!.network!.iso.toString(),
            networkMcc: currentCellInFirstChip.lte!.network!.mcc.toString(),
            networkMnc: currentCellInFirstChip.lte!.network!.mnc.toString(),
            pci: currentCellInFirstChip.lte!.pci!.toString(),
          );
        } else if (currentCellInFirstChip.type == "NR") {
          //5G
          celda = CeldaInfo(
            tipo: currentCellInFirstChip.type,
            dbm: currentCellInFirstChip.nr!.signalNR!.dbm.toString(),
            rsrp: currentCellInFirstChip.nr!.signalNR!.ssRsrp.toString(),
            rsrq: currentCellInFirstChip.nr!.signalNR!.ssRsrq.toString(),
            rsrpAsu: currentCellInFirstChip.nr!.signalNR!.ssRsrpAsu.toString(),
            networkIso: currentCellInFirstChip.nr!.network!.iso.toString(),
            networkMcc: currentCellInFirstChip.nr!.network!.mcc.toString(),
            networkMnc: currentCellInFirstChip.nr!.network!.mnc.toString(),
            pci: currentCellInFirstChip.nr!.pci!.toString(),
          );
        } else if (currentCellInFirstChip.type == "WCDMA") {
          celda = CeldaInfo(
            tipo: currentCellInFirstChip.type,
            dbm: currentCellInFirstChip.wcdma!.signalWCDMA!.dbm.toString(),
            cgi: currentCellInFirstChip.wcdma!.cgi,
            networkIso: currentCellInFirstChip.wcdma!.network!.iso.toString(),
            networkMcc: currentCellInFirstChip.wcdma!.network!.mcc.toString(),
            networkMnc: currentCellInFirstChip.wcdma!.network!.mnc.toString(),
            ci: currentCellInFirstChip.wcdma!.ci.toString(),
            lac: currentCellInFirstChip.wcdma!.lac.toString(),
            psc: currentCellInFirstChip.wcdma!.psc.toString(),
            rnc: currentCellInFirstChip.wcdma!.rnc.toString(),
            cid: currentCellInFirstChip.wcdma!.cid.toString(),
          );
        } else if (currentCellInFirstChip.type == "GSM") {
          //2g
          celda = CeldaInfo(
            tipo: currentCellInFirstChip.type,
            dbm: currentCellInFirstChip.gsm!.signalGSM!.dbm.toString(),
            /*cgi: currentCellInFirstChip.wcdma!.cgi == null
                ? ""
                : currentCellInFirstChip.wcdma!.cgi,
            network_iso: currentCellInFirstChip.wcdma!.network!.iso.toString(),
            network_mcc: currentCellInFirstChip.wcdma!.network!.mcc.toString(),
            network_mnc: currentCellInFirstChip.wcdma!.network!.mnc.toString(),
            ci: currentCellInFirstChip.wcdma!.ci!.toString(),
            lac: currentCellInFirstChip.wcdma!.lac!.toString(),
            psc: currentCellInFirstChip.wcdma!.psc!.toString(),
            rnc: currentCellInFirstChip.wcdma!.rnc!.toString(),
            cid: currentCellInFirstChip.wcdma!.cid!.toString(),*/
          );
        }
      }
    } on PlatformException {
      //cellsResponse = null;
    }

    return celda;
  }

  Future<void> enviarDatos() async {
    DBService db = DBService();

    final infoList = await db.getInformacion();

    final now = DateTime.now();
    for (var info in infoList) {
      if (info.fecha!.isBefore(now.subtract(const Duration(days: 31))) &&
          info.enviado!.toUpperCase() == 'SI') {
        db.deleteInformacion(info);
      } else if (info.enviado!.toUpperCase() == 'NO') {
        try {
          final data = {
            'brand': info.marca.toString(),
            'model': info.modelo.toString(),
            'capture_id': info.idLectura.toString(),
            'phone_number': int.parse(info.telefono.toString()),
            'mobile_data': info.datos.toString(),
            'location': info.localizacion.toString(),
            'latitude': double.parse(info.latitud.toString()),
            'longitude': double.parse(info.longitud.toString()),
            'network_status': info.estadoRed.toString(),
            'network_type': info.tipoRed.toString(),
            'smarthpone_type': info.tipoTelefono.toString(),
            'is_roaming': info.esRoaming.toString(),
            'signal_level': info.nivelSignal.toString(),
            'db': int.parse(info.dB == 'null' ? '0' : info.dB!),
            'date': info.fecha!.toIso8601String(),
            'rsrp': int.parse(info.rsrp == 'null' ? '0' : info.rsrp!),
            'rsrq': int.parse(info.rsrq == 'null' ? '0' : info.rsrq!),
            'rssi': int.parse(info.rssi == 'null' ? '0' : info.rssi!),
            'rssi_asu': int.parse(info.rssiAsu == 'null' ? '0' : info.rssiAsu!),
            'rsrp_asu': int.parse(info.rsrpAsu == 'null' ? '0' : info.rsrpAsu!),
            'cqi': info.cqi ?? '0',
            'snr': int.parse(info.snr == 'null' ? '0' : info.snr!),
            'cid': info.cid ?? 'Unknown',
            'eci': info.eci ?? 'Unknown',
            'enb': info.enb ?? 'Unknown',
            'network_iso': info.networkIso ?? 'Unknown',
            'network_mcc': info.networkMcc ?? 'Unknown',
            'network_mnc': info.networkMnc ?? 'Unknown',
            'pci': info.pci == 'null' ? 'Unknown' : info.pci!,
            'cgi': info.cgi == 'null' ? 'Unknown' : info.cgi!,
            'ci': info.ci == 'null' ? 'Unknown' : info.ci,
            'lac': info.lac == 'null' ? 'Unknown' : info.lac,
            'psc': info.psc == 'null' ? 'Unknown' : info.psc,
            'rnc': info.rnc == 'null' ? 'Unknown' : info.rnc,
            'operator_name': info.operatorName ?? 'Unknown',
            'is_background': info.background,
          };

          final resp = await http
              .post(
                Uri.parse('${Environment.apiURL}/misenal/guardar'),
                body: jsonEncode(data),
                headers: {'Content-Type': 'application/json'},
                encoding: Encoding.getByName('utf-8'),
              )
              .timeout(const Duration(seconds: 15));

          if (resp.statusCode == 200) {
            await db.updateInformacion(info.copyWith(enviado: 'SI'));
          }
        } on TimeoutException {
          return;
        } catch (e) {
          return;
        }
      }
    }
  }

  Future<bool> guardarMarcacionManual({required FormGroup formulario}) async {
    String imagen = "";
    if (formulario.control('fotografia').value != null) {
      final imageFile = File(
          (formulario.control('fotografia').value as ImageFile).image!.path);

      Uint8List imagebytes = await imageFile.readAsBytes(); //convert to bytes
      imagen = base64.encode(imagebytes);
    }

    //guardar campos de seleccion multiple.
    final respTipoAfectacion =
        (formulario.controls["tipoAfectacion"]!.value as List);
    final respuestaTipoAfectacionMap = (respTipoAfectacion[0] as Map);

    final tipoAfectaciones = <String>[];

    for (var i = 0; i < respuestaTipoAfectacionMap.keys.length; i++) {
      if (respuestaTipoAfectacionMap[
              respuestaTipoAfectacionMap.keys.elementAt(i)] ==
          true) {
        tipoAfectaciones.add(respuestaTipoAfectacionMap.keys.elementAt(i));
      }
    }

    final respAfectacion = (formulario.controls["afectacion"]!.value as List);
    final respuestaAfectacionMap = (respAfectacion[0] as Map);

    final afectaciones = <String>[];

    for (var i = 0; i < respuestaAfectacionMap.keys.length; i++) {
      if (respuestaAfectacionMap[respuestaAfectacionMap.keys.elementAt(i)] ==
          true) {
        afectaciones.add(respuestaAfectacionMap.keys.elementAt(i));
      }
    }

    //fin de guardar campos de seleccion multiple

    final informacion = ManualNetworkInfo(
      idLectura: formulario.control('idLectura').value,
      zona: formulario.control('zona').value,
      departamento: formulario.control('departamento').value,
      municipio: formulario.control('municipio').value,
      ambiente: formulario.control('ambiente').value,
      tipoAmbiente: formulario.control('tipoAmbiente').value.toString(),
      descripcionAmbiente: formulario.control('descripcionAmbiente').value,
      comentarios: formulario.control('comentario').value,
      colonia: formulario.control('colonia').value,
      fallaDesde: formulario.control('fallaDesde').value,
      horas:
          "${formulario.control('horas').value.start.round()}-${formulario.control('horas').value.end.round()}",
      tipoAfectacion: tipoAfectaciones.join(","),
      afectacion: afectaciones.join(","),
      fotografia: imagen,
      enviado: "No",
      mbBajada: formulario.control('mbBajada').value,
      mbSubida: formulario.control('mbSubida').value,
    );

    //guardar información localmente
    add(const OnGuardandoEvent(
      guardando: true,
      mensaje: "Guardando localmente...",
    ));
    await db.addInformacionManual(informacion);
    final lectura =
        await db.getInformacionPorLectura(informacion.idLectura.toString());
    await db.updateInformacion(lectura[0].copyWith(isManual: 'SI'));

    add(const OnGuardandoEvent(
      guardando: false,
      mensaje: "Guardado localmente.",
    ));

    //enviar información
    add(const OnEnviandoEvent(
      enviando: true,
      mensaje: "Enviando datos...",
    ));
    await enviarDatosManuales();
    add(const OnEnviandoEvent(
      enviando: false,
      mensaje: "Enviado exitosamente.",
    ));
    return true;
  }

  Future<void> enviarDatosManuales() async {
    DBService db = DBService();

    final infoList = await db.getInformacionManual();

    for (var info in infoList) {
      try {
        if (info.enviado == 'No') {
          final data = {
            'id': info.idLectura.toString(),
            'tipo_marcacion_manual': "No soportado",
            'zona': info.zona.toString(),
            'ambiente': info.ambiente.toString(),
            'tipo_ambiente': info.tipoAmbiente.toString(),
            'descr_ambiente': info.descripcionAmbiente.toString(),
            'comentarios': info.comentarios.toString(),
            'departamento': info.departamento.toString(),
            'municipio': info.municipio.toString(),
            'colonia_barrio': info.colonia.toString(),
            'falla_desde': info.fallaDesde.toString(),
            'tipo_afectacion': info.tipoAfectacion.toString(),
            'afectacion': info.afectacion.toString(),
            'rango_horas': info.horas.toString(),
            'foto': info.fotografia.toString(),
            'mb_bajada': info.mbBajada,
            'mb_subida': info.mbSubida,
          };

          final resp = await http
              .post(
                Uri.parse('${Environment.apiURL}/misenal/ejecucion_manual'),
                body: jsonEncode(data),
                headers: {'Content-Type': 'application/json'},
                encoding: Encoding.getByName('utf-8'),
              )
              .timeout(const Duration(seconds: 15));

          if (resp.statusCode == 200) {
            await db.updateInformacionManual(info.copyWith(enviado: 'SI'));
          }
        }
      } on TimeoutException catch (_) {
        return;
      } catch (e) {
        return;
      }
    }
  }
}
