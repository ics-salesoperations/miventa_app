import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class FormularioResumen extends Model {
  FormularioResumen({
    id,
    this.formId,
    this.formName,
    this.formDescription,
    this.type,
    this.subType,
    this.guardado = false,
    this.enviado = false,
    this.lastDate,
  }) : super(id);

  int? formId;
  String? formName;
  String? formDescription;
  String? type;
  String? subType;
  bool? guardado;
  bool? enviado;
  DateTime? lastDate;

  FormularioResumen copyWith({
    int? formId,
    String? formName,
    String? formDescription,
    String? subType,
    String? type,
    bool? guardado,
    bool? enviado,
    DateTime? lastDate,
  }) =>
      FormularioResumen(
        formId: formId ?? this.formId,
        formName: formName ?? this.formName,
        formDescription: formDescription ?? this.formDescription,
        type: type ?? this.type,
        subType: subType ?? this.subType,
        guardado: guardado ?? this.guardado,
        enviado: enviado ?? this.enviado,
        lastDate: lastDate ?? this.lastDate,
      );

  factory FormularioResumen.fromMap(Map<String, dynamic> json) {
    final int? dateYear = json["lastDate"] == null
        ? null
        : int.parse(json["lastDate"].toString().substring(0, 4));

    final int? dateMonth = json["lastDate"] == null
        ? null
        : int.parse(json["lastDate"].toString().substring(4, 6));

    final int? dateDay = json["lastDate"] == null
        ? null
        : int.parse(json["lastDate"].toString().substring(6, 8));

    final int? dateHour = json["lastDate"] == null
        ? null
        : int.parse(json["lastDate"].toString().substring(9, 11));

    final int? dateMinute = json["lastDate"] == null
        ? null
        : int.parse(json["lastDate"].toString().substring(11, 13));

    final int? dateSecond = json["lastDate"] == null
        ? null
        : int.parse(json["lastDate"].toString().substring(13, 15));

    return FormularioResumen(
      id: json["id"],
      formId: json["formId"],
      formName: json["formName"],
      formDescription: json["formDescription"],
      type: json["type"],
      subType: json["subType"],
      lastDate: json["lastDate"] == null
          ? null
          : DateTime(
              dateYear!,
              dateMonth!,
              dateDay!,
              dateHour!,
              dateMinute!,
              dateSecond!,
            ),
      guardado: json["guardado"] ?? false,
      enviado: json["enviado"] ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "formId": formId,
        "formName": formName,
        "formDescription": formDescription,
        "type": type,
        "subType": subType,
        "lastDate": lastDate != null
            ? DateFormat('yyyyMMdd:HHmmss').format(lastDate!)
            : null,
        "guardado": guardado ?? false,
        "enviado": enviado ?? false,
      };
}
