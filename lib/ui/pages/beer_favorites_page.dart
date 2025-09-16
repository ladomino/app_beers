import 'package:app_beers/providers/favorites_provider.dart';
import 'package:app_beers/providers/search_provider.dart';
import 'package:app_beers/shared/app_router.dart';
import 'package:app_beers/ui/pages/beers_card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteBeers = ref.watch(favoritesProvider);
    final searchString = ref.watch(searchHelperProvider).searchString;
 
    // Filter favorites based on search
    final filteredBeers = searchString.isEmpty
        ? favoriteBeers
        : favoriteBeers.where((beer) =>
            beer.name.toLowerCase().contains(searchString.toLowerCase())
          ).toList();

    return filteredBeers.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                searchString.isEmpty ? Icons.favorite_border : Icons.search_off,
                size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                 searchString.isEmpty 
                    ? 'No favorite beers yet!'
                    : 'No favorites match your search',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                 searchString.isEmpty
                    ? 'Start adding beers to your favorites'
                    : 'Try a different search term',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          )
         : ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: filteredBeers.length,
            itemBuilder: (context, index) {
              final beer = filteredBeers[index];
              return BeerListCard(
                beer: beer, 
                onTap: () {
                  // Add navigation to beer detail if needed
                  AppRouter.goToBeerDetail(context, beer);
                },
              );
            },
          );
  }
}
