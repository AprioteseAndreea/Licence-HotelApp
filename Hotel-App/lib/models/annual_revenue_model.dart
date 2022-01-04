class AnnualRModel {
  final String year;
  final int revenue;

  AnnualRModel({required this.year, required this.revenue});

  factory AnnualRModel.fromJson(Map<String, dynamic> json) {
    return AnnualRModel(
      year: json['year'],
      revenue: json['revenue'],
    );
  }

  Map<String, dynamic> toJson() => facilityToJson(this);
  Map<String, dynamic> facilityToJson(AnnualRModel f) => <String, dynamic>{
        "year": f.year,
        "revenue": f.revenue,
      };
}
