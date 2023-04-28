import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // print("user granted provisional permission");
    } else {
      // print("user denied permission");
    }
  }

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitialization =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializationSettings =
        InitializationSettings(android: androidInitialization);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {});
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }
      showNotifications(message);
    });
  }

  Future<void> showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      "importance notification",
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "fake news description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title.toString(),
        message.notification?.body.toString(),
        notificationDetails,
      );
    });
  }

  void getToken() async {
    RxString myToken = "".obs;
    await FirebaseMessaging.instance.getToken().then((token) {
      myToken.value = token!;
    });
  }
}
