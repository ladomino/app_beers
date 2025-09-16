import 'package:app_beers/providers/favorites_provider.dart';
import 'package:app_beers/ui/pages/beers_card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteBeers = ref.watch(favoritesProvider);

    return favoriteBeers.isEmpty
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No favorite beers yet!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Start adding beers to your favorites',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: favoriteBeers.length,
            itemBuilder: (context, index) {
              final beer = favoriteBeers[index];
              return BeerListCard(beer: beer, onTap: () {});
            },
          );
  }
}
