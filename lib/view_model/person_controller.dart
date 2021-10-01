import 'package:get/get.dart';
import '/../model/data_models/person_model.dart';
import '/../model/repository/person_reposiroty.dart';

class PersonController extends GetxController with StateMixin<List<PersonModel>> {

  String url;
  PersonController(this.url);

  PersonRepository _personRepository = PersonRepository();
  @override
  void onInit() {
    super.onInit();
    _personRepository.fetchPersonInfo(url).then((value) {
      change(value,status: RxStatus.success()); },
        onError:(err) {
          change(null,status: RxStatus.error(err.toString()));
        }
    );
  }
}