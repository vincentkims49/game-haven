// game_details_model.dart
class GameSpecificDetails {
  final String website;
  final String name;
  final String description;

  final int metacritic;
  final String released;
  final double rating;
  final List<PlatformDetails> platforms;

  // Constructor
  GameSpecificDetails({
    required this.website,
    required this.name,
    required this.metacritic,
    required this.released,
    required this.rating,
    required this.platforms,
    required this.description,
  });

  factory GameSpecificDetails.fromJson(Map<String, dynamic> json) {
    return GameSpecificDetails(
      name: json['name'] ?? '',
      description: json['description_raw'] ?? '',
      metacritic: json['metacritic'] ?? 0,
      released: json['released'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      platforms: (json['platforms'] as List<dynamic>?)
              ?.map((platform) => PlatformDetails.fromJson(platform))
              .toList() ??
          [],
      website: json['website'] ?? '',
    );
  }
}

class PlatformDetails {
  final String name;

  // Constructor
  PlatformDetails({
    required this.name,
  });

  // Factory method to create a PlatformDetails instance from JSON
  factory PlatformDetails.fromJson(Map<String, dynamic> json) {
    return PlatformDetails(
      name: json['platform']['name'] ?? '',
    );
  }
}
