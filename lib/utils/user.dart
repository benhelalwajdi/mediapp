import 'dart:convert';
import 'package:http/http.dart' as http;

import 'const.dart';

class User {
  /*
  * {
  "_id" : "1",
  "name": "user",
  "email": "user@user.com",
  "password": "pass",
  "username": "user",
  "role": "pat",
  "speciality": "",
  "address": "52 city nassime",
  "tel": "00216 23121414",
  "monmed": "2",
  "type": ["INFECTION"],
  "medicaments":["H"],
  "code": "7486332443",
  "evaluation": "1"
  },*/
  var id;
  var name;
  var email;
  var password;
  var username;
  var role;
  var speciality;
  var adress;
  var tel;
  var monmed;
  var createdAt;
  List<dynamic> type;
  List<dynamic> medicaments;
  var code;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.username,
    this.role,
    this.speciality,
    this.adress,
    this.tel,
    this.monmed,
    this.type,
    this.medicaments,
    this.code,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      id: parsedJson['_id'] as String,
      name: parsedJson['name'] as String,
      email: parsedJson['email'] as String,
      password: parsedJson['password'] as String,
      username: parsedJson['username'] as String,
      role: parsedJson['role'] as String,
      speciality: parsedJson['speciality'] as String,
      adress: parsedJson['address'] as String,
      tel: parsedJson['tel'],
      monmed: parsedJson['monmed'] as String,
      type: parsedJson['type'],
      medicaments: parsedJson['medicaments'],
      code: parsedJson['code'],
      createdAt: parsedJson['createdAt'],
    );
  }
}

class UserViewModel {
  static List<User> user = [];
  static Future loadPlayers() async {
    var url = "http://"+Constants.url+":"+Constants.port+"/api/admin/allUsersByRole/pat";
    http.get(url, headers: {"Content-Type": "application/json"}).then(
        (http.Response response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
      String body = response.body;
      print(body);
      List<dynamic> parsedJson = json.decode(body);
      List<User> user2;
      for (int i = 0; i < parsedJson.length; i++) {
        /*print(parsedJson[i].toString());
        print(user[i].type[0]);
        print(user[i].adress);*/
        User us = new User.fromJson(parsedJson[i]);
        print(us.createdAt.toString());
        if(i==0){
        user2 = [us];
        }
        if(i != 0){
        user2.add(us);
        }
        print(us.email.toString());
        if (us.type.isEmpty) {
          us.type.add("test");
        }
        print(us.type[0]);
        if (us.medicaments.isEmpty) {
          us.medicaments.add("tt");
        }
        print(user2[i].type[0]);
      }
      user = user2;
    });
  }
}
