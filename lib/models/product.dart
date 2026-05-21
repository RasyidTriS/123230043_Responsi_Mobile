class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int ratingCount;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final ratingJson = json['rating'];
    final ratingMap = ratingJson is Map<String, dynamic> ? ratingJson : {};

    return Product(
      id: _toInt(json['id']),
      title: _toText(json['title'], fallback: 'Produk tanpa nama'),
      price: _toDouble(json['price']),
      description: _toText(json['description']),
      category: _toText(json['category']),
      image: _toText(json['image']),
      rating: _toDouble(ratingMap['rate']),
      ratingCount: _toInt(ratingMap['count']),
    );
  }

  factory Product.fromHive(Map<dynamic, dynamic> map) {
    return Product.fromJson(Map<String, dynamic>.from(map));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': {'rate': rating, 'count': ratingCount},
    };
  }

  static String _toText(dynamic value, {String fallback = ''}) {
    final text = value?.toString().trim() ?? '';
    return text.isEmpty ? fallback : text;
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
