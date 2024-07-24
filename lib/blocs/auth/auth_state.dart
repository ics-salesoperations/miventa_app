part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final Usuario usuario;
  final bool autenticado;
  final bool fallido;
  final bool checkLoginFinish;
  final int intentos;
  final String token;
  final bool showPass;
  final bool procesando;
  final DateTime expirationDate = DateTime.parse('19900101');

  AuthState({
    required this.usuario,
    this.autenticado = false,
    this.token = "",
    this.fallido = false,
    this.checkLoginFinish = false,
    this.intentos = 0,
    this.showPass = false,
    this.procesando = false,
  });

  AuthState copyWith({
    Usuario? usuario,
    bool? autenticado,
    bool? showPass,
    String? token,
    DateTime? expirationDate,
    bool? fallido,
    bool? checkLoginFinish,
    int? intentos,
    bool? procesando,
  }) =>
      AuthState(
        usuario: usuario ?? this.usuario,
        autenticado: autenticado ?? this.autenticado,
        showPass: showPass ?? this.showPass,
        token: token ?? this.token,
        fallido: fallido ?? this.fallido,
        checkLoginFinish: checkLoginFinish ?? this.checkLoginFinish,
        intentos: intentos ?? this.intentos,
        procesando: procesando ?? this.procesando,
      );

  @override
  List<Object> get props => [
        usuario,
        autenticado,
        token,
        expirationDate,
        fallido,
        intentos,
        checkLoginFinish,
        showPass,
        procesando,
      ];
}
