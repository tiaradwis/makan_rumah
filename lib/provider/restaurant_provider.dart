import 'dart:async';
import 'package:app_restaurant/utilitas/result.dart';
import 'package:app_restaurant/data/api/api_service.dart';
import 'package:app_restaurant/data/model/restaurant.dart';
import 'package:flutter/cupertino.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantsResult _restaurantsResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantsResult get result => _restaurantsResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.topHeadlines();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
