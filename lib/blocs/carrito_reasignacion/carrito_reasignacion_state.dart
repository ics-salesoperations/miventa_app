part of 'carrito_reasignacion_bloc.dart';

class CarritoReasignacionState extends Equatable {
  final List<ModeloTangible> modelos;
  final List<ModeloTangible> modelosAsignados;
  final List<ProductoTangibleReasignacion> lstTangibleModelo;
  final ProductoTangibleReasignacion serieActual;
  final ModeloTangible actual;
  final bool cargandoLstTangibleModelo;
  final bool cargandoModelos;
  final String mensaje;
  final int idPdv;
  final String selectedCat;
  final FormGroup frmProductos;
  final bool cargandoFrmProductos;
  final int total;
  final String filter;
  final bool enviando;
  final bool blisterValidado;
  final bool validandoBlister;

  const CarritoReasignacionState({
    this.cargandoModelos = false,
    this.mensaje = "",
    this.modelos = const [],
    this.modelosAsignados = const [],
    this.lstTangibleModelo = const [],
    required this.serieActual,
    this.idPdv = 0,
    this.selectedCat = "",
    required this.frmProductos,
    this.cargandoFrmProductos = false,
    this.cargandoLstTangibleModelo = false,
    this.total = 0,
    this.filter = "",
    this.enviando = false,
    required this.actual,
    this.blisterValidado = false,
    this.validandoBlister = false,
  });

  CarritoReasignacionState copyWith({
    List<ModeloTangible>? modelos,
    List<ModeloTangible>? modelosAsignados,
    bool? cargandoModelos,
    String? mensaje,
    int? idPdv,
    String? selectedCat,
    FormGroup? frmProductos,
    bool? cargandoFrmProductos,
    bool? enviando,
    List<ProductoTangibleReasignacion>? lstTangibleModelo,
    bool? cargandoLstTangibleModelo,
    int? total,
    String? filter,
    ProductoTangibleReasignacion? serieActual,
    ModeloTangible? actual,
    bool? blisterValidado,
    bool? validandoBlister,
  }) =>
      CarritoReasignacionState(
        modelos: modelos ?? this.modelos,
        modelosAsignados: modelosAsignados ?? this.modelosAsignados,
        cargandoModelos: cargandoModelos ?? this.cargandoModelos,
        mensaje: mensaje ?? this.mensaje,
        idPdv: idPdv ?? this.idPdv,
        selectedCat: selectedCat ?? this.selectedCat,
        frmProductos: frmProductos ?? this.frmProductos,
        cargandoFrmProductos: cargandoFrmProductos ?? this.cargandoFrmProductos,
        lstTangibleModelo: lstTangibleModelo ?? this.lstTangibleModelo,
        cargandoLstTangibleModelo:
            cargandoLstTangibleModelo ?? this.cargandoLstTangibleModelo,
        total: total ?? this.total,
        filter: filter ?? this.filter,
        serieActual: serieActual ?? this.serieActual,
        enviando: enviando ?? this.enviando,
        actual: actual ?? this.actual,
        blisterValidado: blisterValidado ?? this.blisterValidado,
        validandoBlister: validandoBlister ?? this.validandoBlister,
      );

  @override
  List<Object> get props => [
        modelos,
        cargandoModelos,
        mensaje,
        idPdv,
        selectedCat,
        cargandoFrmProductos,
        lstTangibleModelo,
        cargandoLstTangibleModelo,
        total,
        filter,
        serieActual,
        modelosAsignados,
        enviando,
        frmProductos,
        actual,
        blisterValidado,
        validandoBlister,
      ];
}
