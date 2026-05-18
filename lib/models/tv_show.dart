/// Model untuk TV Show dari TVMaze API
double parseRating(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}

class TVShow {
  final int id;
  final String name;
  final String? image;
  final double rating;
  final String? summary;
  final List<String> genres;

  TVShow({
    required this.id,
    required this.name,
    this.image,
    this.rating = 0.0,
    this.summary,
    this.genres = const [],
  });

  /// Parse dari JSON response API
  factory TVShow.fromJson(Map<String, dynamic> json) {
    final rating = parseRating(json['rating']?['average']);

    return TVShow(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Unknown',
      image: (json['image'] as Map<String, dynamic>?)?['medium'] as String?,
      rating: rating,
      summary: json['summary'] as String?,
      genres: List<String>.from(json['genres'] as List<dynamic>? ?? []),
    );
  }

  /// Convert ke JSON untuk Hive storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': parseRating(rating),
      'summary': summary,
      'genres': genres,
    };
  }

  /// Parse dari JSON untuk restore dari Hive
  factory TVShow.fromHiveJson(Map<String, dynamic> json) {
    return TVShow(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String?,
      rating: parseRating(json['rating']),
      summary: json['summary'] as String?,
      genres: List<String>.from(json['genres'] as List<dynamic>? ?? []),
    );
  }
}
