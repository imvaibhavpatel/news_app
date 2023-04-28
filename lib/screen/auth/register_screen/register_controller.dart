import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/auth/login_screen/log_in_screen.dart';
import 'package:news_app/utils/toast.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isEyes = false.obs;
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  userRegister() {
    isLoading.value = true;
    auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      FirebaseFirestore.instance
          .collection("userRegister")
          .doc(value.user!.uid)
          .set({
        "name": nameController.text.toString(),
        "email": emailController.text.toString(),
        "password": passwordController.text.toString(),
      });
      isLoading.value = false;
      Get.to(() => LogInScreen());
      toast(
        message: "Register successfully",
        colors: Colors.black,
      );
      nameController.clear();
      emailController.clear();
      passwordController.clear();
    }).onError((FirebaseAuthException error, stackTrace) {
      isLoading.value = false;
      toast(
        message: error.message.toString(),
        colors: Colors.red,
      );
    });
  }
}
