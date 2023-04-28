import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_app/screen/auth/login_screen/log_in_screen.dart';
import 'package:news_app/utils/toast.dart';

class DrawerScreenController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final box = GetStorage();

  logOut() async {
    auth.signOut().then((value) {
      Get.offAll(() => LogInScreen());
      box.erase();
    }).onError((error, stackTrace) {
      toast(message: error.toString(), colors: Colors.red);
    });
  }
}
