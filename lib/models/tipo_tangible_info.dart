class TipoTangibleInfo {
  final String tipo;
  final int cantidad;

  const TipoTangibleInfo({
    id,
    required this.tipo,
    this.cantidad = 0,
  });

  TipoTangibleInfo copyWith({
    String? tipo,
    int? cantidad,
  }) =>
      TipoTangibleInfo(
        tipo: tipo ?? this.tipo,
        cantidad: cantidad ?? this.cantidad,
      );


   factory TipoTangibleInfo.fromMap(Map<String, dynamic> json) =>
      TipoTangibleInfo(
        tipo: json["tipo"],
        cantidad: json["cantidad"]
      );

  Map<String, dynamic> toJson() => {
        "tipo": tipo,
        "cantidad": cantidad
      };
}



