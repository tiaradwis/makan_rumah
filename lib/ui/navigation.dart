import 'package:app_restaurant/ui/favorite_page.dart';
import 'package:app_restaurant/ui/home_page.dart';
import 'package:app_restaurant/ui/settings_page.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  static const routeName = "/home";
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int index = 0;
  final screens = [
    const HomePage(),
    const FavoritePage(),
    const SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Colors.white,
            labelTextStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ))),
        child: NavigationBar(
          height: 60,
          backgroundColor: const Color.fromRGBO(237, 102, 92, 1),
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: "Favorite",
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: "Setting",
            )
          ],
        ),
      ),
    );
  }
}
