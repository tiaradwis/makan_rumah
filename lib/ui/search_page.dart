import 'package:app_restaurant/data/api/api_service.dart';
import 'package:app_restaurant/provider/restaurantSearch_provider.dart';
import 'package:app_restaurant/widgets/search_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = "/search?q=query";
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String resultSearch = "";
  TextEditingController controllerTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
        create: (_) => RestaurantSearchProvider(apiService: ApiService()),
        child: Consumer<RestaurantSearchProvider>(
          builder: (context, state, _) {
            return Scaffold(
              backgroundColor: const Color.fromRGBO(237, 102, 92, 1),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Search",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: TextField(
                          controller: controllerTextField,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Search",
                            prefixIcon: const Icon(Icons.search),
                            prefixIconColor: Colors.white,
                          ),
                          onChanged: (String query) {
                            if (query.isNotEmpty) {
                              setState(() {
                                resultSearch = query;
                              });

                              state.searchRestaurant(resultSearch);
                            }
                          },
                        ),
                      ),
                      (resultSearch.isEmpty)
                          ? Center(
                              child: Container(
                                  margin: const EdgeInsets.only(top: 60.0),
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.search,
                                        size: 100.0,
                                        color: Colors.white10,
                                      ),
                                      Text(
                                        "Find Your \nFav Restaurant",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white10,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  )),
                            )
                          : Consumer<RestaurantSearchProvider>(
                              builder: (context, state, _) {
                                if (state.state == SearchState.loading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state.state == SearchState.hasData) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.search.restaurants.length,
                                    itemBuilder: (context, index) {
                                      var restaurantResultSearch =
                                          state.search.restaurants[index];
                                      return SearchCard(
                                        restaurantSearch:
                                            restaurantResultSearch,
                                      );
                                    },
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
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
