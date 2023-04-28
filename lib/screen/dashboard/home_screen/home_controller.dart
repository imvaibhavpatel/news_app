import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<Map<String, String>> newsCategory = [
    {
      "icon": "assets/icons/all_icon.png",
      "category": "All",
    },
    {
      "icon": "assets/icons/sport_icon.png",
      "category": "Sports",
    },
    {
      "icon": "assets/icons/health_icon.png",
      "category": "health",
    },
    {
      "icon": "assets/icons/business_icon.png",
      "category": "Business",
    },
    {
      "icon": "assets/icons/tech.png",
      "category": "Technology",
    },
    {
      "icon": "assets/icons/lifestyle_icon.png",
      "category": "Life style",
    },
    {
      "icon": "assets/icons/auto_icon.png",
      "category": "Auto",
    },
  ];
  RxString selectedCategory = "All".obs;
}
