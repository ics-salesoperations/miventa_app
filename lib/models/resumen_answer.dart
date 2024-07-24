import 'package:miventa_app/models/model.dart';

class ResumenAnswer extends Model {
  ResumenAnswer({
    id,
    this.instanceId,
    this.formId,
    this.fechaCreacion,
    this.enviado,
    this.formName,
    this.formDescription,
  }) : super(id);

  String? instanceId;
  int? formId;
  String? fechaCreacion;
  String? enviado;
  String? formName;
  String? formDescription;

  ResumenAnswer copyWith({
    String? instanceId,
    int? formId,
    String? fechaCreacion,
    String? enviado,
    String? formName,
    String? formDescription,
  }) =>
      ResumenAnswer(
        instanceId: instanceId ?? this.instanceId,
        formId: formId ?? this.formId,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        enviado: enviado ?? this.enviado,
        formName: formName ?? this.formName,
        formDescription: formDescription ?? this.formDescription,
      );

  factory ResumenAnswer.fromMap(Map<String, dynamic> json) => ResumenAnswer(
        id: json["id"],
        instanceId: json["instanceId"],
        formId: json["formId"],
        fechaCreacion: json["fechaCreacion"],
        enviado: json["enviado"],
        formName: json["formName"],
        formDescription: json["formDescription"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "instanceId": instanceId,
        "formId": formId,
        "fechaCreacion": fechaCreacion,
        "enviado": enviado,
        "formName": formName,
        "formDescription": formDescription,
      };
}
