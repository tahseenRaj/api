import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api/model/user_model.dart';

getUser({String? userName}) async {
  var response =
      await http.get(userName == '' ? Uri.parse('https://jsonplaceholder.typicode.com/users/') : Uri.parse('https://jsonplaceholder.typicode.com/users?username=$userName'));
  var jsonData = jsonDecode(response.body);

  List<UserModel> users = [];
  for (var i in jsonData) {
    UserModel user = UserModel(
        id: i['id'],
        name: i['name'],
        username: i['username'],
        email: i['email'],
        phone: i['phone']);

    users.add(user);
  }
  return users;
}