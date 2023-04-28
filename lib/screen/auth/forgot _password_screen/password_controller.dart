import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/utils/app_color.dart';
import 'package:news_app/utils/toast.dart';

class ForgotPassController extends GetxController {
  RxBool isLoading = false.obs;
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  forgotPassword() {
    isLoading.value = true;
    auth.sendPasswordResetEmail(email: emailController.text).then((value) {
      isLoading.value = false;
      emailController.clear();
      toast(message: "Check your Email", colors: AppColors.red);
    });
  }
}
