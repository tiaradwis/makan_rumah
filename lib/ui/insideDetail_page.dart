import 'package:app_restaurant/data/model/detail_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_restaurant/provider/favorite_provider.dart';

class InsideDetailPage extends StatelessWidget {
  final Restaurant restaurantDetail;

  const InsideDetailPage({Key? key, required this.restaurantDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: const Color.fromRGBO(237, 102, 92, 1),
        title: Text(restaurantDetail.name!),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/medium/" +
                        restaurantDetail.pictureId!,
                  ),
                ),
              ),
            ],
          ),
          Consumer<DbProvider>(
            builder: (context, provider, child) {
              return FutureBuilder<bool>(
                future: provider.isFavsResto(restaurantDetail.id!),
                builder: (context, snapshot) {
                  var isFavsResto = snapshot.data ?? false;
                  return isFavsResto
                      ? IconButton(
                          onPressed: () {
                            provider.removeFavorite(restaurantDetail.id!);
                          },
                          icon: Icon(Icons.favorite),
                        )
                      : IconButton(
                          onPressed: () {
                            provider.addFavsResto(restaurantDetail);
                          },
                          icon: Icon(Icons.favorite_outline));
                },
              );
            },
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurantDetail.name!,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
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
                      restaurantDetail.city!,
                      style: const TextStyle(fontSize: 14),
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
                      (restaurantDetail.rating!).toString(),
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  restaurantDetail.description!,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Menu Makanan",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 200,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: restaurantDetail.menus!.foods
                          .map(
                            (foods) => Column(
                              children: [
                                Card(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        child: Center(
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/menuimage.jpg")),
                                        ),
                                        height: 100,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        foods.name,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Rp. 25000",
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList()),
                ),
                const Text(
                  "Menu Minuman",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 200,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: restaurantDetail.menus!.drinks
                          .map(
                            (drinks) => Column(
                              children: [
                                Card(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        child: Center(
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/menuimage.jpg")),
                                        ),
                                        height: 100,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        drinks.name,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Rp. 25000",
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList()),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
