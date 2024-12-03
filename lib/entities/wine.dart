class Wine {
  final String name;
  final String image;
  final String type;
  final String country;
  final String grape;
  final double price;
  final int sizeMl;
  final int criticsScore;
  final bool available;
  final bool favourite;
  final String place;

  Wine({
    required this.name,
    required this.image,
    required this.type,
    required this.country,
    required this.grape,
    required this.price,
    required this.sizeMl,
    required this.criticsScore,
    required this.available,
    required this.favourite,
    required this.place,
  });

  factory Wine.fromJson(Map<String, dynamic> json) {
    return Wine(
      name: json['name'],
      image: json['image'],
      type: json['type'],
      country: json['country'],
      grape: json['grape'],
      price: json['price'].toDouble(),
      sizeMl: json['size_ml'],
      criticsScore: json['critics_score'],
      available: json['available'] == 1,
      favourite: json['favourite'] == 1,
      place: json['place'],
    );
  }
}
