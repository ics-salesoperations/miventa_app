class Ambiente {
  final String tipo;
  final String descripcion;

  const Ambiente({
    id,
    required this.tipo,
    required this.descripcion,
  });

  Ambiente copyWith({
    String? tipo,
    String? descripcion,
  }) =>
      Ambiente(
        tipo: tipo ?? this.tipo,
        descripcion: descripcion ?? this.descripcion,
      );
}
