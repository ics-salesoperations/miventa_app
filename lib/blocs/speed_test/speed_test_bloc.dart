import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'speed_test_event.dart';
part 'speed_test_state.dart';

class SpeedTestBloc extends Bloc<SpeedTestEvent, SpeedTestState> {
  SpeedTestBloc()
      : super(const SpeedTestState(
          upload: 0.0,
          download: 0.0,
        )) {
    on<OnIniciarSpeedTest>((event, emit) {
      return emit(state.copyWith(
        download: event.download,
        upload: event.upload,
        mensaje: event.mensaje,
        ejecutando: event.ejecutando,
        tipo: event.tipo,
      ));
    });
  }

/*
  Future<void> startTest() async {
    add(
      const OnIniciarSpeedTest(
        download: 0.0,
        upload: 0.0,
        mensaje: "Iniciando prueba de velocidad...",
        ejecutando: true,
        tipo: "BAJADA",
      ),
    );
    final settings = await tester.getSettings();
    final servers = settings.servers;

    add(
      const OnIniciarSpeedTest(
          download: 0.0,
          upload: 0.0,
          mensaje: "Obtiendo lista de servidores...",
          ejecutando: true,
          tipo: "BAJADA"),
    );
    final _bestServersList = await tester.getBestServers(
      servers: servers,
      retryCount: 1,
      timeoutInSeconds: 1,
    );

    print("LISTA DE SERVIDORES...");
    for (var server in _bestServersList) {
      print(
          server.name + ":HOST:" + server.host + " COUNTRY:" + server.country);
      print(server.distance);
    }

    add(
      const OnIniciarSpeedTest(
          download: 0.0,
          upload: 0.0,
          mensaje: "Realizando prueba de descarga...",
          ejecutando: true,
          tipo: "BAJADA"),
    );

    final download = await testDownloadSpeed(_bestServersList);

    add(
      OnIniciarSpeedTest(
          download: download,
          upload: 0.0,
          mensaje: "Realizando prueba de subida...",
          ejecutando: true,
          tipo: "SUBIDA"),
    );
    final upload = await testUploadSpeed(_bestServersList);

    add(
      OnIniciarSpeedTest(
          download: download,
          upload: upload,
          mensaje: "Prueba finalizada con éxito",
          ejecutando: false,
          tipo: "SUBIDA"),
    );
  }

  Future<double> testDownloadSpeed(List<Server> bestServersList) async {
    /*setState(() {
      loadingDownload = true;
    });*/
    final _downloadRate = await tester.testDownloadSpeed(
      servers: bestServersList,
      downloadSizes: defaultDownloadSizes,
    );

    print(":::::::::::NUEVA DESCARGAR: ");
    /*setState(() {
      downloadRate = _downloadRate;
      loadingDownload = false;
    });*/

    return _downloadRate;
  }

  Future<double> testUploadSpeed(List<Server> bestServersList) async {
    /*setState(() {
      loadingUpload = true;
    });*/

    final _uploadRate = await tester.testUploadSpeed(
      servers: bestServersList,
      simultaneousUploads: 1,
      retryCount: 1,
    );

    print(":::::::::::::::::::NUEVA CARGA: ");
    print(_uploadRate.toStringAsFixed(2));

    /*setState(() {
      uploadRate = _uploadRate;
      loadingUpload = false;
    });*/
    return _uploadRate;
  }*/
}
