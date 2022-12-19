import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_restaurant/data/api/api_service.dart';
import 'package:app_restaurant/data/model/search_restaurant.dart';

enum SearchState { loading, hasData, noData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  String query;

  RestaurantSearchProvider({
    required this.apiService,
    this.query = '',
  }) {
    _searchRestaurant(query);
  }

  late RestaurantSearch _restaurantSearch;
  late SearchState _state;
  String _message = '';

  RestaurantSearch get search => _restaurantSearch;
  SearchState get state => _state;
  String get message => _message;

  searchRestaurant(String newValue) {
    query = newValue;
    _searchRestaurant(query);
    notifyListeners();
  }

  Future _searchRestaurant(value) async {
    try {
      _state = SearchState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(value);
      if (restaurant.restaurants.isEmpty) {
        _state = SearchState.noData;
        notifyListeners();
        return _message = 'Not found:( Lets try other restaurant!';
      } else {
        _state = SearchState.hasData;
        notifyListeners();
        return _restaurantSearch = restaurant;
      }
    } catch (e) {
      _state = SearchState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
