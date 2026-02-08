import 'rating.dart';

class Destination {
  final String name;
  final String location;
  final Rating rating;
  final String about;
  final List<String> pictures;
  final bool isFavorite;
  final double price;

  const Destination({
    required this.name,
    required this.location,
    required this.rating,
    required this.about,
    required this.pictures,
    this.isFavorite = false,
    required this.price,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      name: json['name'] as String,
      location: json['location'] as String,
      rating: Rating.fromJson(json['rating'] as Map<String, dynamic>),
      about: json['about'] as String,
      pictures: (json['pictures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isFavorite: json['is_favorite'] as bool? ?? false,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'rating': rating.toJson(),
      'about': about,
      'pictures': pictures,
      'is_favorite': isFavorite,
      'price': price,
    };
  }

  Destination copyWith({
    String? name,
    String? location,
    Rating? rating,
    String? about,
    List<String>? pictures,
    bool? isFavorite,
    double? price,
  }) {
    return Destination(
      name: name ?? this.name,
      location: location ?? this.location,
      rating: rating ?? this.rating,
      about: about ?? this.about,
      pictures: pictures ?? this.pictures,
      isFavorite: isFavorite ?? this.isFavorite,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return 'Destination(name: $name, location: $location, rating: $rating, about: $about, pictures: $pictures, isFavorite: $isFavorite, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Destination &&
        other.name == name &&
        other.location == location &&
        other.rating == rating &&
        other.about == about &&
        other.pictures == pictures &&
        other.isFavorite == isFavorite &&
        other.price == price;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        location.hashCode ^
        rating.hashCode ^
        about.hashCode ^
        pictures.hashCode ^
        isFavorite.hashCode ^
        price.hashCode;
  }
}
