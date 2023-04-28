import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_app/screen/dashboard/create_news_screen/create_news_screen.dart';
import 'package:news_app/screen/dashboard/drawer_screen/drawer_screen.dart';
import 'package:news_app/screen/dashboard/home_screen/home_controller.dart';
import 'package:news_app/screen/dashboard/news_details_screen/news_details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());

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
        centerTitle: true,
        title: Image.asset(
          "assets/images/fake_news_logo.png",
          width: 110,
        ),
      ),
      drawer: const DrawerScreen(),
      body: Column(
        children: [
          SizedBox(
            height: 55,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: homeController.newsCategory.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      homeController.selectedCategory.value =
                          homeController.newsCategory[index]["category"]!;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: homeController.selectedCategory.value ==
                                    homeController.newsCategory[index]
                                        ["category"]
                                ? Colors.black
                                : Colors.transparent,
                            width: 1),
                        color: homeController.selectedCategory.value ==
                                homeController.newsCategory[index]["category"]
                            ? Colors.white
                            : Colors.grey.shade200,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            homeController.newsCategory[index]["icon"]!,
                            color: homeController.selectedCategory.value ==
                                    homeController.newsCategory[index]
                                        ["category"]
                                ? null
                                : Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            homeController.newsCategory[index]["category"]!,
                            style: TextStyle(
                              color: homeController.selectedCategory.value ==
                                      homeController.newsCategory[index]
                                          ["category"]
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Obx(
                    () => StreamBuilder(
                      stream: homeController.selectedCategory.value == "All"
                          ? FirebaseFirestore.instance
                              .collection("news")
                              .orderBy("createdAt", descending: false)
                              .snapshots()
                          : FirebaseFirestore.instance
                              .collection("news")
                              .where("category",
                                  isEqualTo: homeController.selectedCategory
                                      .toString())
                              .orderBy("createdAt", descending: false)
                              .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.docs != null &&
                              snapshot.data.docs.length != 0) {
                            return ListView.builder(
                              reverse: true,
                              padding: const EdgeInsets.only(
                                bottom: 15,
                                left: 10,
                                right: 10,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                News data = News(
                                  title: snapshot.data.docs[index]
                                      .data()["title"]
                                      .toString(),
                                  description: snapshot.data.docs[index]
                                      .data()["Description"]
                                      .toString(),
                                  category: snapshot.data.docs[index]
                                      .data()["category"]
                                      .toString(),
                                  image: snapshot.data.docs[index]
                                      .data()["image"]
                                      .toString(),
                                  id: snapshot.data.docs[index].id.toString(),
                                  updated: snapshot.data.docs[index]
                                      .data()['createdAt'],
                                );

                                return GestureDetector(
                                  onTap: () => Get.to(
                                    () => NewsDetailsScreen(),
                                    arguments: [data, false],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            data.category.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0XFFeb4e3d),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            data.title.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Text(
                                                    data.description.toString(),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(),
                                                  ),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  data.image.toString(),
                                                  height: 90,
                                                  width: 110,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            "Published : ${DateFormat('dd MMM yyyy, hh:mm a').format(
                                                  DateTime
                                                      .fromMicrosecondsSinceEpoch(
                                                    data.updated * 1000,
                                                  ),
                                                ).toString()}",
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Column(
                              children: [
                                SizedBox(height: Get.height * 0.35),
                                Image.asset(
                                  "assets/icons/no_data.png",
                                  height: 100,
                                ),
                                const Text(
                                  "Data not found",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                )
                              ],
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CreateNewsScreen()),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class News {
  final String title;
  final String description;
  final String category;
  final String image;
  final String id;
  final int updated;

  News({
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.id,
    required this.updated,
  });
}
