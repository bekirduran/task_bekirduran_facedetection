import 'package:get/get.dart';
import 'package:task_bekirduran/model/data_models/person_info_model.dart';
import 'package:task_bekirduran/model/localdb/database_helper.dart';
import 'package:task_bekirduran/model/repository/person_info_repository.dart';
import 'package:task_bekirduran/model/utils/constants.dart';

class PersonInfoController extends GetxController with StateMixin<PersonInfoModel>{
    String id;
    PersonInfoController(this.id);
    DataBaseHelper _dataBaseHelper = DataBaseHelper();
    PersonInfoRepository _personInfoRepository = PersonInfoRepository();
    @override

  void onInit() {
    super.onInit();

      _personInfoRepository.fetchPersonInfo(id).then((value2) {
      _dataBaseHelper.open(kDatabasePath).then((value) {
        // update database
        _dataBaseHelper.upDate(value2,value2.id);
      });
      change(value2,status: RxStatus.success());
      },
      onError:(err) {
        change(null,status: RxStatus.error(err.toString()));
      }
    );
  }

}