import 'dart:async';
import 'package:get/get.dart';
import 'package:news_app/screen/auth/login_screen/log_in_screen.dart';
import 'package:news_app/utils/notification_services.dart';

class SplashController extends GetxController {
  NotificationServices notificationServices = NotificationServices();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Timer(
      const Duration(seconds: 4),
      () => Get.to(
        () => LogInScreen(),
      ),
    );
  }
}
