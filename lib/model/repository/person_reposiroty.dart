
import '/../model/data_models/person_model.dart';
import '/../model/localdb/database_helper.dart';
import '/../model/services/task_provider.dart';
import '/../model/utils/constants.dart';


class PersonRepository{
  TaskProvider _provider = TaskProvider();
  DataBaseHelper _dataBaseHelper = DataBaseHelper();

  Future<List<PersonModel>> fetchPersonInfo (String url) async{
     List<PersonModel> persons= [];
    var response = await _provider.fetchPersonInfo(url);
    final List<dynamic> data = response["data"];
     _dataBaseHelper.open(kDatabasePath).then((value) {
       data.forEach((element) {
         var person = PersonModel.fromJson(element);
         // add database
         _dataBaseHelper.insert(person).then((value) => _dataBaseHelper.getPersonFromDb());
       });
     });

    data.forEach((element) {
      var person = PersonModel.fromJson(element);
      persons.add(person);
    });
    return persons;
  }
}