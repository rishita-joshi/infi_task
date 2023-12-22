import 'dart:convert';
import 'package:api_task_glogin/model/photos_model_class.dart';
import '../model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String userApi = "https://jsonplaceholder.typicode.com/users";
  String photosApi = "https://jsonplaceholder.typicode.com/photos";

  Future<List<UserModelClass>> getUser() async {
    List<UserModelClass> userModelClass = [];
    final response = await http.get(Uri.parse(userApi));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      userModelClass =
          data.map((item) => UserModelClass.fromJson(item)).toList();
      //   print("--->$userModelClass");
      return userModelClass;
    } else {
      return userModelClass = [];
    }
  }

  Future<List<PhotosModelClass>> getPhotosApi() async {
    List<PhotosModelClass> photoModelClassList = [];
    final response = await http.get(Uri.parse(userApi));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      photoModelClassList =
          data.map((item) => PhotosModelClass.fromJson(item)).toList();
      return photoModelClassList;
    } else {
      return photoModelClassList = [];
    }
  }
}
