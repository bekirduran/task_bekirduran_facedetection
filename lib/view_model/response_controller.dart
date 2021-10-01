import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_bekirduran/model/services/task_provider.dart';

class ResponseController extends GetxController with StateMixin<int>{
    XFile? photo;
    ResponseController(this.photo);


  TaskProvider _provider =TaskProvider();
      @override
  void onInit() {
    super.onInit();
    _provider.uploadImage(photo!.path).then((response) {
      if(response == 200)
      change(response,status: RxStatus.success());
    },onError: (err) {
      change(null,status: RxStatus.error(err.toString()));
    }
    );
  }
}