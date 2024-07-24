part of 'formulario_bloc.dart';

class FormularioState extends Equatable {
  final List<FormularioResumen> formularios;
  final bool formsActualizados;
  final List<Formulario> currentForm;
  final FormGroup? currentFormgroup;
  final List<FormGroup> lstFormgroupVisita;
  final List<List<Formulario>> lstFormVisita;
  final bool isCurrentFormListo;
  final bool isFrmVisitaListo;
  final int frmActualVisita;
  final String mensaje;
  final int procesado;
  final int sinProcesar;
  final bool guardado;
  final bool enviado;

  const FormularioState({
    this.formularios = const [],
    this.formsActualizados = false,
    this.isCurrentFormListo = false,
    this.isFrmVisitaListo = false,
    this.currentForm = const [],
    this.lstFormgroupVisita = const [],
    this.lstFormVisita = const [],
    this.currentFormgroup,
    this.mensaje = "",
    this.procesado = 0,
    this.sinProcesar = 0,
    this.frmActualVisita = 0,
    this.guardado = false,
    this.enviado = false,
  });

  FormularioState copyWith({
    List<FormularioResumen>? formularios,
    bool? formsActualizados,
    List<Formulario>? currentForm,
    List<List<Formulario>>? lstFormVisita,
    List<FormGroup>? lstFormgroupVisita,
    bool? isCurrentFormListo,
    bool? isFrmVisitaListo,
    int? frmActualVisita,
    FormGroup? currentFormgroup,
    String? mensaje,
    int? procesado,
    int? sinProcesar,
    bool? guardado,
    bool? enviado,
  }) =>
      FormularioState(
        formularios: formularios ?? this.formularios,
        formsActualizados: formsActualizados ?? this.formsActualizados,
        currentForm: currentForm ?? this.currentForm,
        isCurrentFormListo: isCurrentFormListo ?? this.isCurrentFormListo,
        isFrmVisitaListo: isFrmVisitaListo ?? this.isFrmVisitaListo,
        currentFormgroup: currentFormgroup ?? this.currentFormgroup,
        lstFormVisita: lstFormVisita ?? this.lstFormVisita,
        lstFormgroupVisita: lstFormgroupVisita ?? this.lstFormgroupVisita,
        frmActualVisita: frmActualVisita ?? this.frmActualVisita,
        mensaje: mensaje ?? this.mensaje,
        procesado: procesado ?? this.procesado,
        sinProcesar: sinProcesar ?? this.sinProcesar,
        guardado: guardado ?? this.guardado,
        enviado: enviado ?? this.enviado,
      );

  @override
  List<Object> get props => [
        formularios,
        formsActualizados,
        isCurrentFormListo,
        isFrmVisitaListo,
        currentForm,
        lstFormVisita,
        lstFormgroupVisita,
        mensaje,
        procesado,
        sinProcesar,
        guardado,
        enviado,
        frmActualVisita,
      ];
}
