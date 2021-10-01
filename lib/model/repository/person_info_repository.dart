
import '/../model/data_models/person_info_model.dart';
import '/../model/services/task_provider.dart';

class PersonInfoRepository {
  TaskProvider _provider = TaskProvider();


  Future<PersonInfoModel> fetchPersonInfo (url) async{
    var response = await _provider.fetchPersonInfo(url);
    final data = response["data"] as Map<String,dynamic>;
    return PersonInfoModel.fromJson(data);
  }
}