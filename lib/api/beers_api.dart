import 'dart:convert';

import 'package:app_beers/data_classes/beers.dart';
import 'package:http/http.dart' as http;

class BeerApi {
  static const String _baseUrl = 'https://punkapi.online/v3';
  static const String _imageBaseUrl = 'https://punkapi.online/v3/images';


  Future<List<Beer>> getBeers({int page = 1}) async {
    List<Beer> beers = [];

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/beers?page=$page'),
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

  // Helper method to generate image URL with proper formatting
  static String getImageUrl(int beerId) {
    final formattedId = beerId.toString().padLeft(3, '0');
    return '$_imageBaseUrl/$formattedId.png';
  }

}
