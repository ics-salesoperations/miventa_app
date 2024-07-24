import 'dart:convert';
import 'package:miventa_app/models/model.dart';

FormularioAnswer formularioAnswerFromMap(String str) =>
    FormularioAnswer.fromMap(json.decode(str));
String formularioAnswerToJson(FormularioAnswer data) =>
    json.encode(data.toJson());

class FormularioAnswer extends Model {
  static String table = 'formulario_answer';

  FormularioAnswer({
    id,
    this.instanceId,
    this.formId,
    this.respondentId,
    this.questionId,
    this.response,
    this.fechaCreacion,
    this.enviado,
  }) : super(id);

  String? instanceId;
  int? formId;
  String? respondentId;
  int? questionId;
  String? response;
  String? fechaCreacion;
  String? enviado;

  FormularioAnswer copyWith({
    int? id,
    String? instanceId,
    int? formId,
    String? respondentId,
    int? questionId,
    String? response,
    String? fechaCreacion,
    String? enviado,
  }) =>
      FormularioAnswer(
        id: id ?? this.id,
        instanceId: instanceId ?? this.instanceId,
        formId: formId ?? this.formId,
        respondentId: respondentId ?? this.respondentId,
        questionId: questionId ?? this.questionId,
        response: response ?? this.response,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        enviado: enviado ?? this.enviado,
      );

  static FormularioAnswer fromMap(Map<String, dynamic> json) {
    return FormularioAnswer(
      id: json["id"],
      instanceId: json["instanceId"],
      formId: json["formId"],
      respondentId: json["respondentId"],
      questionId: json["questionId"],
      response: json["response"],
      fechaCreacion: json["fechaCreacion"],
      enviado: json["enviado"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id,
      "instanceId": instanceId,
      "formId": formId,
      "respondentId": respondentId,
      "questionId": questionId,
      "response": response,
      "fechaCreacion": fechaCreacion,
      "enviado": enviado,
    };
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
