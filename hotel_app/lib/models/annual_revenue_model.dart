class AnnualRModel {
  final String year;
  final int revenue;
  final String color;
  AnnualRModel(
      {required this.year, required this.revenue, required this.color});

  factory AnnualRModel.fromJson(Map<String, dynamic> json) {
    return AnnualRModel(
        year: json['year'], revenue: json['revenue'], color: json['color']);
  }

  Map<String, dynamic> toJson() => facilityToJson(this);
  Map<String, dynamic> facilityToJson(AnnualRModel f) =>
      <String, dynamic>{"year": f.year, "revenue": f.revenue, "color": f.color};
}
