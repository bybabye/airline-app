class Flight {
  String id;
  DateTime departureTime;
  int availableSeats;
  String price;
  DateTime arrivalTime;
  String departureAirport;
  String departureProvince;
  String arrivalAirport;
  String arrivalProvince;
  String departureAirportId;
  String arrivalAirportId;
  Flight(
      {required this.id,
      required this.departureTime,
      required this.availableSeats,
      required this.price,
      required this.arrivalTime,
      required this.departureAirport,
      required this.departureProvince,
      required this.arrivalAirport,
      required this.arrivalProvince,
      required this.departureAirportId,
      required this.arrivalAirportId});

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
      id: json["id"],
      departureTime: DateTime.parse(json["departure_time"]),
      availableSeats: json["available_seats"],
      price: json["price"],
      arrivalTime: DateTime.parse(json["arrival_time"]),
      departureAirport: json["departure_airport"],
      departureProvince: json["departure_province"],
      arrivalAirport: json["arrival_airport"],
      arrivalProvince: json["arrival_province"],
      departureAirportId: json['departure_airport_id'],
      arrivalAirportId: json['arrival_airport_id']);
}
