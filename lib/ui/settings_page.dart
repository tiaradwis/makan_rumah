import 'dart:io';

import 'package:app_restaurant/provider/preferences_provider.dart';
import 'package:app_restaurant/provider/scheduling_provider.dart';
import 'package:app_restaurant/ui/favorite_page.dart';
import 'package:app_restaurant/ui/search_page.dart';
import 'package:app_restaurant/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = "/setting";
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool value = true;

  @override
  void initState() {
    super.initState();
  }

  onClickedNotification(String? payload) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FavoritePage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Setting",
                    style: TextStyle(
                        color: Color.fromRGBO(237, 102, 92, 1),
                        fontSize: 30,
                        fontWeight: FontWeight.w800),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Color.fromRGBO(237, 102, 92, 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Restaurant Notification",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Enable notification",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Consumer<PreferencesProvider>(
                        builder: (context, provider, child) {
                          return Consumer<SchedulingProvider>(
                              builder: (context, scheduled, _) {
                            return Switch.adaptive(
                              value: provider.isDailyRestaurantsActive,
                              onChanged: (value) async {
                                if (Platform.isIOS) {
                                  customDialog(context);
                                } else {
                                  scheduled.scheduledRestaurant(value);
                                  provider.enableDailyRestaurants(value);
                                  late String text;
                                  late MaterialColor color;
                                  if (value == false) {
                                    text = "You deactivated notification!";
                                    color = Colors.red;
                                  } else {
                                    text = "You activated notification!";
                                    color = Colors.green;
                                  }
                                  final snackBar = SnackBar(
                                    content: Text(
                                      text,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    backgroundColor: color,
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                }
                              },
                            );
                          });
                        },
                      )
                      // Switch(
                      //   value: value,
                      //   onChanged: (bool v) {
                      //     setState(() {
                      //       value = v;
                      //     });
                      //     if (v) {
                      //       NotificationApi.showScheduledNotification(
                      //           scheduledDate: DateTime.now()
                      //               .add(const Duration(seconds: 12)),
                      //           title: 'Its time to luch!',
                      //           body:
                      //               'I think you might like this! Only for you discount up to 30%',
                      //           payload: "payload");
                      //       const snackBar = SnackBar(
                      //         content: Text(
                      //           "You activated notification!",
                      //           style: TextStyle(fontSize: 16),
                      //         ),
                      //         backgroundColor: Colors.green,
                      //       );
                      //       ScaffoldMessenger.of(context)
                      //         ..removeCurrentSnackBar()
                      //         ..showSnackBar(snackBar);
                      //     } else {}
                      //   },
                      //   activeColor: Colors.green,
                      // ),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
