import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:task_bekirduran/model/localdb/database_controller.dart';


class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<DataBaseController>(DataBaseController());
  }
}