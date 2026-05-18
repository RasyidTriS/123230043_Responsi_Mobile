import 'package:hive/hive.dart';
import 'package:latihan_responsi/models/tv_show.dart';

/// Service untuk manage favorite TV shows menggunakan Hive
class FavoriteService {
  static const String boxName = 'favorites';

  /// Initialize Hive box
  static Future<void> initFavorites() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<Map<dynamic, dynamic>>(boxName);
    }
  }

  /// Dapatkan semua favorites
  static List<TVShow> getFavorites() {
    final box = Hive.box<Map<dynamic, dynamic>>(boxName);
    return box.values.map((favorite) {
      final data = Map<String, dynamic>.from(favorite);
      return TVShow.fromHiveJson(data);
    }).toList();
  }

  /// Check apakah TV show sudah favorite
  static bool isFavorite(int showId) {
    final box = Hive.box<Map<dynamic, dynamic>>(boxName);
    return box.containsKey(showId.toString());
  }

  /// Tambah favorite
  static Future<void> addFavorite(TVShow show) async {
    final box = Hive.box<Map<dynamic, dynamic>>(boxName);
    await box.put(show.id.toString(), show.toJson());
  }

  /// Hapus favorite
  static Future<void> removeFavorite(int showId) async {
    final box = Hive.box<Map<dynamic, dynamic>>(boxName);
    await box.delete(showId.toString());
  }

  /// Hapus semua favorites
  static Future<void> clearFavorites() async {
    final box = Hive.box<Map<dynamic, dynamic>>(boxName);
    await box.clear();
  }
}
