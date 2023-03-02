import 'package:dio/dio.dart';

import '../model/user_model.dart';

class UserRepository {
  Future<List<UserModel>> getUserList() async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/users');
      List<UserModel> userList = [];
      if (response.statusCode == 200) {
        userList =
            (response.data as List).map((e) => UserModel.fromJson(e)).toList();
      }
      return userList;
    } on DioError catch (e) {
      return Future.error(e.message.toString());
    }
  }
}
