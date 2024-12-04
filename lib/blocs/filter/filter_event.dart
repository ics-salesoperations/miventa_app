part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class OnCargarDealerEvent extends FilterEvent {
  final List<Dealer> dealers;
  final bool cargandoDealers;

  const OnCargarDealerEvent({
    required this.dealers,
    required this.cargandoDealers,
  });
}

class OnCargarSucursalEvent extends FilterEvent {
  final List<Sucursal> sucursales;
  final bool cargandoSucursales;

  const OnCargarSucursalEvent({
    required this.sucursales,
    required this.cargandoSucursales,
  });
}

class OnCargarCircuitosEvent extends FilterEvent {
  final List<Circuito> circuitos;
  final bool cargandoCircuitos;

  const OnCargarCircuitosEvent({
    required this.circuitos,
    required this.cargandoCircuitos,
  });
}

class OnCargarPdvsEvent extends FilterEvent {
  final List<Planning> pdvs;
  final bool cargandoPDVs;

  const OnCargarPdvsEvent({
    required this.pdvs,
    required this.cargandoPDVs,
  });
}

class OnSelectPDVEvent extends FilterEvent {
  final List<Planning> selectedPDV;
  final bool isSelectedPDV;

  const OnSelectPDVEvent({
    required this.selectedPDV,
    required this.isSelectedPDV,
  });
}



class OnActualizarFiltrosEvent extends FilterEvent {
  final String idSucursal;
  final String nombreCircuito;
  final String segmento;
  final String servicio;

  const OnActualizarFiltrosEvent({
    required this.idSucursal,
    required this.nombreCircuito,
    required this.segmento,
    required this.servicio,
  });
}

class OnCargarSegmentosEvent extends FilterEvent {
  final List<String> segmentos;
  final bool cargandoSegmentos;

  const OnCargarSegmentosEvent({
    required this.segmentos,
    required this.cargandoSegmentos,
  });
}
class OnCargarServiciosEvent extends FilterEvent {
  final List<String> servicios;
//  final bool cargandoServicios;

  const OnCargarServiciosEvent({
    required this.servicios,
//    required this.cargandoSegmentos,
  });
}
