class RoomStatisticsModel {
  late String status;
  late int value;
  late String color;

  RoomStatisticsModel(
      {required this.status, required this.value, required this.color});

  factory RoomStatisticsModel.fromJson(Map<String, dynamic> json) {
    return RoomStatisticsModel(
        status: json['status'], value: json['value'], color: json['color']);
  }

  Map<String, dynamic> toJson() => roomSToJson(this);
  Map<String, dynamic> roomSToJson(RoomStatisticsModel f) =>
      <String, dynamic>{"status": f.status, "value": f.value, "color": f.color};
}
