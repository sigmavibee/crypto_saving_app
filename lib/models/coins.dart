class Coins {
  final int id;
  final String name;
  final double price;
  final DateTime releaseDate;
  final bool available;

  Coins({
    required this.id,
    required this.name,
    required this.price,
    required this.releaseDate,
    required this.available,
  });

  factory Coins.fromJson(Map<String, dynamic> json) {
    return Coins(
      id: json['id'] as int,
      name: json['name'] as String,
      price: double.tryParse(json['price'] as String) ??
          0.0, // Convert price to double
      releaseDate: DateTime.parse(json['release_date'] as String),
      available: json['available'] as bool,
    );
  }
}
