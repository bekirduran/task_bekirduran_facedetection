import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_bekirduran/model/utils/constants.dart';
import '../data_models/person_info_model.dart';
import '../data_models/person_model.dart';

class DataBaseHelper extends GetxController{

  late Database db;



  //Creating and Opening DB
  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.
          execute('''
create table $tablePersons ( 
  $cId integer primary key autoincrement, 
  $cPersonId text unique not null,
  $cPersonName String,
  $cPersonSurname String,
  $cStatus String,
  $cIdentityNo text null,
  $cFatherN String null,
  $cMotherN String null,
  $cGender String null,
  $cBirthDate String null,
  $cBirthPlace String null,
  $cMartialStatus String null,
  $cCity String null,
  $cTown String null,
  $cDeath String null,
  $cPhoto text not null
  )
''');
        });
  }

  //Closing DB
  Future close() async => db.close();


  //Inserting DB
  Future<PersonModel> insert(PersonModel person) async {
    try {
      await db.insert(tablePersons, person.toMap());
    } catch (e) {
      if (!e.toString().contains("DatabaseException"))
        print(e);
    }
    return person;
  }


  //Updating DB
  Future<PersonInfoModel> upDate(PersonInfoModel person, String id) async {
    try {
      await db.update(tablePersons, person.toMap(),
          where: '$cPersonId = ?', whereArgs: [id]
      );
    } catch (e) {
      print(e);
    }
    return person;
  }

  //Fetching PersonModel data from DB
  Future<List<PersonModel>> getPersonFromDb() async {
    List<PersonModel> persons = [];
    var maps = await db.query(tablePersons,
      columns: [cPersonId, cPersonName, cPersonSurname, cStatus, cPhoto],);
    if (maps.length > 0) {
      maps.forEach((element) {
        var person = PersonModel.fromJson(element);
        persons.add(person);
      });
      update();
      return persons;
    }
    return persons;
  }

//Fetching PersonInfoModel data from DB
  Future<PersonInfoModel> getPersonDetailFromDb(String id) async {
    var maps = await db.query(tablePersons,
        columns: [
          cPersonId,
          cPersonName,
          cPersonSurname,
          cStatus,
          cPhoto,
          cIdentityNo,
          cFatherN,
          cMartialStatus,
          cMotherN,
          cGender,
          cBirthDate,
          cBirthPlace,
          cCity,
          cTown
        ],
        where: '$cPersonId = ?', whereArgs: [id]
    );
    return PersonInfoModel.fromJson(maps.first);
    }



}