import 'package:app_beers/repository/rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final ratingRepositoryProvider = Provider((ref) => RatingRepository());

// A family provider to get the rating for a specific beerId
final ratingProvider = FutureProvider.family<double?, int>((ref, beerId) async {
  final ratingRepository = ref.watch(ratingRepositoryProvider);
  return ratingRepository.getRating(beerId);
});

// A separate provider for updating ratings
final ratingNotifierProvider =
    StateNotifierProvider.family<RatingNotifier, AsyncValue<double?>, int>((
      ref,
      beerId,
    ) {
      return RatingNotifier(ref, beerId);
    });

class RatingNotifier extends StateNotifier<AsyncValue<double?>> {
  final Ref ref;
  final int beerId;

  RatingNotifier(this.ref, this.beerId) : super(const AsyncValue.loading()) {
    _loadInitialRating();
  }

  Future<void> _loadInitialRating() async {
    try {
      final ratingRepository = ref.read(ratingRepositoryProvider);
      final rating = await ratingRepository.getRating(beerId);
      state = AsyncValue.data(rating);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateRating(double newRating) async {
    final ratingRepository = ref.read(ratingRepositoryProvider);

    // Set the state to loading
    state = const AsyncValue.loading();

    // Save the new rating and update the state
    state = await AsyncValue.guard(() async {
      await ratingRepository.saveRating(beerId, newRating);
      return newRating;
    });
  }
}
