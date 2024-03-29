import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mediapp/screens/admin/adminDashboard.dart';
import 'package:mediapp/screens/med/dashboardd.dart';
import 'package:mediapp/screens/patient/patient_screen.dart';

class Constants {
  // Name
  static String appName = "Rhinestone";

  static List<String> list_malade = [""];

  static List<String> list_medica = [""];

  static List<String> list_jour = [""];

  static Map<String, dynamic> b;

  static String url = "http://fractaltun.herokuapp.com";
  static String port = "3000";

  static const kPrimaryColor = Color(0xFF6F35A5);
  static const kPrimaryLightColor = Color(0xFFF1E6FF);
  static const kBackgroundColor = Color(0xFFF1EFF1);
  static const kSecondaryColor = Color(0xFFFFA41B);
  static const kTextColor = Color(0xFF000839);
  static const kTextLightColor = Color(0xFF747474);
  static const kBlueColor = Color(0xFF40BAD5);
  static const kDefaultPadding = 20.0;

// our default Shadow
  static const kDefaultShadow = BoxShadow(
    offset: Offset(0, 15),
    blurRadius: 27,
    color: kTextColor, // Black color with 12% opacity
  );

  // Material Design Color
  static Color lightPrimary = Color(0xfffcfcff);
  static Color lightAccent = Color(0xFF3B72FF);
  static Color lightBackground = Color(0xfffcfcff);

  static Color darkPrimary = Colors.black;
  static Color darkAccent = Color(0xFF3B72FF);
  static Color darkBackground = Colors.black;

  static Color grey = Color(0xff707070);
  static Color textPrimary = Color(0xFF486581);
  static Color textDark = Color(0xFF102A43);

  static Color backgroundColor = Color(0xFFF5F5F7);

  // Green
  static Color darkGreen = Color(0xFF3ABD6F);
  static Color lightGreen = Color(0xFFA1ECBF);

  // Yellow
  static Color darkYellow = Color(0xFF3ABD6F);
  static Color lightYellow = Color(0xFFFFDA7A);

  // Blue
  static Color darkBlue = Color(0xFF3B72FF);
  static Color lightBlue = Color(0xFF3EC6FF);

  // Orange
  static Color darkOrange = Color(0xFFFFB74D);

  static var user;

  static ThemeData lighTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: lightBackground,
      primaryColor: lightPrimary,
      accentColor: lightAccent,
      cursorColor: lightAccent,
      scaffoldBackgroundColor: lightBackground,
      textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      appBarTheme: AppBarTheme(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        iconTheme: IconThemeData(
          color: lightAccent,
        ),
      ),
    );
  }

  static double headerHeight = 228.5;
  static double paddingSide = 30.0;
}

Widget backButton(context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
          ),
          Text('Retour',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}

Widget entryField(String title, TextEditingController controller,
    {bool isPassword = false}) {
  var hint = title;
  if (title == "Telephone") {
    hint = "ex: 00 216 208 300 300";
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],
    ),
  );
}

Widget emailPasswordWidget(TextEditingController userController,
    TextEditingController passwordController) {
  return Column(
    children: <Widget>[
      entryField("Username", userController),
      entryField("Mots de passe", passwordController, isPassword: true),
    ],
  );
}

Widget submitButton(context, TextEditingController userController,
    TextEditingController passwordController) {
  return InkWell(
      onTap: () async {
        var url = Constants.url + "/api/authenticate";
        var body = jsonEncode({
          "username": userController.text.toString(),
          "password": passwordController.text.toString()
        });
        print("Body: " + body);
        await Future.delayed(const Duration(seconds: 1), () => "1");
        print("Body2: " + body);
        if (userController.text.toString().isEmpty) {
          _showDialog(context, "Login", "Champs Username est vide", "Confirme");
        } else if (passwordController.text.toString().isEmpty) {
          _showDialog(context, "Login", "Champs password est vide", "Confirme");
        } else {
          await http
              .post(url,
                  headers: {"Content-Type": "application/json"}, body: body)
              .then((http.Response response) async {
            print("Response status : ${response.statusCode}");
            print("Response contentLength : ${response.contentLength}");
            print("Response headers : ${response.headers}");
            print("Response request :${response.request}");
            print("Response body : ${response.body}");

            String body = response.body;
            var parsedJson = json.decode(body);
            if (parsedJson['success'] as bool == true) {
              Constants.user = parsedJson['user'];
              print(true);
              if (Constants.user["role"] == "pat") {
                var url = Constants.url + "/api/getUserById/";
                var body = jsonEncode({
                  "_id": Constants.user["monmed"].toString(),
                });
                await http
                    .post(url,
                        headers: {"Content-Type": "application/json"},
                        body: body)
                    .then((http.Response response) {
                  print("Response status : ${response.statusCode}");
                  print("Response contentLength : ${response.contentLength}");
                  print("Response headers : ${response.headers}");
                  print("Response request :${response.request}");
                  print("Response body : ${response.body}");

                  String body = response.body;
                  List<dynamic> parsedJson = json.decode(body);
                  if (parsedJson != null) {
                    var a = parsedJson[0];
                    print(a.toString());
                    Constants.b = a as Map<String, dynamic>;
                    print(Constants.b["_id"]);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DetailPPage()));
                  } else {
                    print(false);
                  }
                });
                print(Constants.user["role"]);
              } else if (Constants.user["role"] == "med") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Dashboardd()));
                print(Constants.user["role"]);
              } else if (Constants.user["role"] == "Admin") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => adminDashboardd()));
                print(Constants.user["role"]);
              }
            } else {
              print(false);

              String body = response.body;
              var parsedJson = json.decode(body);
              // ignore: unrelated_type_equality_checks
              if (parsedJson['msg'].toString().compareTo("Authentication failed, wrong password") == true){
                _showDialog(context, "Login", "mots de passe incorrect", "Confirme");
              }else {
                _showDialog(context, "Login", "Utilisateur non trouvé", "Confirme");
              }
            }
          });
          print(userController.text.toString());
          print(passwordController.text.toString());
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Constants.darkBlue, Constants.darkGreen])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ));
}

void _showDialog(context, titre, content, btnText) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(titre),
        content: new Text(content),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(btnText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget createAccountLabel(context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboardd()));
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Text(
            'Registre',
            style: TextStyle(
                color: Constants.darkBlue,
                fontSize: 13,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    ),
  );
}

Widget title() {
  return Text(
    "Bonjour\n",
    style: TextStyle(
        fontSize: 25, fontWeight: FontWeight.w900, color: Constants.darkBlue),
  );
}
