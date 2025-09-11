import 'package:app_beers/data_classes/beers.dart';
import 'package:app_beers/providers/beers_provider.dart';
import 'package:app_beers/shared/search_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final searchHelperProvider = ChangeNotifierProvider<SearchHelper>((ref) {
  return SearchHelper();
});


// Filtered Beers provider (for search functionality)
final filteredBeersProvider = Provider<List<Beer>>((ref) {
  final beersState = ref.watch(beersProvider);
  final searchQuery = ref.watch(searchHelperProvider).searchString;


  List<Beer> beers = beersState.beers;
  print('Before Filtered Beer lengths: ${beers.length}');

  // Apply search filter
  if (searchQuery.isNotEmpty) {
    beers = beers
        .where(
          (beer) =>
              beer.name.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  print('After Filtered Beer lengths: ${beers.length}');
  return beers;
});