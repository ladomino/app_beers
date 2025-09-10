import 'dart:convert';

import 'package:app_beers/data_classes/beers.dart';
import 'package:http/http.dart' as http;

class BeerApi {

  Future<List<Beer>> getBeers({int page = 1}) async {
    List<Beer> beers = [];

    try {
      final response = await http.get(
        Uri.parse('https://punkapi.online/v3/beers?page=$page'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        if (jsonData.isEmpty) {
          return beers;
        }
        beers = jsonData.map((json) => Beer.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load beers: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching beers: $e');
    }
    return beers;
  }
}
