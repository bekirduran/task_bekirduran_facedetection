import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/../model/localdb/database_detail_controller.dart';
import '/../view/widgets/detail_info_widget.dart';
import '/../view_model/person_info_controller.dart';

// ignore: must_be_immutable
class PersonDetailPage extends GetView<PersonInfoController> {
  String id;

  PersonDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {

      DataBaseDetailController controller = Get.put(DataBaseDetailController(id));

    return Scaffold(
      body: controller.obx((state){
        return DetailInfoWidget(state);
      }, onEmpty: Text("Empty"),
      onLoading: Center(child: CupertinoActivityIndicator()),
      onError:(error) => Center(child: Text(error.toString()))),
    );
  }

}