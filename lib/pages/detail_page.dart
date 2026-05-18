import 'package:flutter/material.dart';
import 'package:latihan_responsi/models/tv_show.dart';
import 'package:latihan_responsi/services/favorite_service.dart';
import 'package:latihan_responsi/services/tvmaze_service.dart';
import 'package:latihan_responsi/widgets/custom_widgets.dart';

/// Halaman Detail TV Show
class DetailPage extends StatefulWidget {
  final int showId;

  const DetailPage({super.key, required this.showId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<TVShow> _showFuture;
  late bool _isFavorite;
  final TVMazeService _service = TVMazeService();

  @override
  void initState() {
    super.initState();
    _showFuture = _service.getShowDetail(widget.showId);
    _isFavorite = FavoriteService.isFavorite(widget.showId);
  }

  /// Clean HTML tags dari summary
  String _cleanHtmlTags(String? html) {
    if (html == null) return 'No overview available';

    final regex = RegExp(r'<[^>]*>');
    String cleanString = html.replaceAll(regex, '');

    cleanString = cleanString.replaceAll('&amp;', '&');
    cleanString = cleanString.replaceAll('&quot;', '"');
    cleanString = cleanString.replaceAll('&#039;', "'");
    cleanString = cleanString.replaceAll('&lt;', '<');
    cleanString = cleanString.replaceAll('&gt;', '>');

    return cleanString.trim().isEmpty
        ? 'No overview available'
        : cleanString.trim();
  }

  /// Handle favorite toggle
  void _toggleFavorite(TVShow show) async {
    final wasFavorite = FavoriteService.isFavorite(show.id);
    setState(() {
      _isFavorite = !wasFavorite;
    });

    try {
      if (wasFavorite) {
        await FavoriteService.removeFavorite(show.id);
      } else {
        await FavoriteService.addFavorite(show);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isFavorite
                  ? '${show.name} ditambahkan ke favorit'
                  : '${show.name} dihapus dari favorit',
            ),
            backgroundColor: _isFavorite ? Colors.green : appRed,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isFavorite = wasFavorite;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: appRed),
        );
      }
    }
  }

  void _showWatchSnackBar(TVShow show) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Memutar ${show.name}'),
        backgroundColor: appRed,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: const CustomAppBar(title: 'Detail', showBackButton: true),
      body: FutureBuilder<TVShow>(
        future: _showFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }

          if (snapshot.hasError) {
            return ErrorMessageWidget(
              message: 'Gagal memuat detail\n${snapshot.error}',
              onRetry: () {
                setState(() {
                  _showFuture = _service.getShowDetail(widget.showId);
                  _isFavorite = FavoriteService.isFavorite(widget.showId);
                });
              },
            );
          }

          if (!snapshot.hasData) {
            return const ErrorMessageWidget(message: 'Data tidak ditemukan');
          }

          final show = snapshot.data!;
          final genres = show.genres.isEmpty ? '-' : show.genres.join(', ');

          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: show.image != null
                        ? Image.network(
                            show.image!,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: appCard,
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                  size: 60,
                                ),
                              );
                            },
                          )
                        : Container(
                            color: appCard,
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                              size: 60,
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          show.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            RatingLabel(rating: show.rating, fontSize: 14),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                genres,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: appSecondaryText,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            Expanded(
                              child: NontonButton(
                                label: 'Nonton',
                                icon: Icons.play_arrow_rounded,
                                onPressed: () => _showWatchSnackBar(show),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 54,
                              height: 52,
                              child: Material(
                                color: appCard,
                                borderRadius: BorderRadius.circular(16),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () => _toggleFavorite(show),
                                  child: Icon(
                                    _isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: _isFavorite ? appRed : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        const Text(
                          'Overview',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _cleanHtmlTags(show.summary),
                          style: const TextStyle(
                            color: appSecondaryText,
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
