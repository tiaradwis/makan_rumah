import 'dart:io';

import 'package:app_restaurant/widgets/no_connection.dart';
import 'package:flutter/material.dart';
import 'package:app_restaurant/data/api/api_service.dart';
import 'package:app_restaurant/data/model/detail_restaurant.dart';
import 'package:http/http.dart' as http;

enum DetailState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService restaurantAPI;

  RestaurantDetailProvider({
    required this.restaurantAPI,
    required String id,
  }) {
    _fetchAllRestaurantDetail(id);
  }

  late DetailRestaurant _detailRestaurant;
  late DetailState _state;
  String _message = '';

  DetailRestaurant get detail => _detailRestaurant;
  DetailState get state => _state;
  String get message => _message;

  Future _fetchAllRestaurantDetail(id) async {
    try {
      _state = DetailState.loading;
      notifyListeners();
      final restaurant =
          await restaurantAPI.detailRestaurant(id, http.Client());
      if (restaurant.restaurant.toJson().isEmpty) {
        _state = DetailState.noData;
        notifyListeners();
        return _message = 'Tidak ada data';
      } else {
        _state = DetailState.hasData;
        notifyListeners();
        return _detailRestaurant = restaurant;
      }
    } catch (e) {
      _state = DetailState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
