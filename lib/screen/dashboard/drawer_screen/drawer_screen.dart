import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/dashboard/drawer_screen/drawer_screen_controller.dart';
import 'package:news_app/screen/dashboard/my_news_screen/my_news_screen.dart';
import 'package:news_app/screen/dashboard/profile_edit/profile_edit_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final DrawerScreenController drawerController =
      Get.put(DrawerScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(20),
          ),
        ),
        elevation: 0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Image.asset(
                "assets/images/fake_news_logo.png",
                height: 80,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 55,
                      child: drawerController.box.read("image") != null
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 53,
                              backgroundImage: NetworkImage(
                                drawerController.box.read("image"),
                              ),
                            )
                          : null),
                  const SizedBox(height: 20),
                  Text(
                    drawerController.box.read("name") ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      Get.back();
                      var test = await Get.to(() => ProfileEditScreen());
                      if (test != null) {
                        setState(() {});
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Edit profile",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    endIndent: 15,
                    indent: 15,
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => MyNewsScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.view_list,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "My news",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    endIndent: 15,
                    indent: 15,
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.settings,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Setting",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    endIndent: 15,
                    indent: 15,
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.help,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Help",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => drawerController.logOut(),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.login_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
