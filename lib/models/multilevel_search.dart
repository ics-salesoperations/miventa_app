class MultiLevelSearch {
  final String level1;
  final List<MultiLevelSearch> subLevel;
  bool isExpanded;

  MultiLevelSearch({
    this.level1 = "",
    this.subLevel = const [],
    this.isExpanded = false,
  });

  MultiLevelSearch copyWith({
    String? level1,
    List<MultiLevelSearch>? subLevel,
    bool? isExpanded,
  }) =>
      MultiLevelSearch(
        level1: level1 ?? this.level1,
        subLevel: subLevel ?? this.subLevel,
        isExpanded: isExpanded ?? this.isExpanded,
      );

  @override
  String toString() => level1;
}
