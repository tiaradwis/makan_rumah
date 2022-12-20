import 'package:app_restaurant/data/model/detail_restaurant.dart';
import 'package:app_restaurant/provider/favorite_provider.dart';
import 'package:app_restaurant/ui/detail_page.dart';
import 'package:app_restaurant/utilitas/result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = "/favorite";
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 102, 92, 1),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Favorited",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
            _buildList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<DbProvider>(builder: (context, provider, child) {
      if (provider.state == ResultState.hasData) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: provider.favorites.length,
          itemBuilder: (context, index) {
            return _restaurantItem(context, provider.favorites[index]);
          },
        );
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.do_not_disturb_outlined,
                size: 75,
                color: Colors.black12,
              ),
              const SizedBox(height: 7),
              Text(
                'Tidak ada daftar favorite',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        );
      }
    });
  }

  Widget _restaurantItem(BuildContext context, RestaurantFavorite restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant.id);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Image.network(
                    "https://restaurant-api.dicoding.dev/images/medium/" +
                        restaurant.pictureId!,
                    width: 100,
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name!,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        restaurant.city!,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 74, 74, 74),
                            fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        (restaurant.rating).toString(),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 74, 74, 74),
                            fontSize: 12),
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
