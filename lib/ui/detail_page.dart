import 'package:app_restaurant/ui/insideDetail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_restaurant/data/api/api_service.dart';
import 'package:app_restaurant/provider/restaurantDetail_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final String id;

  const RestaurantDetailPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (context) => RestaurantDetailProvider(
        restaurantAPI: ApiService(),
        id: id,
      ),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == DetailState.loading) {
            return Container(
              color: Colors.brown.shade100,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state.state == DetailState.hasData) {
            return Scaffold(
              body: RefreshIndicator(
                onRefresh: () => Navigator.pushReplacementNamed(
                    context, RestaurantDetailPage.routeName,
                    arguments: state.detail.restaurant.id),
                child: LayoutBuilder(builder: (context, constraints) {
                  return InsideDetailPage(
                      restaurantDetail: state.detail.restaurant);
                }),
              ),
            );
          } else if (state.state == DetailState.noData) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
