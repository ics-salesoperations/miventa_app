import 'package:miventa_app/models/model.dart';

class Dealer extends Model {
  Dealer({
    id,
    required this.idDealer,
    required this.nombreDealer,
  }) : super(id);

  String idDealer;
  String nombreDealer;

  factory Dealer.fromJson(Map<String, dynamic> json) => Dealer(
        idDealer: json["idDealer"].toString(),
        nombreDealer: json["nombreDealer"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "idDealer": idDealer,
        "nombreDealer": nombreDealer,
      };
}
