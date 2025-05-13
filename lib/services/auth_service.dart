import 'dart:async';
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:miventa_app/global/environment.dart';
import 'package:miventa_app/models/login_response.dart';
import 'package:miventa_app/services/usuario_service.dart';

class AuthService with ChangeNotifier {
  late String usuario;
  bool _autenticando = false;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  // Create storage
  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  //Getters del token de forma estatica
  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'token_expiration');
  }

  Future<String> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token.toString();
  }

  Future<String> getTokenExp() async {
    const _storage = FlutterSecureStorage();
    final tokenExp = await _storage.read(key: 'token_expiration');
    return tokenExp ?? '662601600' //Timestamp 31-12-1990
        ;
  }

  Future<LoginResponse> login(String usuario, String password, String version) async {
    final usuarioService = UsuarioService();
    autenticando = true;

    final osToken = await getTokenOS();
    final androidInfo = await deviceInfoPlugin.androidInfo;

    final data = {
      'usuario': usuario,
      'password': password,
      'appId': 300,
      'userId': osToken,
      'modelo': androidInfo.model,
      'version': version
    };
    try {
      final resp = await http
          .post(
            Uri.parse('${Environment.apiURL}/login'),
            body: jsonEncode(data),
            headers: {'Content-Type': 'application/json'},
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(
            minutes: 1,
          ));
      switch (resp.statusCode) {
        case 200:
          final loginResponse = loginResponseFromJson(resp.body);
          this.usuario = loginResponse.usuario;

          await _guardarToken(
            loginResponse.token,
            loginResponse.exp,
          );
          await usuarioService.guardarUsuario();

          return loginResponse;
        case 401:
          return LoginResponse(flag: 'false',
              mensaje: 'Usuario o contraseña incorrectos.',
              token: '',
              exp: 0,
              usuario: '');
        case 426:
          return LoginResponse(flag: 'false',
              mensaje: 'Versión de la app obsoleta. Por favor actualiza a la última versión.',
              token: '',
              exp: 0,
              usuario: '');
        default:
        // Si tu backend envía un mensaje de error en JSON, puedes parsearlo aquí:
          String errorMsg = 'Error inesperado (${resp.statusCode})';
          try {
            final json = jsonDecode(resp.body);
            if (json['message'] != null) errorMsg = json['message'];
          } catch (_) {}
          return LoginResponse(flag: 'false',
              mensaje: errorMsg,
              token: '',
              exp: 0,
              usuario: '');
      }
    } on TimeoutException catch (e) {
      return LoginResponse(flag: 'false', mensaje: 'Tiempo de espera agotado. Inténtalo de nuevo.',token: '',exp:0, usuario: '');;
    } catch (e) {
      return LoginResponse(flag: 'false', mensaje: 'Error de conexión: $e',token: '',exp:0, usuario: '');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(
      key: 'token',
    );

    final resp = await http
        .post(Uri.parse('${Environment.apiURL}/verificar_token'), headers: {
      'Content-Type': 'application/json',
      'token': token.toString() //header personalizado
    });

    if (resp.statusCode == 200) {
      return true;
    } else {
      logOut();
      return false;
    }
  }

  Future _guardarToken(String token, int exp) async {
    // Write value
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'token_expiration', value: exp.toString());

    return;
  }

  Future guardarTokenOS(String token) async {
    const _storage = FlutterSecureStorage();
    // Write value
    await _storage.write(
      key: 'OSUserIdMiVenta',
      value: token,
    );

    return;
  }

  Future<String> getTokenOS() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'OSUserIdMiVenta');
    return token.toString();
  }

  Future logOut() async {
    // Delete value
    await _storage.delete(key: 'token_expiration');
    await _storage.delete(key: 'token');

    return;
  }
}
