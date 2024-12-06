class TipoTangibleReasignacionInfo {
  final String tipo;
  final int cantidad;

  const TipoTangibleReasignacionInfo({
    id,
    required this.tipo,
    this.cantidad = 0,
  });

  TipoTangibleReasignacionInfo copyWith({
    String? tipo,
    int? cantidad,
  }) =>
      TipoTangibleReasignacionInfo(
        tipo: tipo ?? this.tipo,
        cantidad: cantidad ?? this.cantidad,
      );


   factory TipoTangibleReasignacionInfo.fromMap(Map<String, dynamic> json) =>
      TipoTangibleReasignacionInfo(
        tipo: json["tipo"],
        cantidad: json["cantidad"]
      );

  Map<String, dynamic> toJson() => {
        "tipo": tipo,
        "cantidad": cantidad
      };
}



