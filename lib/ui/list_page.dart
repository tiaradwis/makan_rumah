import 'package:app_restaurant/data/api/api_service.dart';
import 'package:app_restaurant/data/model/restaurant.dart';
import 'package:app_restaurant/provider/restaurant_provider.dart';
import 'package:app_restaurant/utilitas/result.dart';
import 'package:app_restaurant/widgets/custom_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _HomePageState();
}

class _HomePageState extends State<ListPage> {
  late Future<RestaurantsResult> _restaurant;

  @override
  void initState() {
    super.initState();
    _restaurant = ApiService().topHeadlines();
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: ((context, index) {
              var restaurant = state.result.restaurants[index];
              return CustomList(restaurant: restaurant);
            }),
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(child: Text(state.message)),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(child: Text(state.message)),
          );
        } else {
          return Center(
            child: Material(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: _buildList(context),
    );
  }
}
