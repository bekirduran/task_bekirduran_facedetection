import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:ionicons/ionicons.dart';
import '/../model/data_models/person_info_model.dart';
import '/../model/utils/constants.dart';
import '/../view_model/person_info_controller.dart';

class DetailInfoWidget extends GetView<PersonInfoController> {
  PersonInfoModel? person;
  DetailInfoWidget(this.person);


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: SingleChildScrollView(
        child:Container(
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.memory(
                      base64Decode(person!.photo),
                      width: Get.width * 0.28,
                      height: Get.width * 0.28,
                      fit: BoxFit.fitWidth,
                    )),
                rowBuilder(Ionicons.person, "Name:", person!.name),
                rowBuilder(Ionicons.person, "Surname:", person!.surname),
                rowBuilder(Ionicons.id_card, "Identity Number:",
                    person!.identity_number),
                rowBuilder(Ionicons.person_circle, "Father Name:",
                    person!.father_name),
                rowBuilder(Ionicons.person_circle, "Mother Name:",
                    person!.mother_name),
                rowBuilder(Ionicons.transgender, "Genderr:", person!.gender),
                rowBuilder(
                    CupertinoIcons.calendar, "Birthday:", person!.birthday),
                rowBuilder(Ionicons.map, "Birth Place:", person!.birth_place),
                rowBuilder(Ionicons.finger_print, "Martial Status:",
                    person!.marital_status),
                rowBuilder(Ionicons.location, "City:", person!.city),
                rowBuilder(Ionicons.locate, "Town:", person!.town),
                rowBuilder(Ionicons.close_circle_sharp, "Death of Time:",
                    person!.date_of_death! ),
                Container(
                  child: TextButton(
                    onPressed: () {

                      PersonInfoController  controller = Get.put(
                          PersonInfoController(
                              kBaseUrl + '/show/' + person!.id));
                      Future.delayed(Duration(milliseconds: 300)).then((value) => Get.back()).then((value) => Get.snackbar("Successfully", "Updated"));
                    },
                    child: Text("Update",style: TextStyle(fontSize: 18),),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  Widget rowBuilder(IconData icon, String header, String value) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.black45,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      header,
                      style: TextStyle(color: Colors.black45, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              value,
              style: TextStyle(color: Colors.black, fontSize: 22),
            )
          ],
        ),
        Divider(
          height: 3,
        )
      ],
    );
  }
}
