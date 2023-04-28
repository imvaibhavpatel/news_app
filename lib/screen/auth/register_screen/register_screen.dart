import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/auth/login_screen/log_in_screen.dart';
import 'package:news_app/screen/auth/register_screen/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: registerController.registerKey,
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
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: registerController.nameController,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    labelText: "Name",
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.black,
                    ),
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
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your name";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: registerController.emailController,
                  decoration: const InputDecoration(
                    hintText: " email Address",
                    labelText: "Email address",
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  cursorColor: Colors.black,
                  obscureText: registerController.isEyes.value,
                  controller: registerController.passwordController,
                  decoration: InputDecoration(
                    hintText: "Enter  password",
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
                        registerController.isEyes.value =
                            !registerController.isEyes.value;
                      },
                      icon: Icon(
                        registerController.isEyes.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your password";
                    } else if (value.length < 6) {
                      return "Password must be 6 character";
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (registerController.registerKey.currentState!
                            .validate()) {
                          registerController.userRegister();
                        }
                      },
                      child: registerController.isLoading.value == true
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.to(() => LogInScreen());
                    },
                    child: const Text(
                      "Log in",
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
