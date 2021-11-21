class ReservationModel {
  late String checkIn;
  late String checkOut;
  late int price;
  late String room;
  late String user;
  late bool approved;
  late List<String> facilities = [];

  ReservationModel(
      {required this.checkIn,
      required this.checkOut,
      required this.price,
      required this.room,
      required this.user,
      required this.approved,
      required this.facilities});

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
        checkIn: json['checkIn'],
        checkOut: json['checkOut'],
        price: json['price'],
        room: json['room'],
        user: json['user'],
        approved: json['approved'],
        facilities: json['facilities'].cast<String>());
  }
  Map<String, dynamic> toJson() => roomsToJson(this);
  Map<String, dynamic> roomsToJson(ReservationModel r) => <String, dynamic>{
        "checkIn": r.checkIn,
        "checkOut": r.checkOut,
        "price": r.price,
        "room": r.room,
        "user": r.user,
        "approved": r.approved,
        "facilities": r.facilities
      };
}
