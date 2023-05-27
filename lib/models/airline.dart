class Airline {
  String masanbay;

  String tinh;

  Airline({required this.masanbay, required this.tinh});

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(
      masanbay: json['masanbay'],
      tinh: json['tinh'],
    );
  }
}
