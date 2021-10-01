// Model Class
class PersonInfoModel {
  final String id;
  final String name;
  final String surname;
  final String identity_number;
  final String father_name;
  final String mother_name;
  final String gender;
  final String birthday;
  final String birth_place;
  final String marital_status;
  final String city;
  final String town;
  final String photo;
  final String? date_of_death;

  PersonInfoModel(
      {required this.id,
      required this.name,
      required this.surname,
      required this.identity_number,
      required this.father_name,
      required this.mother_name,
      required this.gender,
      required this.birthday,
      required this.birth_place,
      required this.marital_status,
      required this.city,
      required this.town,
        required this.photo,
      this.date_of_death});


  //func. Reading from API
  factory PersonInfoModel.fromJson(Map<String, dynamic> json) {
    return PersonInfoModel(
        id : json['id'],
        name : json['name'],
        surname : json['surname'],
        identity_number : json['identity_number'] ?? "null",
        father_name : json['father_name'] ?? "null",
        mother_name : json['mother_name'] ?? "null",
        gender : json['gender'] ?? "null",
        birthday : json['birthday'] ?? "null",
        birth_place : json['birth_place'] ?? "null",
        marital_status : json['marital_status'] ?? "null",
        city : json['city'] ?? "null",
        town : json['town']?? "null",
        date_of_death: json['date_of_death'] ?? "null",
        photo : json['photo'] ,
    );
  }

  //func. Writing to LocalDB
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id ,
      'name': name ,
      'surname': surname,
      'identity_number':identity_number,
      'father_name':father_name,
      'mother_name':mother_name,
      'gender':gender,
      'birthday':birthday,
      'birth_place':birth_place,
      'marital_status':marital_status,
      'city':city,
      'town':town,
      'date_of_death':date_of_death,
      'photo':photo,
    };
    return map;
  }
}
