import 'package:app_beers/data_classes/beers.dart';
import 'package:flutter_riverpod/legacy.dart';


// Provider for managing favorite beers
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Beer>>((
  ref,
) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<Beer>> {
  FavoritesNotifier() : super([]);

  void addToFavorites(Beer beer) {
    if (!state.any((b) => b.id == beer.id)) {
      state = [...state, beer];
    }
  }

  void removeFromFavorites(Beer beer) {
    state = state.where((b) => b.id != beer.id).toList();
  }

  bool isFavorite(Beer beer) {
    return state.any((b) => b.id == beer.id);
  }

  void toggleFavorite(Beer beer) {
    if (isFavorite(beer)) {
      removeFromFavorites(beer);
    } else {
      addToFavorites(beer);
    }
  }
}
