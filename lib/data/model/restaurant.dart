class RestaurantsResult {
  final String message;
  final int count;
  final List<Restaurants> restaurants;

  RestaurantsResult({
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurants>.from((json["restaurants"] as List)
            .map((x) => Restaurants.fromJson(x))
            .where((restaurant) =>
                restaurant.id != null &&
                restaurant.name != null &&
                restaurant.description != null &&
                restaurant.pictureId != null &&
                restaurant.city != null &&
                restaurant.rating != null)),
      );
}

class Restaurants {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;

  Restaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );
}
