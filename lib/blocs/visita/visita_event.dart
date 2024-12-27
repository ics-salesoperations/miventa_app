part of 'visita_bloc.dart';

abstract class VisitaEvent extends Equatable {
  const VisitaEvent();

  @override
  List<Object> get props => [];
}

class OnValidarInicioVisitaEvent extends VisitaEvent {
  final bool visitaValida;
  final String mensaje;

  const OnValidarInicioVisitaEvent({
    required this.visitaValida,
    required this.mensaje,
  });
}

class OnIniciarVisitaEvent extends VisitaEvent {
  final bool visitaIniciada;
  final List<Formulario> frmControlVisita;
  final FormGroup? formGroupVisita;
  final bool frmVisitaListo;
  final List<String> errores;

  const OnIniciarVisitaEvent({
    required this.visitaIniciada,
    required this.frmControlVisita,
    this.formGroupVisita,
    required this.frmVisitaListo,
    required this.errores,
  });
}

class OnFinalizarVisitaEvent extends VisitaEvent {
  final bool guardado;
  final bool enviado;

  const OnFinalizarVisitaEvent({
    required this.guardado,
    required this.enviado,
  });
}

class OnCheckinVisitaEvent extends VisitaEvent {
  final bool guardado;
  final bool enviado;

  const OnCheckinVisitaEvent({
    required this.guardado,
    required this.enviado,
  });
}

class OnGuardandoFormularioEvent extends VisitaEvent {
  final bool guardandoFormulario;
  const OnGuardandoFormularioEvent({
    required this.guardandoFormulario,
  });
}

class OnActualizarInformacionEvent extends VisitaEvent {
  final int formId;
  final String instanceId;
  final String fechaCreacion;
  final String respondentId;
  final String idVisita;

  const OnActualizarInformacionEvent({
    required this.formId,
    required this.instanceId,
    required this.fechaCreacion,
    required this.respondentId,
    required this.idVisita,
  });
}

class OnActualizarIdVisitaEvent extends VisitaEvent {
  final String idVisita;
  final int idPdv;

  const OnActualizarIdVisitaEvent({
    required this.idVisita,
    required this.idPdv,
  });
}
