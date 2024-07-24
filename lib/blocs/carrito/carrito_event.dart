part of 'carrito_bloc.dart';

abstract class CarritoEvent extends Equatable {
  const CarritoEvent();

  @override
  List<Object> get props => [];
}

class OnCargarModelosEvent extends CarritoEvent {
  final String mensaje;
  final bool cargandoModelos;
  final List<ModeloTangible> modelos;

  const OnCargarModelosEvent({
    required this.cargandoModelos,
    required this.mensaje,
    required this.modelos,
  });
}

class OnUpdateTotalEvent extends CarritoEvent {
  final int total;

  const OnUpdateTotalEvent({
    required this.total,
  });
}

class OnUpdateBlisterEvent extends CarritoEvent {
  final bool blisterValidado;
  final String mensaje;
  final bool validandoBlister;

  const OnUpdateBlisterEvent({
    required this.blisterValidado,
    required this.mensaje,
    required this.validandoBlister,
  });
}

class OnCambiarCategoriaEvent extends CarritoEvent {
  final String categoria;

  const OnCambiarCategoriaEvent({
    required this.categoria,
  });
}

class OnCambiarFiltroEvent extends CarritoEvent {
  final String filtro;

  const OnCambiarFiltroEvent({
    required this.filtro,
  });
}

class OnCambiarSeleccionadoEvent extends CarritoEvent {
  final List<ProductoTangible> seleccionado;

  const OnCambiarSeleccionadoEvent({
    required this.seleccionado,
  });
}

class OnCargarFrmProductoEvent extends CarritoEvent {
  final bool cargandoFrmProducto;
  final FormGroup? frmProducto;

  const OnCargarFrmProductoEvent({
    required this.cargandoFrmProducto,
    this.frmProducto,
  });
}

class OnCargarLstTangibleModeloEvent extends CarritoEvent {
  final bool cargandoLstTangibleModelo;
  final List<ProductoTangible> lstTangibleModelo;

  const OnCargarLstTangibleModeloEvent({
    required this.cargandoLstTangibleModelo,
    required this.lstTangibleModelo,
  });
}

class OnCargarModelosAsignadosoEvent extends CarritoEvent {
  final List<ModeloTangible> modelosAsignados;

  const OnCargarModelosAsignadosoEvent({
    required this.modelosAsignados,
  });
}

class OnEnviarTangiblesEvent extends CarritoEvent {
  final bool enviando;
  final String mensaje;

  const OnEnviarTangiblesEvent({
    required this.mensaje,
    required this.enviando,
  });
}

class OnChangeModeloActual extends CarritoEvent {
  final ModeloTangible actual;

  const OnChangeModeloActual({
    required this.actual,
  });
}

class OnChangeSerieActual extends CarritoEvent {
  final ProductoTangible actual;

  const OnChangeSerieActual({
    required this.actual,
  });
}
