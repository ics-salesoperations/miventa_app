part of 'visita_bloc.dart';

class VisitaState extends Equatable {
  final bool frmVisitaListo;
  final String mensaje;
  final int formId;
  final String instanceId;
  final String fechaCreacion;
  final String respondentId;
  final List<Formulario> frmControlVisita;
  final List<String> errores;
  final FormGroup? formGroupVisita;
  final bool guardado;
  final bool enviado;
  final String idVisita;
  final int idPdv;

  const VisitaState({
    this.frmVisitaListo = false,
    this.mensaje = "",
    this.frmControlVisita = const [],
    this.formGroupVisita,
    this.errores = const [],
    this.guardado = false,
    this.enviado = false,
    this.formId = -1,
    this.instanceId = "",
    this.respondentId = "",
    this.fechaCreacion = "",
    this.idVisita = "",
    this.idPdv = 0,
  });

  VisitaState copyWith({
    bool? visitaFinalizada,
    bool? frmVisitaListo,
    String? mensaje,
    List<String>? errores,
    List<Formulario>? frmControlVisita,
    FormGroup? formGroupVisita,
    bool? guardandoFormulario,
    bool? guardado,
    bool? enviado,
    int? formId,
    String? instanceId,
    String? fechaCreacion,
    String? respondentId,
    String? idVisita,
    int? idPdv,
  }) =>
      VisitaState(
        frmVisitaListo: frmVisitaListo ?? this.frmVisitaListo,
        mensaje: mensaje ?? this.mensaje,
        errores: errores ?? this.errores,
        frmControlVisita: frmControlVisita ?? this.frmControlVisita,
        formGroupVisita: formGroupVisita ?? this.formGroupVisita,
        guardado: guardado ?? this.guardado,
        enviado: enviado ?? this.enviado,
        formId: formId ?? this.formId,
        instanceId: instanceId ?? this.instanceId,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        respondentId: respondentId ?? this.respondentId,
        idVisita: idVisita ?? this.idVisita,
        idPdv: idPdv ?? this.idPdv,
      );

  @override
  List<Object> get props => [
        frmVisitaListo,
        mensaje,
        frmControlVisita,
        errores,
        guardado,
        enviado,
        formId,
        instanceId,
        fechaCreacion,
        respondentId,
        idVisita,
        idPdv,
      ];
}
