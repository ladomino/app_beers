import 'package:app_beers/data_classes/beers.dart';
import 'package:flutter/material.dart';

class SearchHelper extends ChangeNotifier {
  String _searchString = '';

  String get searchString => _searchString;

  set searchString(String val) {
    if (val == _searchString) {
      return;
    }

    _searchString = val.toLowerCase();
    notifyListeners();
  }

  List<Beer> filterBeers(
    List<Beer> allBeers,
  ) {
    if (_searchString.isEmpty) {
      return allBeers;
    } else {
      return allBeers
          .where(
            (e) => e.name.toLowerCase().contains(_searchString),
          )
          .toList();
    }
  }
}
