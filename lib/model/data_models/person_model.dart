// Model Class
class PersonModel {
  final String id;
  final String? name;
  final String? surname;
  final String status;
  final String photo;

  PersonModel(
      {required this.id,
      this.name,
      this.surname,
      required this.status,
      required this.photo});

  //func. Writing to LocalDB
  factory PersonModel.fromJson(Map<String,dynamic> json){
    return PersonModel(
        id: json['id'],
        name: json['name'].toString(),
        surname:json['surname'].toString() ,
        status: json['status'],
        photo: json['photo']
    );
  }

  //func. Writing to LocalDB
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id ,
      'name': name ?? "null",
      'surname': surname ?? "null",
      'status':status,
      'photo':photo
    };
    return map;
  }

}
