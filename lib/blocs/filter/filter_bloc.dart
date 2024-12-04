import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/services.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final DBService _dbService = DBService();

  FilterBloc() : super(const FilterState()) {
    on<OnCargarDealerEvent>((event, emit) {
      emit(
        state.copyWith(
          cargandoDealers: event.cargandoDealers,
          dealers: event.dealers,
        ),
      );
    });
    on<OnCargarSucursalEvent>((event, emit) {
      emit(
        state.copyWith(
          cargandoSucursales: event.cargandoSucursales,
          sucursales: event.sucursales,
        ),
      );
    });
    on<OnCargarCircuitosEvent>((event, emit) {
      emit(
        state.copyWith(
          cargandoCircuitos: event.cargandoCircuitos,
          circuitos: event.circuitos,
        ),
      );
    });
    on<OnCargarPdvsEvent>((event, emit) {
      emit(
        state.copyWith(
          pdvs: event.pdvs,
          cargandoPDVs: event.cargandoPDVs,
        ),
      );
    });
    on<OnSelectPDVEvent>((event, emit) {
      emit(
        state.copyWith(
          selectedPDV: event.selectedPDV,
          isSelectedPDV: event.isSelectedPDV,
        ),
      );
    });
    on<OnCargarSegmentosEvent>((event, emit) {
      emit(
        state.copyWith(
          segmentos: event.segmentos,
          cargandoSegmentos: event.cargandoSegmentos,
          isSelectedPDV: false,
        ),
      );
    });
    on<OnCargarServiciosEvent>((event, emit) {
      emit(
        state.copyWith(
          servicios: event.servicios,
          //cargandoServicio: event.cargandoServicio,
          isSelectedPDV: false,
        ),
      );
    });
      
      on<OnActualizarFiltrosEvent>((event, emit) {
      emit(
        state.copyWith(
          idSucursal: event.idSucursal,
          nombreCircuito: event.nombreCircuito,
          segmento: event.segmento,
          servicio: event.servicio,
          isSelectedPDV: false,
        ),
      );
    });

    init();
  }

  Future<void> init({
    String? idSucursal,
    String? nombreCircuito,
    String? segmento,
    String? servicio,
  }) async {
    await getDealers();
    await getSucursales();
    await getCircuitos();
    await getPDVS();

    await getSegmentos(
      idSucursal: idSucursal,
      nombreCircuito: nombreCircuito,
    );
    await getServicios(
        idSucursal: idSucursal,
        nombreCircuito: nombreCircuito,
        servicio: servicio);
  }

  Future<void> getSegmentos({
    String? idSucursal,
    String? idDealer,
    String? nombreCircuito,
  }) async {
    add(const OnCargarSegmentosEvent(
      cargandoSegmentos: true,
      segmentos: [],
    ));

    List<String> segmentos;
    try {
      segmentos = await _dbService.leerSegmentos(
        idSucursal: idSucursal,
        nombreCircuito: nombreCircuito,
      );
    } catch (e) {
      segmentos = <String>[];
    }
    add(OnCargarSegmentosEvent(
      cargandoSegmentos: false,
      segmentos: segmentos,
    ));
  }

  Future<void> getServicios({
    String? idSucursal,
    String? idDealer,
    String? nombreCircuito,
    String? segmento,
    String? servicio,
  }) async {
    add(const OnCargarServiciosEvent(
      //cargandoSegmentos: true,
      servicios: [],
    ));

    List<String> servicios;
    try {
      servicios = await _dbService.leerServicios(
        idSucursal: idSucursal,
        nombreCircuito: nombreCircuito,
        segmento: segmento,
        servicio: servicio,
      );
    } catch (e) {
      print("error ");
      print(e);
      servicios = <String>[];
    }
    add(OnCargarServiciosEvent(
      //cargandoSegmentos: false,
      servicios: servicios,
    ));
  }

  Future<void> getDealers() async {
    add(const OnCargarDealerEvent(
      cargandoDealers: true,
      dealers: [],
    ));

    List<Dealer> dealer;
    try {
      dealer = await _dbService.leerDealers();
    } catch (e) {
      dealer = <Dealer>[];
    }
    add(OnCargarDealerEvent(
      cargandoDealers: false,
      dealers: dealer,
    ));
  }

  Future<void> getSucursales({String? idDealer}) async {
    add(const OnCargarSucursalEvent(
      cargandoSucursales: true,
      sucursales: [],
    ));
    List<Sucursal> sucursal;
    try {
      sucursal = await _dbService.leerSucursales();
    } catch (e) {
      sucursal = <Sucursal>[];
    }
    add(OnCargarSucursalEvent(
      cargandoSucursales: false,
      sucursales: sucursal,
    ));
  }

  Future<void> getCircuitos({String? idSucursal}) async {
    add(
      const OnCargarCircuitosEvent(
        cargandoCircuitos: true,
        circuitos: [],
      ),
    );
    List<Circuito> circuito;
    try {
      circuito = await _dbService.leerCircuitosFilter();
    } catch (e) {
      circuito = <Circuito>[];
    }
    add(OnCargarCircuitosEvent(
      cargandoCircuitos: false,
      circuitos: circuito,
    ));
  }

  Future<void> getPDVS({
    String? idSucursal,
    String? nombreCircuito,
    String? segmento,
    String? servicio,
    String? codigoCircuito,
    DateTime? fecha,
  }) async {
    add(const OnCargarPdvsEvent(
      cargandoPDVs: true,
      pdvs: [],
    ));
    List<Planning> pdvs;
    try {
      UsuarioService usr = UsuarioService();
      Usuario usuario = await usr.getInfoUsuario();
      pdvs = await _dbService.leerListadoPdv(
        idSucursal: idSucursal,
        codigoCircuito: codigoCircuito,
        fecha: fecha,
        usuario:
            (usuario.perfil == 6 || usuario.perfil == 5 || usuario.perfil == 1)
                ? ""
                : (usuario.perfil == 152 || usuario.perfil == 153 || usuario.perfil == 155 || usuario.perfil == 156) ? 'GERENTE': usuario.usuario.toString(),
        nombreCircuito: nombreCircuito,
        segmento: segmento,
        servicio: servicio,
      );
    } catch (e) {
      pdvs = <Planning>[];
    }

    add(OnCargarPdvsEvent(
      cargandoPDVs: false,
      pdvs: pdvs,
    ));
  }
}
