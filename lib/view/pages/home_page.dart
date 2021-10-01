import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import '/../view/pages/person_list.dart';
import '/../view_model/response_controller.dart';

// ignore: must_be_immutable
class HomePage extends GetView<ResponseController> {



  @override
  Widget build(BuildContext context) {
    checkInternet(context);
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black54,
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => PersonList());
            },
            icon: Icon(Icons.history)),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Scan by Gallery or Camera",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            buildRow(context)
          ],
        ),
      ),
    );
  }

  Row buildRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            width: Get.width * 0.45,
            height: Get.height * 0.45,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: IconButton(
              icon: Icon(
                Ionicons.camera,
                size: 150,
              ),
              onPressed: () => _onCameraPressed(context),
            )),
        Container(
            width: Get.width * 0.45,
            height: Get.height * 0.45,
            decoration: BoxDecoration(
                color: Colors.brown.shade200,
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: IconButton(
              icon: Icon(
                Ionicons.images,
                size: 150,
              ),
              onPressed: () => _onGalleryPressed(context),
            ))
      ],
    );
  }

  ImagePicker _imagePicker = ImagePicker();

  void _onCameraPressed(BuildContext context) async {
    final XFile? photo =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (photo == null) {
      Get.snackbar("Failed", "Process cancelled!",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.create(() => ResponseController(photo));
        Get.snackbar("Successfully", "Photo has been send",
            snackPosition: SnackPosition.BOTTOM);
       }
  }

  void _onGalleryPressed(BuildContext context) async {
    final XFile? photo =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (photo == null) {
      Get.snackbar("Failed", "Process cancelled!",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.create(() => ResponseController(photo));
      Get.snackbar("Successfully", "Photo has been send",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void checkInternet(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('turkai.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      Get.snackbar("Error", "Please check Internet Connection",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
