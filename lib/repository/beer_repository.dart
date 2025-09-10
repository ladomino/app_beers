import 'package:app_beers/api/beers_api.dart';
import 'package:app_beers/data_classes/beers.dart';

class BeerRepository {
  final BeerApi _api;

  BeerRepository(this._api);  

  List<Beer> beers = [];

  Future<List<Beer>> fetchBeers({int page = 1}) async {
    try {
      beers = await _api.getBeers(page: page);

      // Return API data if successful, otherwise fallback to sample data
      return beers;
    } catch (e) {
      print('Repository error: $e');

      return [];
    }
  }
}

