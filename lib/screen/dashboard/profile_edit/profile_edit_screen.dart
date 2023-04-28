import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/dashboard/profile_edit/profile_edit_controller.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({Key? key}) : super(key: key);

  final ProfileEditController profileEditController =
      Get.put(ProfileEditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: profileEditController.editKey,
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
                      "Edit Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Obx(
                () => Stack(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          profileEditController.pickImage();
                        },
                        child: profileEditController.isWaiting.value
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                    radius: 53,
                                    backgroundColor: Colors.white,
                                    backgroundImage: profileEditController
                                            .imageUrl.isNotEmpty
                                        ? NetworkImage(profileEditController
                                            .imageUrl.value)
                                        : null),
                              ),
                      ),
                    ),
                    Positioned(
                      top: 75,
                      right: 150,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: profileEditController.nameController,
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
                  controller: profileEditController.emailController,
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
                        if (profileEditController.editKey.currentState!
                            .validate()) {
                          profileEditController.userEditData();
                        }
                      },
                      child: profileEditController.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Edit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
