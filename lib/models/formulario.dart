import 'package:miventa_app/models/model.dart';

class Formulario extends Model {
  static String table = 'formulario';

  Formulario({
    id,
    this.formId,
    this.formName,
    this.formDescription,
    this.questionId,
    this.questionText,
    this.idQuestionType,
    this.questionType,
    this.required,
    this.questionOrder,
    this.offeredAnswer,
    this.auto,
    this.shortText,
    this.type,
    this.subType,
    this.conditional,
    this.parentAnswer,
    this.parentQuestion,
  }) : super(id);

  int? formId;
  String? formName;
  String? formDescription;
  int? questionId;
  String? questionText;
  int? idQuestionType;
  String? questionType;
  String? required;
  int? questionOrder;
  String? offeredAnswer;
  int? auto;
  String? shortText;
  String? type;
  String? subType;
  int? conditional;
  String? parentQuestion;
  String? parentAnswer;

  Formulario copyWith({
    int? formId,
    String? formName,
    String? formDescription,
    int? questionId,
    String? questionText,
    int? idQuestionType,
    String? questionType,
    String? required,
    int? questionOrder,
    String? offeredAnswer,
    int? auto,
    String? shortText,
    String? subType,
    String? type,
    int? conditional,
    String? parentQuestion,
    String? parentAnswer,
  }) =>
      Formulario(
        formId: formId ?? this.formId,
        formName: formName ?? this.formName,
        formDescription: formDescription ?? this.formDescription,
        questionId: questionId ?? this.questionId,
        questionText: questionText ?? this.questionText,
        idQuestionType: idQuestionType ?? this.idQuestionType,
        questionType: questionType ?? this.questionType,
        required: required ?? this.required,
        questionOrder: questionOrder ?? this.questionOrder,
        offeredAnswer: offeredAnswer ?? this.offeredAnswer,
        auto: auto ?? this.auto,
        shortText: shortText ?? this.shortText,
        type: type ?? this.type,
        subType: subType ?? this.subType,
        conditional: conditional ?? this.conditional,
        parentAnswer: parentAnswer ?? this.parentAnswer,
        parentQuestion: parentQuestion ?? this.parentQuestion,
      );

  factory Formulario.fromMap(Map<String, dynamic> json) => Formulario(
        id: json["id"],
        formId: json["formId"],
        formName: json["formName"],
        formDescription: json["formDescription"],
        questionId: json["questionId"],
        questionText: json["questionText"],
        idQuestionType: json["idQuestionType"],
        questionType: json["questionType"],
        required: json["required"],
        questionOrder: json["questionOrder"],
        offeredAnswer: json["offeredAnswer"],
        auto: json["auto"],
        shortText: json["shortText"],
        type: json["type"],
        subType: json["subType"],
        conditional: json["conditional"],
        parentQuestion: json["parentQuestion"],
        parentAnswer: json["parentAnswer"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "formId": formId,
        "formName": formName,
        "formDescription": formDescription,
        "questionId": questionId,
        "questionText": questionText,
        "idQuestionType": idQuestionType,
        "questionType": questionType,
        "required": required,
        "questionOrder": questionOrder,
        "offeredAnswer": offeredAnswer,
        "auto": auto,
        "shortText": shortText,
        "type": type,
        "subType": subType,
        "conditional": conditional,
        "parentQuestion": parentQuestion,
        "parentAnswer": parentAnswer,
      };
}
