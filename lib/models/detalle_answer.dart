import 'package:miventa_app/models/model.dart';

class DetalleAnswer extends Model {
  DetalleAnswer({
    id,
    this.instanceId,
    this.formId,
    this.respondentId,
    this.questionId,
    this.response,
    this.fechaCreacion,
    this.enviado,
    this.formName,
    this.formDescription,
    this.questionText,
    this.questionType,
    this.questionOrder,
  }) : super(id);

  String? instanceId;
  int? formId;
  String? respondentId;
  int? questionId;
  String? response;
  String? fechaCreacion;
  String? enviado;
  String? formName;
  String? formDescription;
  String? questionText;
  String? questionType;
  int? questionOrder;

  DetalleAnswer copyWith({
    String? instanceId,
    int? formId,
    String? respondentId,
    int? questionId,
    String? response,
    String? fechaCreacion,
    String? enviado,
    String? formName,
    String? formDescription,
    String? questionText,
    int? questionOrder,
    String? questionType,
  }) =>
      DetalleAnswer(
        instanceId: instanceId ?? this.instanceId,
        formId: formId ?? this.formId,
        respondentId: respondentId ?? this.respondentId,
        questionId: questionId ?? this.questionId,
        response: response ?? this.response,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        enviado: enviado ?? this.enviado,
        formName: formName ?? this.formName,
        formDescription: formDescription ?? this.formDescription,
        questionText: questionText ?? this.questionText,
        questionType: questionType ?? this.questionType,
        questionOrder: questionOrder ?? this.questionOrder,
      );

  factory DetalleAnswer.fromMap(Map<String, dynamic> json) => DetalleAnswer(
        instanceId: json["instanceId"],
        formId: json["formId"],
        respondentId: json["respondentId"],
        questionId: json["questionId"],
        response: json["response"],
        fechaCreacion: json["fechaCreacion"],
        enviado: json["enviado"],
        formName: json["formName"],
        formDescription: json["formDescription"],
        questionText: json["questionText"],
        questionType: json["questionType"],
        questionOrder: json["questionOrder"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "instanceId": instanceId,
        "formId": formId,
        "respondentId": respondentId,
        "questionId": questionId,
        "response": response,
        "fechaCreacion": fechaCreacion,
        "enviado": enviado,
        "formName": formName,
        "formDescription": formDescription,
        "questionText": questionText,
        "questionType": questionType,
        "questionOrder": questionOrder,
      };
}
