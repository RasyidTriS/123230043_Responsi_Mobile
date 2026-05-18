import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latihan_responsi/models/tv_show.dart';

/// Service untuk API TVMaze
class TVMazeService {
  static const String baseUrl = 'https://api.tvmaze.com';

  /// Fetch semua TV shows
  Future<List<TVShow>> getShows() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/shows'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((show) => TVShow.fromJson(show)).toList();
      } else {
        throw Exception('Failed to load shows');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Fetch detail TV show berdasarkan ID
  Future<TVShow> getShowDetail(int id) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/shows/$id'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return TVShow.fromJson(jsonData);
      } else {
        throw Exception('Failed to load show detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
