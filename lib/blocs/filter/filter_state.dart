part of 'filter_bloc.dart';

class FilterState extends Equatable {
  final List<Dealer> dealers;
  final List<Sucursal> sucursales;
  final List<Circuito> circuitos;
  final List<Planning> pdvs;
  final List<Planning> selectedPDV;
  final bool cargandoDealers;
  final bool cargandoSucursales;
  final bool cargandoCircuitos;
  final bool cargandoPDVs;
  final bool isSelectedPDV;

  const FilterState({
    this.selectedPDV = const <Planning>[],
    this.pdvs = const <Planning>[],
    this.circuitos = const <Circuito>[],
    this.sucursales = const <Sucursal>[],
    this.dealers = const <Dealer>[],
    this.cargandoDealers = false,
    this.cargandoSucursales = false,
    this.cargandoCircuitos = false,
    this.cargandoPDVs = false,
    this.isSelectedPDV = false,
  });

  FilterState copyWith({
    List<Planning>? selectedPDV,
    List<Planning>? pdvs,
    List<Circuito>? circuitos,
    List<Sucursal>? sucursales,
    List<Dealer>? dealers,
    bool? cargandoDealers,
    bool? cargandoSucursales,
    bool? cargandoCircuitos,
    bool? cargandoPDVs,
    bool? isSelectedPDV,
  }) =>
      FilterState(
        selectedPDV: selectedPDV ?? this.selectedPDV,
        pdvs: pdvs ?? this.pdvs,
        circuitos: circuitos ?? this.circuitos,
        sucursales: sucursales ?? this.sucursales,
        dealers: dealers ?? this.dealers,
        cargandoDealers: cargandoDealers ?? this.cargandoDealers,
        cargandoSucursales: cargandoSucursales ?? this.cargandoSucursales,
        cargandoCircuitos: cargandoCircuitos ?? this.cargandoCircuitos,
        cargandoPDVs: cargandoPDVs ?? this.cargandoPDVs,
        isSelectedPDV: isSelectedPDV ?? this.isSelectedPDV,
      );

  @override
  List<Object> get props => [
        pdvs,
        cargandoDealers,
        cargandoSucursales,
        cargandoCircuitos,
        cargandoPDVs,
        isSelectedPDV,
        selectedPDV,
      ];
}
