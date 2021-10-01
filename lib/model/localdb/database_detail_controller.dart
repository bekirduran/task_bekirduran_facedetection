import 'package:get/get.dart';
import '../data_models/person_info_model.dart';
import '../localdb/database_helper.dart';
import '../utils/constants.dart';

class DataBaseDetailController extends GetxController
    with StateMixin<PersonInfoModel> {
  String id;
  DataBaseDetailController(this.id);

  DataBaseHelper _dataBaseHelper = DataBaseHelper();

  @override
  void onInit() {
    super.onInit();
    _dataBaseHelper.open(kDatabasePath).then((value){
      _dataBaseHelper.getPersonDetailFromDb(id).then((value) {
        change(value,status: RxStatus.success()); },
          onError:(err) {
            change(null,status: RxStatus.error(err.toString()));
          }
      );
    });

  }
  @override
  void onClose() {
    _dataBaseHelper.close();
    super.onClose();
  }
}
