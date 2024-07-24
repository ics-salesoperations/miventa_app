class Municipio {
  final String departamento;
  final String municipio;

  const Municipio({
    id,
    required this.departamento,
    required this.municipio,
  });

  Municipio copyWith({
    String? departamento,
    String? municipio,
  }) =>
      Municipio(
        departamento: departamento ?? this.departamento,
        municipio: municipio ?? this.municipio,
      );
}
