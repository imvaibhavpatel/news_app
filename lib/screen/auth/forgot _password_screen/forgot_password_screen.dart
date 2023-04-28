import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/auth/forgot%20_password_screen/password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final ForgotPassController passwordController =
      Get.put(ForgotPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: passwordController.passwordKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 50),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(right: 25),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    "Forgot password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  "Enter the email associated with your account and we’ll send an email with instructions to forgot password.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: passwordController.emailController,
                decoration: const InputDecoration(
                  hintText: "Enter email Address",
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter email address";
                  } else if (!GetUtils.isEmail(value)) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 50),
            Obx(
              () => Center(
                child: SizedBox(
                  width: Get.width * 0.90,
                  height: 47,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      if (passwordController.passwordKey.currentState!
                          .validate()) {
                        passwordController.forgotPassword();
                      }
                    },
                    child: passwordController.isLoading.value == true
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Send Instruction",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
