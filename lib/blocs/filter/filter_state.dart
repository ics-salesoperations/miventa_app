part of 'filter_bloc.dart';

class FilterState extends Equatable {
  final List<Dealer> dealers;
  final List<Sucursal> sucursales;
  final List<Circuito> circuitos;

  final List<String> segmentos;
  final List<String> servicios;

  final List<Planning> pdvs;
  final List<Planning> selectedPDV;
  final bool cargandoDealers;
  final bool cargandoSucursales;
  final bool cargandoCircuitos;
  final bool cargandoPDVs;
  final bool isSelectedPDV;

  final bool cargandoSegmentos;
  final String idSucursal;
  final String nombreCircuito;
  final String segmento;
  final String servicio;

  final Sucursal? sucursalSeleccionada;

  const FilterState({
    this.selectedPDV = const <Planning>[],
    this.pdvs = const <Planning>[],
    this.circuitos = const <Circuito>[],
    this.sucursales = const <Sucursal>[],
    this.dealers = const <Dealer>[],
    this.segmentos = const <String>[],
    this.servicios = const <String>[],
    this.cargandoDealers = false,
    this.cargandoSucursales = false,
    this.cargandoCircuitos = false,
    this.cargandoPDVs = false,
    this.isSelectedPDV = false,
    this.cargandoSegmentos = false,
    this.idSucursal = "",
    this.nombreCircuito = "",
    this.segmento = "",
    this.servicio = "",
    this.sucursalSeleccionada,
  });

  FilterState copyWith({
    List<Planning>? selectedPDV,
    List<Planning>? pdvs,
    List<Circuito>? circuitos,
    List<Sucursal>? sucursales,
    List<Dealer>? dealers,
    List<String>? segmentos,
    List<String>? servicios,
    bool? cargandoDealers,
    bool? cargandoSucursales,
    bool? cargandoCircuitos,
    bool? cargandoPDVs,
    bool? isSelectedPDV,
    bool? cargandoSegmentos,
    String? idSucursal,
    String? nombreCircuito,
    String? segmento,
    String? servicio,
    Sucursal? sucursalSeleccionada,
  }) =>
      FilterState(
        selectedPDV: selectedPDV ?? this.selectedPDV,
        pdvs: pdvs ?? this.pdvs,
        circuitos: circuitos ?? this.circuitos,
        sucursales: sucursales ?? this.sucursales,
        dealers: dealers ?? this.dealers,
        segmentos: segmentos ?? this.segmentos,
        servicios: servicios ?? this.servicios,
        cargandoDealers: cargandoDealers ?? this.cargandoDealers,
        cargandoSucursales: cargandoSucursales ?? this.cargandoSucursales,
        cargandoCircuitos: cargandoCircuitos ?? this.cargandoCircuitos,
        cargandoPDVs: cargandoPDVs ?? this.cargandoPDVs,
        isSelectedPDV: isSelectedPDV ?? this.isSelectedPDV,
        cargandoSegmentos: cargandoSegmentos ?? this.cargandoSegmentos,
        idSucursal: idSucursal ?? this.idSucursal,
        nombreCircuito: nombreCircuito ?? this.nombreCircuito,
        segmento: segmento ?? this.segmento,
        servicio: servicio ?? this.servicio,
        sucursalSeleccionada: sucursalSeleccionada ?? this.sucursalSeleccionada,
      );

  @override
  List<Object?> get props => [
        pdvs,
        cargandoDealers,
        cargandoSucursales,
        cargandoCircuitos,
        cargandoPDVs,
        isSelectedPDV,
        selectedPDV,
        segmentos,
        servicios,
        cargandoSegmentos,
        segmento,
        servicio,
        sucursalSeleccionada,
      ];
}
