// part of 'sucursal_boc.dart';

abstract class SucursalState {}

class SucursalInitial extends SucursalState {}

class SucursalLoading extends SucursalState {}

class SucursalLoaded extends SucursalState {
  final Map<String, dynamic> sucursalData;

  SucursalLoaded(this.sucursalData);
}

class SucursalError extends SucursalState {
  final String message;

  SucursalError(this.message);
} 