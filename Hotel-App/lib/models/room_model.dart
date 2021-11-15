class RoomModel {
  late String number;
  late String cost;
  late String maxGuests;
  late bool free;
  late bool pending;
  late String idUser;
  late String interval;
  List<String> facilities = [];

  RoomModel(
      {required this.number,
      required this.cost,
      required this.maxGuests,
      required this.free,
      required this.pending,
      required this.idUser,
      required this.interval,
      required this.facilities});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
        number: json['number'],
        cost: json['cost'],
        maxGuests: json['maxGuests'],
        free: json['free'],
        pending: json['pending'],
        idUser: json['id_user'],
        interval: json['interval'],
        facilities: json['facilities'].cast<String>());
  }
  Map<String, dynamic> toJson() => roomsToJson(this);
  Map<String, dynamic> roomsToJson(RoomModel room) => <String, dynamic>{
        "number": room.number,
        "cost": room.cost,
        "maxGuests": room.maxGuests,
        "free": room.free,
        "pending": room.pending,
        "id_user": room.idUser,
        "interval": room.interval,
        "facilities": room.facilities
      };
}
