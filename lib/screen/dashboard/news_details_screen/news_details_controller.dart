import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/dashboard/home_screen/home_screen.dart';

class NewsDetailsController extends GetxController {

  RxBool isEdit = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;


  Rx<News> newsDetails = News(
          title: "",
          image: "",
          id: "",
          category: "",
          description: "",
          updated: 0)
      .obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    newsDetails.value = Get.arguments[0];
    isEdit.value = Get.arguments[1];
  }

  deleteNews() {
    FirebaseFirestore.instance
        .collection("news")
        .doc(newsDetails.value.id)
        .delete();
    Get.back();
  }

  Future addFavouriteNews() async {
    var currentUser = auth.currentUser;
    FirebaseFirestore.instance
        .collection("userRegister")
        .doc(currentUser!.uid)
        .collection("like")
        .doc(newsDetails.value.id)
        .set({
      "id": newsDetails.value.id,
    });
  }

  Future deleteFavouriteNews() async {
    var currentUser = auth.currentUser;
    FirebaseFirestore.instance
        .collection("userRegister")
        .doc(currentUser!.uid)
        .collection("like")
        .doc(newsDetails.value.id)
        .delete();
  }
}
