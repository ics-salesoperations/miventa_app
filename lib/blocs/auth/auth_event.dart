part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class OnLoginEvent extends AuthEvent {
  final String usuario;
  final String password;

  const OnLoginEvent({required this.usuario, required this.password});
}

class OnCheckLoginEvent extends AuthEvent {
  final bool checkLoginFinish;
  const OnCheckLoginEvent({required this.checkLoginFinish});
}

class OnLogoutEvent extends AuthEvent {}

class OnActualizarFotoEvent extends AuthEvent {
  final String foto;
  const OnActualizarFotoEvent({
    required this.foto,
  });
}

class OnToggleShowPassEvent extends AuthEvent {}
