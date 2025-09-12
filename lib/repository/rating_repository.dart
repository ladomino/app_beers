import 'package:shared_preferences/shared_preferences.dart';

class RatingRepository {
  static const _ratingPrefix = 'beer_rating_';

  Future<void> saveRating(int beerId, double rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('$_ratingPrefix$beerId', rating);
  }

  Future<double?> getRating(int beerId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('$_ratingPrefix$beerId');
  }
}
