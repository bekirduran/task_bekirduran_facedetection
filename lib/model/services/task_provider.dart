import 'dart:convert';

import 'package:get/get.dart';
import '/../model/utils/constants.dart';
import 'package:http/http.dart' as http;

class TaskProvider extends GetConnect {
  // Post request with Image
    Future<int> uploadImage(filepath) async {
    var request = http.MultipartRequest('POST', Uri.parse(kBaseUrl + '/store'));
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    final res = await request.send();
    res.stream.transform(utf8.decoder).listen ((value) {
      print(value);
    });
    return res.statusCode;
  }


    // Fetch request to API
    Future fetchPersonInfo(String url) async {
      var jsonResponse;
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        jsonResponse = jsonDecode(response.body);
       return jsonResponse;
      }
      else{
        return jsonResponse;
      }
    }


}
