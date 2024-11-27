part of 'carrito_reasignacion_bloc.dart';

abstract class CarritoReasignacionEvent extends Equatable {
  const CarritoReasignacionEvent();

  @override
  List<Object> get props => [];
}

class OnCargarModelosReasignacionEvent extends CarritoReasignacionEvent {
  final String mensaje;
  final bool cargandoModelos;
  final List<ModeloTangible> modelos;

  const OnCargarModelosReasignacionEvent({
    required this.cargandoModelos,
    required this.mensaje,
    required this.modelos,
  });
}

class OnUpdateTotalReasignacionEvent extends CarritoReasignacionEvent {
  final int total;

  const OnUpdateTotalReasignacionEvent({
    required this.total,
  });
}

class OnUpdateBlisterReasignacionEvent extends CarritoReasignacionEvent {
  final bool blisterValidado;
  final String mensaje;
  final bool validandoBlister;

  const OnUpdateBlisterReasignacionEvent({
    required this.blisterValidado,
    required this.mensaje,
    required this.validandoBlister,
  });
}

class OnCambiarCategoriaReasignacionEvent extends CarritoReasignacionEvent {
  final String categoria;

  const OnCambiarCategoriaReasignacionEvent({
    required this.categoria,
  });
}

class OnCambiarFiltroReasignacionEvent extends CarritoReasignacionEvent {
  final String filtro;

  const OnCambiarFiltroReasignacionEvent({
    required this.filtro,
  });
}

class OnCambiarSeleccionadoReasignacionEvent extends CarritoReasignacionEvent {
  final List<ProductoTangibleReasignacion> seleccionado;

  const OnCambiarSeleccionadoReasignacionEvent({
    required this.seleccionado,
  });
}

class OnCargarFrmProductoReasignacionEvent extends CarritoReasignacionEvent {
  final bool cargandoFrmProducto;
  final FormGroup? frmProducto;

  const OnCargarFrmProductoReasignacionEvent({
    required this.cargandoFrmProducto,
    this.frmProducto,
  });
}

class OnCargarLstTangibleModeloReasignacionEvent extends CarritoReasignacionEvent {
  final bool cargandoLstTangibleModelo;
  final List<ProductoTangibleReasignacion> lstTangibleModelo;

  const OnCargarLstTangibleModeloReasignacionEvent({
    required this.cargandoLstTangibleModelo,
    required this.lstTangibleModelo,
  });
}

class OnCargarModelosAsignadosoReasignacionEvent extends CarritoReasignacionEvent {
  final List<ModeloTangible> modelosAsignados;

  const OnCargarModelosAsignadosoReasignacionEvent({
    required this.modelosAsignados,
  });
}


class OnEnviarTangiblesReasignacionEvent extends CarritoReasignacionEvent {
  final bool enviando;
  final String mensaje;

  const OnEnviarTangiblesReasignacionEvent({
    required this.mensaje,
    required this.enviando,
  });
}

class OnChangeModeloActualReasignacion extends CarritoReasignacionEvent {
  final ModeloTangible actual;

  const OnChangeModeloActualReasignacion({
    required this.actual,
  });
}

class OnChangeSerieActualReasignacion extends CarritoReasignacionEvent {
  final ProductoTangibleReasignacion actual;

  const OnChangeSerieActualReasignacion({
    required this.actual,
  });
}
