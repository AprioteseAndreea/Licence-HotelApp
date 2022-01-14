class FacilityModel {
  final String cost;
  final String facility;
  final String interval;

  FacilityModel(
      {required this.cost, required this.facility, required this.interval});

  factory FacilityModel.fromJson(Map<String, dynamic> json) {
    return FacilityModel(
      cost: json['cost'],
      facility: json['facilities'],
      interval: json['interval'],
    );
  }
  Map<String, dynamic> toJson() => facilityToJson(this);
  Map<String, dynamic> facilityToJson(FacilityModel f) => <String, dynamic>{
        "cost": f.cost,
        "facilities": f.facility,
        "interval": f.interval,
      };
}
