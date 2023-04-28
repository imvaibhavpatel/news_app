import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/auth/forgot%20_password_screen/forgot_password_screen.dart';
import 'package:news_app/screen/auth/login_screen/log_in_controller.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../register_screen/register_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: loginController.loginKey,
          child: Column(
            children: [
              const SizedBox(height: 130),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset(
                  "assets/images/fake_news_logo.png",
                  width: 200,
                  height: 100,
                ),
              ),
              const SizedBox(height: 35),
              const Center(
                child: Text(
                  "Log in",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: loginController.emailController,
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
              const SizedBox(height: 25),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    obscureText: loginController.isEyes.value,
                    controller: loginController.passwordController,
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      labelText: "Password",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          loginController.isEyes.value =
                              !loginController.isEyes.value;
                        },
                        icon: Icon(
                          loginController.isEyes.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter password";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    onPressed: () => Get.to(() => ForgotPasswordScreen()),
                    child: const Text(
                      "Forgot password",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Obx(
                () => SizedBox(
                  width: Get.width * 0.90,
                  height: 47,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (loginController.loginKey.currentState!.validate()) {
                        loginController.userLogIn();
                      }
                    },
                    child: loginController.isLoading.value == true
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Log In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Container(
                              height: Get.height * 0.70,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 6,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  const Text(
                                    "Login With your Phone-number",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(height: 50),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      controller:
                                          loginController.phoneNumberController,
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 2),
                                        ),
                                        border: OutlineInputBorder(),
                                        hintText: 'Phone number',
                                        helperText: "+00 000-000-0000",
                                        prefixIcon: Icon(Icons.phone_android,
                                            color: Colors.black),
                                      ),
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return 'Enter phone number';
                                        } else if (v.length < 10) {
                                          return "Enter a valid phone-number";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  const Divider(
                                    endIndent: 30,
                                    indent: 30,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 30),
                                  const Text(
                                    "Enter OTP",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: PinCodeTextField(
                                      controller: loginController.otpController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 6,
                                      pinBoxRadius: 15,
                                      pinBoxHeight: 50,
                                      pinBoxWidth: 50,
                                      defaultBorderColor:
                                          Colors.black.withOpacity(0.3),
                                      pinTextStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      errorBorderColor: Colors.red,
                                      hasTextBorderColor: Colors.black,
                                      pinTextAnimatedSwitcherTransition:
                                          ProvidedPinBoxTextAnimation
                                              .scalingTransition,
                                      pinTextAnimatedSwitcherDuration:
                                          const Duration(milliseconds: 300),
                                      onDone: (v) {
                                        loginController.verifyCode();
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                  SizedBox(
                                    width: Get.width * 0.80,
                                    height: 45,
                                    child: Obx(
                                      () => ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.black,
                                          backgroundColor: Colors.black,
                                        ),
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          if (loginController
                                              .verifyKey.currentState!
                                              .validate()) {
                                            loginController.verifyPhoneNumber();
                                          }
                                        },
                                        child: loginController
                                                    .isLoading.value ==
                                                true
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : const Text(
                                                "Get code",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.phone_android_outlined,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      loginController.googleLogIn();
                    },
                    child: Image.asset(
                      "assets/images/google_icon.png",
                      height: 30,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don`t have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.to(() => RegisterScreen());
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
