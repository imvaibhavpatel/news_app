import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/auth/splash_screen/splash_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_app/screen/dashboard/home_screen/home_screen.dart';
import 'package:news_app/utils/notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await GetStorage.init();
  NotificationServices();
  runApp(const MyApp());
}

@pragma("vm:entry-point")
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // home: SplashScreen(),
      home: FirebaseAuth.instance.currentUser != null
          ? HomeScreen()
          : SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
