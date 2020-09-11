import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mediapp/screens/admin/adminDashboard.dart';
import 'package:mediapp/utils/const.dart';

class ajoutMed extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ajoutMed> {
  int age = 0;
  final prenomController = TextEditingController();
  final nomController = TextEditingController();
  final usernomController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final adresseController = TextEditingController();
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.lightBlue,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Constants.paddingSide),
            child: ListView(
              children: <Widget>[
                //Positioned(top: 40, left: 0, child: backButton(context)),
                SizedBox(height: 20),
                // Header - Greetings and Avatar
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Nouveaux,\nMedicien \nDate : ${this.now.day}/${this.now.month}/${this.now.year}  \n",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                entryField("Nom", nomController),
                entryField("Prenom", prenomController),
                entryField("E-mail", emailController),
                entryField("Username", usernomController),
                entryField("Telephone", phoneController),
                entryField("Adresse", adresseController),
                SizedBox(height: 10),
                Text(
                  "Code :",
                  style: TextStyle(
                    color: Constants.lightPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ButtonBar(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  new RaisedButton(
                    color: Colors.lightBlue,
                    child: new Text('Enregistre'),
                    onPressed: () async {
                      /*print(emailController.text.toString());
                      print(nomController.text.toString());
                      print(prenomController.text.toString());
                      print(usernomController.text.toString());
                      print(phoneController.text.toString());
*/
                      if (emailController.text.isEmpty) {
                        try {
                          _showDialog(context, "Attention",
                              "Champ Email et vide", "fermé");
                        } catch (error) {
                          print(error);
                        }
                      } else if (adresseController.text.isEmpty) {
                        try {
                          _showDialog(context, "Attention",
                              "Champ Adresse et vide", "fermé");
                        } catch (error) {
                          print(error);
                        }
                      } else if (nomController.text.isEmpty) {
                        try {
                          _showDialog(context, "Attention", "Champ Nom et vide",
                              "fermé");
                        } catch (error) {
                          print(error);
                        }
                      } else if (prenomController.text.isEmpty) {
                        try {
                          _showDialog(context, "Attention",
                              "Champ Prènom et vide", "fermé");
                        } catch (error) {
                          print(error);
                        }
                      } else if (usernomController.text.isEmpty) {
                        try {
                          _showDialog(context, "Attention",
                              "Champ username et vide", "fermé");
                        } catch (error) {
                          print(error);
                        }
                      } else if (phoneController.text.isEmpty) {
                        try {
                          _showDialog(context, "Attention",
                              "Champ Telephone et vide", "fermé");
                        } catch (error) {
                          print(error);
                        }
                      }

                      if (phoneController.text.isNotEmpty) {
                        var decimal;
                        try {
                          decimal = int.parse(phoneController.text);
                        } catch (error) {
                          _showDialog(
                              context,
                              "Attention",
                              "vous ne pouvez pas enregistre un numero telephone avec des caractaire.\n ex : 00 216 23123414",
                              "fermé");
                        }
                        var url = "http://" +
                            Constants.url +
                            ":" +
                            Constants.port +
                            "/api/adduser";
                        print("object");
                        var body = jsonEncode({
                          "email": emailController.text,
                          "name": nomController.text + " " + prenomController.text,
                          "password": "1234",
                          "role": "med",
                          "address": adresseController.text,
                          "tel": phoneController.text,
                          "username": usernomController.text,
                          "code": "123",
                          "speciality": "general",
                          "monmed": Constants.user["_id"],
                          "evaluation" :" ",
                          "dateaniv" : now.toString(),
                        });
                        print("Body: " + body);
                        try {
                          await http
                              .post(url,
                                  headers: {"Content-Type": "application/json"},
                                  body: body)
                              .then((http.Response response) async {
                            String body = response.body;
                            print(body);
                            var parsedJson = json.decode(body);
                            if (parsedJson['success'] as bool == true) {
                              print("ajout medicien" + true.toString());
                              Map<String, dynamic> parsedJson =
                                  json.decode(body);
                              print(parsedJson["success"].toString());
                            } else {
                              print("ajout medicien" + false.toString());
                            }
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => adminDashboardd()),
                          );
                        } catch (error) {
                          print("When you add new Med : " + error.toString());
                        }
                      }
                    },
                  ),
                  new RaisedButton(
                    color: Colors.lightBlueAccent,
                    child: new Text('Reset'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
