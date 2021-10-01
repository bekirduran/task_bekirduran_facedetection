import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/../model/data_models/person_model.dart';
import '/../model/localdb/database_controller.dart';
import '/../model/utils/constants.dart';
import '../pages/person_detail_page.dart';
import '/../view_model/person_controller.dart';

class PersonList extends GetView<List<PersonModel>> {
  final isConnected = true.obs;


  @override
  Widget build(BuildContext context) {
    //from localdb controller
    DataBaseController ex_controller = Get.put(DataBaseController());
    //from API controller
    PersonController controller =
        Get.put(PersonController(kBaseUrl + '/index'));

    checkInternet(context);

    final tColor = Colors.black.obs;

    return Scaffold(
        body: controller.obx((state) {
        return buildBody(state, tColor);
    },
      onLoading: Center(child: CupertinoActivityIndicator()),
      onError: (error) => Center(child: Text(error.toString()))));

  }

  Container buildBody(List<PersonModel>? state, Rx<Color> tColor) {
    return Container(
      child: ListView.builder(
        itemCount: state!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (state[index].status == "completed") {
                Get.to(() => PersonDetailPage(id: state[index].id));

                tColor.value = Colors.green;
              } else if (state[index].status == "processing") {
                Get.snackbar("Error", "Still Processing",
                    snackPosition: SnackPosition.BOTTOM);
                tColor.value = Colors.yellow.shade900;
              } else {
                Get.snackbar("Error", "Scanning Failed",
                    snackPosition: SnackPosition.BOTTOM);
                tColor.value = Colors.red.shade900;
              }
            },
            child: Container(
              height: Get.height * 0.137,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.5, color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.only(top: 2, left: 8, right: 8, bottom: 2),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.memory(
                        base64Decode(state[index].photo),
                        width: Get.width * 0.18,
                        height: Get.width * 0.18,
                        fit: BoxFit.fitWidth,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state[index].name! != "null" &&
                                state[index].surname! != "null"
                            ? Text(
                                state[index].name! +
                                    " " +
                                    state[index].surname!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              )
                            : Text("Unknown",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20)),
                        Text(
                          state[index].status,
                          style: TextStyle(
                              color: colorPicker(state[index].status),
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color colorPicker(String status){
    switch(status){
      case ("completed"):return Colors.green.withOpacity(0.5);
      case ("failed"):return Colors.red.withOpacity(0.5);
      default:
        return Colors.black.withOpacity(0.5);
    }
  }

  void checkInternet(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('turkai.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        isConnected.value = true;
      }
    } on SocketException catch (_) {
      isConnected.value = false;
      Get.snackbar("Error", "Please check Internet Connection",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
