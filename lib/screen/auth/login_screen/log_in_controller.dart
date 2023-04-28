import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_app/screen/dashboard/home_screen/home_screen.dart';
import 'package:news_app/utils/toast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> verifyKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool isEyes = false.obs;
  RxBool isLoading = false.obs;
  RxString verify = "".obs;
  final googleSignIN = GoogleSignIn();
  GoogleSignInAccount? user;

  GoogleSignInAccount get users => user!;

  userLogIn() {
    isLoading.value = true;
    auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      FirebaseFirestore.instance
          .collection("userRegister")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((value) {
        final box = GetStorage();
        box.write('name', value.get("name"));
        box.write("email", value.get("email"));
        box.write("image", value.get("profileImage"));
      });
      toast(message: "Login Successfully", colors: Colors.black);
      Get.offAll(() => HomeScreen());
      emailController.clear();
      passwordController.clear();
      value.user!.email.toString();
      isLoading.value = false;
    }).onError((FirebaseAuthException error, stackTrace) {
      isLoading.value = false;
      debugPrint(error.toString());
      toast(message: error.message.toString(), colors: Colors.red);
    });
  }

  verifyPhoneNumber() {
    isLoading.value = true;
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text,
        verificationCompleted: (_) {
          isLoading.value = false;
        },
        verificationFailed: (e) {
          isLoading.value = false;
          toast(message: e.toString(), colors: Colors.black);
        },
        codeSent: (String verificationId, int? token) {
          verify.value = verificationId.toString();
          isLoading.value = false;
        },
        codeAutoRetrievalTimeout: (e) {
          toast(message: e.toString(), colors: Colors.black);
          isLoading.value = false;
        });
  }

  verifyCode() async {
    isLoading.value = true;
    final credential = PhoneAuthProvider.credential(
        verificationId: verify.toString(),
        smsCode: otpController.text.toString());
    try {
      await auth.signInWithCredential(credential);
      Get.offAll(() => HomeScreen());
      toast(message: "Login Successful", colors: Colors.black);
      otpController.clear();
    } catch (e) {
      isLoading.value = false;
      toast(message: e.toString(), colors: Colors.black);
    }
  }

  Future googleLogIn() async {
    final googleUser = await googleSignIN.signIn();
    if (googleUser == null) {
      return;
    }
    user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
    Get.to(() => HomeScreen());
  }
}
