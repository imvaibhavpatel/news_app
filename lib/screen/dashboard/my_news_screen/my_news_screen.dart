import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/dashboard/home_screen/home_screen.dart';
import 'package:news_app/screen/dashboard/my_news_screen/news_controller.dart';
import 'package:news_app/screen/dashboard/news_details_screen/news_details_screen.dart';

class MyNewsScreen extends StatelessWidget {
  MyNewsScreen({Key? key}) : super(key: key);

  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        elevation: 3,
        backgroundColor: Colors.black,
        title: const Text("My news"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("news")
            .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy("createdAt", descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 15,
                top: 15,
                left: 10,
                right: 10,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                News data = News(
                  title: snapshot.data.docs[index].data()["title"].toString(),
                  description: snapshot.data.docs[index]
                      .data()["Description"]
                      .toString(),
                  category:
                      snapshot.data.docs[index].data()["category"].toString(),
                  image: snapshot.data.docs[index].data()["image"].toString(),
                  id: snapshot.data.docs[index].id.toString(),
                  updated:
                      snapshot.data.docs[index].data()["createdAt"],
                );
                return GestureDetector(
                  onTap: () => Get.to(() => NewsDetailsScreen(), arguments: [
                    data,
                    true,
                  ]),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          data.category.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.description.toString(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                data.image.toString(),
                                height: 90,
                                width: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
        },
      ),
    );
  }
}
