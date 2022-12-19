import 'dart:convert';
import 'dart:io';
import 'package:app_restaurant/widgets/no_connection.dart';
import 'package:http/http.dart' as http;
import 'package:app_restaurant/data/model/restaurant.dart';
import 'package:app_restaurant/data/model/search_restaurant.dart';
import 'package:app_restaurant/data/model/detail_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantsResult> topHeadlines() async {
    try {
      final response = await http.get(Uri.parse("${_baseUrl}list"));
      if (response.statusCode == 200) {
        return RestaurantsResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load top headlines');
      }
    } on SocketException {
      throw const NoConnection();
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantSearch> searchRestaurant(query) async {
    try {
      final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
      if (response.statusCode == 200) {
        return RestaurantSearch.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load top headlines");
      }
    } on SocketException {
      throw const NoConnection();
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailRestaurant> detailRestaurant(id, http.Client client) async {
    try {
      final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
      if (response.statusCode == 200) {
        return DetailRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load top headlines");
      }
    } on SocketException {
      throw const NoConnection();
    } catch (e) {
      rethrow;
    }
  }
}
