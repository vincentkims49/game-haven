class Game {
  final int? id;
  final String? slug;
  final String name;
  final String? released;
  final bool? tba;
  final String backgroundImage;
  final double? rating;
  final int? ratingTop;
  final List<Map<String, dynamic>>? ratings;
  final int? ratingsCount;
  final int? reviewsTextCount;
  final int? added;
  final Map<String, dynamic>? addedByStatus;
  final int? metacritic;
  final int? playtime;
  final int? suggestionsCount;
  final String? updated;
  final dynamic userGame;
  final int? reviewsCount;
  final String? saturatedColor;
  final String? dominantColor;
  final List<Map<String, dynamic>>? platforms;
  final List<Map<String, dynamic>>? parentPlatforms;
  final List<Map<String, dynamic>>? genres;
  final List<Map<String, dynamic>>? stores;
  final dynamic clip;
  final List<Map<String, dynamic>>? tags; // Updated this line
  final Map<String, dynamic>? esrbRating;
  final List<Map<String, dynamic>>? shortScreenshots;

  Game({
    this.id,
    this.slug,
    required this.name,
    this.released,
    this.tba,
    required this.backgroundImage,
    this.rating,
    this.ratingTop,
    this.ratings,
    this.ratingsCount,
    this.reviewsTextCount,
    this.added,
    this.addedByStatus,
    this.metacritic,
    this.playtime,
    this.suggestionsCount,
    this.updated,
    this.userGame,
    this.reviewsCount,
    this.saturatedColor,
    this.dominantColor,
    this.platforms,
    this.parentPlatforms,
    this.genres,
    this.stores,
    this.clip,
    this.tags,
    this.esrbRating,
    this.shortScreenshots,
  });

  factory Game.fromJson(Map<String, dynamic>? json) {
    return Game(
      id: json?['id'],
      slug: json?['slug'],
      name: json?['name'],
      released: json?['released'],
      tba: json?['tba'],
      backgroundImage: json?['background_image'],
      rating: json?['rating']?.toDouble(),
      ratingTop: json?['rating_top'],
      ratings: List<Map<String, dynamic>>.from(json?['ratings'] ?? []),
      ratingsCount: json?['ratings_count'],
      reviewsTextCount: json?['reviews_text_count'],
      added: json?['added'],
      addedByStatus: Map<String, dynamic>.from(json?['added_by_status'] ?? {}),
      metacritic: json?['metacritic'],
      playtime: json?['playtime'],
      suggestionsCount: json?['suggestions_count'],
      updated: json?['updated'],
      userGame: json?['user_game'],
      reviewsCount: json?['reviews_count'],
      saturatedColor: json?['saturated_color'],
      dominantColor: json?['dominant_color'],
      platforms: List<Map<String, dynamic>>.from(json?['platforms'] ?? []),
      parentPlatforms: List<Map<String, dynamic>>.from(json?['parent_platforms'] ?? []),
      genres: List<Map<String, dynamic>>.from(json?['genres'] ?? []),
      stores: List<Map<String, dynamic>>.from(json?['stores'] ?? []),
      clip: json?['clip'],
      tags: List<Map<String, dynamic>>.from(json?['tags'] ?? []), // Updated this line
      esrbRating: Map<String, dynamic>.from(json?['esrb_rating'] ?? {}),
      shortScreenshots: List<Map<String, dynamic>>.from(json?['short_screenshots'] ?? []),
    );
  }
}
