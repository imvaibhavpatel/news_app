import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/utils/toast.dart';

class ProfileEditController extends GetxController {
  GlobalKey<FormState> editKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  ImagePicker picker = ImagePicker();

  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool isEyes = false.obs;
  RxBool isLoading = false.obs;
  RxBool isWaiting = false.obs;
  RxString imagePath = "".obs;
  RxString imageUrl = "".obs;
  final box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (box.read("name") != null) {
      nameController.text = box.read('name');
    }
    if (box.read("image") != null) {
      imageUrl.value = box.read("image");
    }
    if (box.read("email") != null) {
      emailController.text = box.read('email');
    }
  }

  pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      isWaiting.value = true;
      imagePath.value = image.path.toString();
      final path = 'files/${imagePath.value}';
      FirebaseStorage.instance
          .ref()
          .child(path)
          .putFile(File(imagePath.value))
          .then((p0) async {
        toast(message: "Image upload", colors: Colors.black);
        isWaiting.value = false;
        var downloadUrl = await p0.ref.getDownloadURL();
        imageUrl.value = downloadUrl.toString();
        box.write("image", imageUrl.value);
        isWaiting.value = false;
      });
    } else {
      isWaiting.value = false;
    }
  }

  userEditData() async {
    isLoading.value = true;
    await FirebaseFirestore.instance
        .collection("userRegister")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "name": nameController.text,
      "email": emailController.text,
      "profileImage": imageUrl.value
    });
    final box = GetStorage();
    box.write('name', nameController.text);
    box.write('image', imageUrl.value);
    toast(message: "Profile update", colors: Colors.black);
    isLoading.value = false;
    Get.back(result: "true");
  }
}
