// part of 'sucursal_boc.dart';
// import 'package:equatable/equatable.dart';

abstract class SucursalEvent {}

class LoadSucursalData extends SucursalEvent {
  final String usuario;
  final String idDealer;
  final String idSucursal;

  LoadSucursalData(this.usuario, this.idDealer, this.idSucursal);
}
