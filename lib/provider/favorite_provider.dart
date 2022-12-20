import 'package:app_restaurant/data/model/detail_restaurant.dart';
import 'package:app_restaurant/data/database/database_helper.dart';
import 'package:app_restaurant/utilitas/result.dart';
import 'package:flutter/material.dart';

class DbProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  DbProvider({required this.databaseHelper}) {
    _getFavsResto();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantFavorite> _resto = [];
  List<RestaurantFavorite> get favorites => _resto;

  void _getFavsResto() async {
    _resto = await databaseHelper.getFavorite();
    if (_resto.length > 0) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Daftar favorite masih kosong';
    }
    notifyListeners();
  }

  void addFavsResto(RestaurantFavorite restaurant) async {
    try {
      print("method addfavsresto started");
      await databaseHelper.addFavorite(restaurant);
      _getFavsResto();
      print("method addfavsresto done");
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error add: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavsResto(String id) async {
    final favsResto = await databaseHelper.getFavoriteById(id);
    return favsResto.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      _getFavsResto();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
