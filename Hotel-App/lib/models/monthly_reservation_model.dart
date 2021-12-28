class MonthlyRModel {
  final String month;
  final int numberOfR;

  MonthlyRModel({required this.month, required this.numberOfR});

  factory MonthlyRModel.fromJson(Map<String, dynamic> json) {
    return MonthlyRModel(
      month: json['month'],
      numberOfR: json['numberOfR'],
    );
  }
  Map<String, dynamic> toJson() => facilityToJson(this);
  Map<String, dynamic> facilityToJson(MonthlyRModel f) => <String, dynamic>{
        "month": f.month,
        "numberOfR": f.numberOfR,
      };
}
