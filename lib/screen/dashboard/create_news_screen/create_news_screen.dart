import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/dashboard/create_news_screen/create_news_controller.dart';

class CreateNewsScreen extends StatelessWidget {
  CreateNewsScreen({Key? key}) : super(key: key);

  final CreateNewsController createNewsController =
      Get.put(CreateNewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(createNewsController.saveChanges.value
            ? "Edit news"
            : "Create news"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: createNewsController.formKey,
          child: Column(
            children: [
              Obx(
                () => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 20,
                    left: 15,
                    right: 15,
                    bottom: 20,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  child: createNewsController.imageUrl.isNotEmpty
                      ? Image.network(
                          createNewsController.imageUrl.value,
                          height: 200,
                          fit: BoxFit.contain,
                        )
                      : createNewsController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : GestureDetector(
                              onTap: () => createNewsController.getImage(),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(25),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    child: const Icon(
                                      Icons.folder,
                                      color: Colors.black,
                                      size: 35,
                                    ),
                                  ),
                                  Text(
                                    "Upload image",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: createNewsController.titleController,
                  decoration: const InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Title required";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: TextFormField(
                  maxLines: 5,
                  cursorColor: Colors.black,
                  controller: createNewsController.disController,
                  decoration: const InputDecoration(
                    hintText: "Description....",
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Filled required";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  value: createNewsController.selectedValue.value.isEmpty
                      ? null
                      : createNewsController.selectedValue.value,
                  borderRadius: BorderRadius.circular(13),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  hint: const Text('Category'),
                  items: createNewsController.category
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    createNewsController.selectedValue.value = value.toString();
                  },
                  validator: (v) => v == null ? "Select a country" : null,
                ),
              ),
              const SizedBox(height: 25),
              createNewsController.saveChanges.value
                  ? Obx(
                      () => SizedBox(
                        width: Get.width * 0.90,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            if (createNewsController.formKey.currentState!
                                .validate()) {
                              createNewsController.saveNewsChanges();
                            }
                          },
                          child: createNewsController.isUpload.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text("Save changes".toUpperCase()),
                        ),
                      ),
                    )
                  : Obx(
                      () => SizedBox(
                        width: Get.width * 0.90,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            if (createNewsController.formKey.currentState!
                                .validate()) {
                              createNewsController.createNews();
                            }
                          },
                          child: createNewsController.isUpload.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text("Create  news".toUpperCase()),
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
