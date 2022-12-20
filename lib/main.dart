import 'package:app_restaurant/data/database/database_helper.dart';
import 'package:app_restaurant/ui/detail_page.dart';
import 'package:app_restaurant/ui/favorite_page.dart';
import 'package:app_restaurant/ui/home_page.dart';
import 'package:app_restaurant/ui/navigation.dart';
import 'package:app_restaurant/ui/search_page.dart';
import 'package:app_restaurant/ui/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_restaurant/provider/favorite_provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DbProvider>(
            create: (_) => DbProvider(databaseHelper: DatabaseHelper()))
      ],
      child: MaterialApp(
        title: 'Restaurant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: NavigationPage.routeName,
        routes: {
          NavigationPage.routeName: (context) => const NavigationPage(),
          HomePage.routeName: (context) => const HomePage(),
          SearchPage.routeName: (context) => const SearchPage(),
          FavoritePage.routeName: (context) => const FavoritePage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String)
        },
      ),
    );
  }
}
