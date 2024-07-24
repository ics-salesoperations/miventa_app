import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState(usuario: Usuario())) {
    on<OnLoginEvent>(_onLoginUsuario);
    on<OnLogoutEvent>(_onLogoutUsuario);
    on<OnCheckLoginEvent>(_onCheckLoginUsuario);
    on<OnToggleShowPassEvent>(
      (event, emit) => emit(
        state.copyWith(
          showPass: !state.showPass,
        ),
      ),
    );
    on<OnActualizarFotoEvent>(
      (event, emit) => emit(
        state.copyWith(
          usuario: state.usuario.copyWith(
            foto: event.foto,
          ),
        ),
      ),
    );
  }

  void _onLoginUsuario(OnLoginEvent event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        autenticado: false,
        procesando: true,
      ),
    );

    AuthService _auth = AuthService();
    UsuarioService _usuarioService = UsuarioService();

    final resp = await _auth.login(event.usuario, event.password);

    if (resp) {
      final token = await _auth.getToken();
      final tokenExpiration = await _auth.getTokenExp();
      final usuario = await _usuarioService.getInfoUsuario();

      emit(
        state.copyWith(
          usuario: usuario,
          autenticado: true,
          fallido: false,
          intentos: 0,
          token: token,
          expirationDate: DateTime.parse(tokenExpiration),
          procesando: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          autenticado: false,
          fallido: true,
          intentos: state.intentos + 1,
          procesando: false,
        ),
      );
    }
  }

  void _onLogoutUsuario(OnLogoutEvent event, Emitter<AuthState> emit) async {
    AuthService _auth = AuthService();

    await _auth.logOut();
    emit(
      state.copyWith(
        autenticado: false,
        fallido: false,
        intentos: 0,
        procesando: false,
      ),
    );
  }

  void _onCheckLoginUsuario(
      OnCheckLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      autenticado: false,
      fallido: false,
      intentos: 0,
      checkLoginFinish: false,
    ));
    final _authService = AuthService();
    final _usuarioService = UsuarioService();

    String expTS = await _authService.getTokenExp();
    String token = await _authService.getToken();

    final fechaExp =
        DateTime.fromMillisecondsSinceEpoch(int.parse(expTS) * 1000);

    final fechaActual = DateTime.now();

    if (fechaActual.compareTo(fechaExp) <= 0) {
      final usuario = await _usuarioService.getInfoUsuario();
      emit(state.copyWith(
        autenticado: true,
        fallido: false,
        intentos: 0,
        usuario: usuario,
        expirationDate: fechaExp,
        token: token,
        checkLoginFinish: true,
      ));
    } else {
      emit(
        state.copyWith(
          autenticado: false,
          fallido: false,
          intentos: 0,
          checkLoginFinish: true,
        ),
      );
    }
  }
}
