import 'package:flutter/material.dart';
import 'package:latihan_responsi/models/tv_show.dart';
import 'package:latihan_responsi/services/tvmaze_service.dart';
import 'package:latihan_responsi/widgets/custom_widgets.dart';

/// Halaman Home dengan daftar TV shows
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<TVShow>> _showsFuture;
  final TVMazeService _service = TVMazeService();

  @override
  void initState() {
    super.initState();
    _showsFuture = _service.getShows();
  }

  /// Refresh data
  Future<void> _refreshShows() async {
    setState(() {
      _showsFuture = _service.getShows();
    });
    await _showsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 18, 16, 14),
              child: Text(
                'Skuy Nonton!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshShows,
                color: appRed,
                backgroundColor: appCard,
                child: FutureBuilder<List<TVShow>>(
                  future: _showsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingIndicator();
                    }

                    if (snapshot.hasError) {
                      return ErrorMessageWidget(
                        message: 'Gagal memuat data\n${snapshot.error}',
                        onRetry: _refreshShows,
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const EmptyStateWidget(
                        title: 'Tidak ada data',
                        subtitle: 'Tidak ada TV show tersedia saat ini',
                        icon: Icons.tv_off,
                      );
                    }

                    final shows = snapshot.data!;

                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.62,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: shows.length,
                      itemBuilder: (context, index) {
                        final show = shows[index];
                        return TVShowCard(
                          imageUrl: show.image,
                          title: show.name,
                          rating: show.rating,
                          onTap: () {
                            Navigator.of(
                              context,
                            ).pushNamed('/detail', arguments: show.id);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
