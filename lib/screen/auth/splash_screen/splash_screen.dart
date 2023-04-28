import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/auth/splash_screen/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset("assets/images/splash_screen_image.jpg"),
        ),
      ),
    );
  }
}
