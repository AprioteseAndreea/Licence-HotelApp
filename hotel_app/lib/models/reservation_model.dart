class ReservationModel {
  late String checkIn;
  late String checkOut;
  late String date;
  late int price;
  late String room;
  late String user;
  late bool approved;
  late List<String> facilities = [];
  late int guests;
  late String? name;
  late String id;

  ReservationModel(
      {required this.checkIn,
      required this.checkOut,
      required this.date,
      required this.price,
      required this.room,
      required this.user,
      required this.approved,
      required this.facilities,
      required this.guests,
      required this.name,
      required this.id});

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
        checkIn: json['checkIn'],
        checkOut: json['checkOut'],
        date: json['date'],
        price: json['price'],
        room: json['room'],
        user: json['user'],
        approved: json['approved'],
        facilities: json['facilities'].cast<String>(),
        guests: json['guests'],
        name: json['name'],
        id: json['id']);
  }
  Map<String, dynamic> toJson() => roomsToJson(this);
  Map<String, dynamic> roomsToJson(ReservationModel r) => <String, dynamic>{
        "checkIn": r.checkIn,
        "checkOut": r.checkOut,
        "date": r.date,
        "price": r.price,
        "room": r.room,
        "user": r.user,
        "approved": r.approved,
        "facilities": r.facilities,
        "guests": r.guests,
        "name": r.name,
        "id": r.id
      };
}
