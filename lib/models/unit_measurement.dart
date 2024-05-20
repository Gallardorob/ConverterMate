class UnitMesurements {
  final String measure;
  final String fromAbbr;
  final String fromPlural;
  final String toAbbr;
  final String toPlural;
  final String result;
  final String value;

  UnitMesurements({
    this.measure,
    this.fromAbbr,
    this.fromPlural,
    this.toAbbr,
    this.toPlural,
    this.value,
    this.result,
  });

  factory UnitMesurements.fromJson(dynamic json) {
    return UnitMesurements(
      measure: json['measure'] as String,
      fromAbbr: json['from']['abbr'] as String,
      fromPlural: json['from']['plural'] as String,
      toAbbr: json['to']['abbr'] as String,
      toPlural: json['to']['plural'] as String,
      value: json['value'].toString(),
      result: json['result'] as String,
    );
  }

  factory UnitMesurements.fromListJson(dynamic json) {
    return UnitMesurements(
      measure: json['measure'] as String,
      fromAbbr: json['from']['abbr'] as String,
      fromPlural: json['from']['plural'] as String,
      toAbbr: json['to']['abbr'] as String,
      toPlural: json['to']['plural'] as String,
      value: json['value'].toString(),
      result: json['result'] as String,
    );
  }

  @override
  String toString() {
    return '{$value}';
  }
}
