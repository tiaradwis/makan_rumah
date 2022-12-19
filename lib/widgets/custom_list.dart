import 'package:app_restaurant/data/model/restaurant.dart';
import 'package:app_restaurant/ui/detail_page.dart';
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final Restaurants restaurant;

  const CustomList({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
