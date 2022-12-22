import 'dart:io';
import 'dart:ui';
import 'dart:isolate';

import 'package:app_restaurant/data/api/api_service.dart';
import 'package:app_restaurant/main.dart';
import 'package:app_restaurant/utilitas/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final notificationHelper = NotificationHelper();
    final restaurantListResponse = await ApiService().topHeadlines();

    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, restaurantListResponse);
    print(restaurantListResponse);
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
