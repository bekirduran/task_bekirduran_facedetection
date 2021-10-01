import 'package:get/get.dart';
import '../data_models/person_model.dart';
import '../localdb/database_helper.dart';
import '../utils/constants.dart';

class DataBaseController extends GetxController with StateMixin<List<PersonModel>> {
  DataBaseHelper _dataBaseHelper = DataBaseHelper();

  @override
  void onInit() {
    super.onInit();
    _dataBaseHelper.open(kDatabasePath).then((value){
      _dataBaseHelper.getPersonFromDb().then((persons) {
        change(persons,status: RxStatus.success());
        update();
        },
          onError:(err) {
            change(null,status: RxStatus.error(err.toString()));
          }
      );
    });
    update();
  }

  @override
  void onClose() {
    _dataBaseHelper.close();
    super.onClose();
  }

}