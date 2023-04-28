import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/screen/dashboard/home_screen/home_screen.dart';
import 'package:news_app/utils/toast.dart';

class CreateNewsController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController disController = TextEditingController();
  ImagePicker picker = ImagePicker();

  RxList category = [
    "Sports",
    "Business",
    "Technology",
    "Health",
    "Life style",
    "Auto",
  ].obs;
  RxString selectedValue = "".obs;
  RxString imagePath = "".obs;
  RxString imageUrl = "".obs;
  RxBool isLoading = false.obs;
  RxBool isUpload = false.obs;
  RxBool saveChanges = false.obs;
  Rx<News> newsData = News(
    title: "",
    description: "",
    category: "",
    image: "",
    id: "",
    updated: DateTime.now().millisecondsSinceEpoch,
  ).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (Get.arguments.toString() != "null") {
      saveChanges.value = Get.arguments[0];
      newsData.value = Get.arguments[1];
      imageUrl.value = newsData.value.image;
      titleController.text = newsData.value.title;
      disController.text = newsData.value.description;
      selectedValue.value = newsData.value.category;
    }
  }

  Future getImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      isLoading.value = true;
      imagePath.value = image.path.toString();

      final path = 'files/${imagePath.value}';
      FirebaseStorage.instance
          .ref()
          .child(path)
          .putFile(File(imagePath.value))
          .then((p0) async {
        isLoading.value = false;
        var downloadUrl = await p0.ref.getDownloadURL();
        imageUrl.value = downloadUrl.toString();
        isLoading.value = false;
      });
    } else {
      isLoading.value = false;
    }
  }

  createNews() async {
    isUpload.value = true;
    await FirebaseFirestore.instance.collection("news").add({
      "image": imageUrl.value,
      "title": titleController.text.toString(),
      "Description": disController.text.toString(),
      "category": selectedValue.toString(),
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "createdAt": DateTime.now().millisecondsSinceEpoch
    });
    toast(message: "News created", colors: Colors.black);
    Get.back();
  }

  saveNewsChanges() async {
    isUpload.value = true;
    await FirebaseFirestore.instance
        .collection("news")
        .doc(newsData.value.id)
        .update({
      "image": imageUrl.value,
      "title": titleController.text.toString(),
      "Description": disController.text.toString(),
      "category": selectedValue.toString(),
      "createdAt": DateTime.now().millisecondsSinceEpoch
    });
    Get.back();
  }
}

class NewsDetails {
  final String image;
  final String title;
  final String description;
  final String category;

  NewsDetails({
    required this.image,
    required this.title,
    required this.description,
    required this.category,
  });
}
