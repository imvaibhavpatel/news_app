import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/dashboard/create_news_screen/create_news_screen.dart';
import 'package:news_app/screen/dashboard/news_details_screen/news_details_controller.dart';

class NewsDetailsScreen extends StatelessWidget {
  NewsDetailsScreen({Key? key}) : super(key: key);

  final NewsDetailsController newsDetailsController =
      Get.put(NewsDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text("Details"),
        actions: [
          newsDetailsController.isEdit.value
              ? Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(
                        () => CreateNewsScreen(),
                        arguments: [
                          true,
                          newsDetailsController.newsDetails.value,
                        ],
                      ),
                      child: const Icon(Icons.edit),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => newsDetailsController.deleteNews(),
                      child: const Icon(Icons.delete),
                    ),
                    const SizedBox(width: 15),
                  ],
                )
              : const SizedBox()
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 20,
                  bottom: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      newsDetailsController.newsDetails.value.category,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0XFFeb4e3d),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.black,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("userRegister")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("like")
                              .doc(newsDetailsController.newsDetails.value.id)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.data() != null) {
                                return IconButton(
                                  onPressed: () {
                                    newsDetailsController.deleteFavouriteNews();
                                  },
                                  icon: const Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.red,
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    newsDetailsController.addFavouriteNews();
                                  },
                                  child: const Icon(
                                    Icons.favorite_border_rounded,
                                    color: Colors.white,
                                  ),
                                );
                              }
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  newsDetailsController.newsDetails.value.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Image.network(
                    newsDetailsController.newsDetails.value.image),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                  right: 15,
                  bottom: 20,
                ),
                child: Text(
                  newsDetailsController.newsDetails.value.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
