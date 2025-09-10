import 'package:app_beers/api/beers_api.dart';
import 'package:app_beers/data_classes/beers.dart';
import 'package:app_beers/repository/beer_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Provider instantiated for BeersApi
final beerApiProvider = Provider<BeerApi>((ref) {
  return BeerApi();
});

// Provider instantiated for BeerRepository
final beerRepositoryProvider = Provider<BeerRepository>((ref) {
  final api = ref.watch(beerApiProvider);

  return BeerRepository(api);
});

class BeersState {
  final List<Beer> beers;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;
  final String? error;

  const BeersState({
    required this.beers,
    required this.isLoading,
    required this.hasMore,
    required this.currentPage,
    this.error,
  });

  BeersState copyWith({
    List<Beer>? beers,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
    String? error,
  }) {
    return BeersState(
      beers: beers ?? this.beers,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      error: error ?? this.error,
    );
  }
}

class BeersNotifier extends StateNotifier<BeersState> {
  final BeerRepository _repository;

  BeersNotifier(this._repository)
    : super(
        BeersState(beers: [], isLoading: false, hasMore: true, currentPage: 1),
      ) {
    print('🏗️ BeersNotifier constructor called');

    loadBeers();
  }

  Future<void> loadBeers() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final beers = await _repository.fetchBeers(page: 1);

      state = state.copyWith(
        beers: beers,
        isLoading: false,
        hasMore: beers.isNotEmpty,
        currentPage: 1,
        error: null,
      );
    } catch (error) {
     state = state.copyWith(
        isLoading: false,
        error: error.toString(),
      );
    }
  }

  Future<void> loadMoreBeers() async {
    if (state.isLoading || !state.hasMore) {
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final nextPage = state.currentPage + 1;
      final newBeers = await _repository.fetchBeers(page: nextPage);
      
      state = state.copyWith(
        beers: [...state.beers, ...newBeers],
        isLoading: false,
        hasMore: newBeers.isNotEmpty,
        currentPage: nextPage,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: error.toString(),
      );
    }
  }

  // Add refresh
  Future<void> refresh() async {
    state = BeersState(beers: [], isLoading: false, hasMore: true, currentPage: 1);
    await loadBeers();
  }
}

final beersProvider = StateNotifierProvider<BeersNotifier, BeersState>((ref) {
  final repository = ref.read(beerRepositoryProvider);

  return BeersNotifier(repository);
});
