part of 'formulario_bloc.dart';

abstract class FormularioEvent extends Equatable {
  const FormularioEvent();

  @override
  List<Object> get props => [];
}

class OnActualizarFormsEvent extends FormularioEvent {
  final List<FormularioResumen> formularios;
  final bool formsActualizados;

  const OnActualizarFormsEvent({
    required this.formularios,
    required this.formsActualizados,
  });
}

class OnCargarFormsEvent extends FormularioEvent {
  final List<FormularioResumen> formularios;
  final List<FormGroup>? lstFormgroupVisita;
  final List<List<Formulario>> lstFormVisita;
  final bool isFrmVisitaListo;

  const OnCargarFormsEvent({
    required this.formularios,
    required this.lstFormgroupVisita,
    required this.lstFormVisita,
    required this.isFrmVisitaListo,
  });
}

class OnCurrentFormReadyEvent extends FormularioEvent {
  final List<Formulario> currentForm;
  final FormGroup? formGroup;
  final bool isCurrentFormReady;

  const OnCurrentFormReadyEvent({
    required this.currentForm,
    required this.isCurrentFormReady,
    this.formGroup,
  });
}

class OnCurrentFormSaving extends FormularioEvent {
  final List<Formulario>? currentForm;
  final FormGroup? formGroup;

  const OnCurrentFormSaving({
    required this.currentForm,
    required this.formGroup,
  });
}

class OnProcessingEvent extends FormularioEvent {
  final String mensaje;
  final int procesado;
  final int sinProcesar;
  final bool guardado;
  final bool enviado;

  const OnProcessingEvent({
    required this.mensaje,
    required this.procesado,
    required this.sinProcesar,
    required this.guardado,
    required this.enviado,
  });
}

class OnChangeBetweenForms extends FormularioEvent {
  final int frmActualVisita;

  const OnChangeBetweenForms({
    required this.frmActualVisita,
  });
}

class OnUpdateFormsEvent extends FormularioEvent {
  final List<FormularioResumen> formularios;

  const OnUpdateFormsEvent({
    required this.formularios,
  });
}
