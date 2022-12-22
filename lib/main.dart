import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_restaurant/data/database/database_helper.dart';
import 'package:app_restaurant/provider/preferences_provider.dart';
import 'package:app_restaurant/provider/scheduling_provider.dart';
import 'package:app_restaurant/ui/detail_page.dart';
import 'package:app_restaurant/ui/favorite_page.dart';
import 'package:app_restaurant/ui/home_page.dart';
import 'package:app_restaurant/ui/navigation.dart';
import 'package:app_restaurant/ui/search_page.dart';
import 'package:app_restaurant/ui/settings_page.dart';
import 'package:app_restaurant/utilitas/background_service.dart';
import 'package:app_restaurant/utilitas/notification_helper.dart';
import 'package:app_restaurant/utilitas/preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:app_restaurant/provider/favorite_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  final BackgroundService service = BackgroundService();
  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

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
            create: (_) => DbProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
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
