import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latihan_responsi/models/tv_show.dart';
import 'package:latihan_responsi/services/favorite_service.dart';
import 'package:latihan_responsi/widgets/custom_widgets.dart';

/// Halaman Favorite
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  /// Handle remove favorite
  void _removeFavorite(TVShow show) async {
    try {
      await FavoriteService.removeFavorite(show.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${show.name} dihapus dari favorit'),
            backgroundColor: appRed,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: appRed),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 18, 16, 14),
              child: Center(
                child: Text(
                  'Daftar Favorit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Box<Map<dynamic, dynamic>>>(
                valueListenable: Hive.box<Map<dynamic, dynamic>>(
                  FavoriteService.boxName,
                ).listenable(),
                builder: (context, box, _) {
                  final favorites = box.values.map((favorite) {
                    final data = Map<String, dynamic>.from(favorite);
                    return TVShow.fromHiveJson(data);
                  }).toList();

                  if (favorites.isEmpty) {
                    return const EmptyStateWidget(
                      title: 'Belum ada favorit',
                      subtitle: 'Tambahkan film dari halaman detail',
                      icon: Icons.favorite_border,
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 2, 16, 18),
                    itemCount: favorites.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    itemBuilder: (context, index) {
                      final show = favorites[index];
                      return _FavoriteTile(
                        show: show,
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pushNamed('/detail', arguments: show.id);
                        },
                        onRemove: () => _removeFavorite(show),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  final TVShow show;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _FavoriteTile({
    required this.show,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: appCard,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                width: 78,
                height: 104,
                child: PosterImage(imageUrl: show.image, borderRadius: 12),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      show.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RatingLabel(rating: show.rating, fontSize: 13),
                  ],
                ),
              ),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline, color: appRed),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
