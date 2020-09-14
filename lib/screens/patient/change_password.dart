import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mediapp/utils/const.dart';

// ignore: camel_case_types
class newPassword extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<newPassword> {
  final old_password = TextEditingController();
  final newPassword = TextEditingController();
  final confirmeNewPassword = TextEditingController();

  _MyHomePageState();

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
                        "Changer votre mots de passe",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                entryField("Ancien mot de passe", old_password),
                entryField("Nouveau mot de passe", newPassword),
                entryField(
                    "Confirme nouveau mot de passe", confirmeNewPassword),
                ButtonBar(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  new RaisedButton(
                      color: Colors.lightBlue,
                      child: new Text('Enregistre'),
                      onPressed: () async {
                        var url = Constants.url + "/api/authenticate";
                        var body = jsonEncode({
                          "username": Constants.user["username"].toString(),
                          "password": old_password.text.toString()
                        });
                        print(old_password.text.toString());
                        await http.post(url, headers: {"Content-Type": "application/json"}, body: body).then((http.Response response) async {
                          String body = response.body;
                          print(body);
                          var parsedJson = json.decode(body);
                          if (parsedJson['success'] as bool == true) {
                            print(newPassword.text.toString());
                            print(confirmeNewPassword.text.toString());
                            if(newPassword.text.toString() == confirmeNewPassword.text.toString()){
                            var url = Constants.url + "/api/UpdatePasswordUser";
                            var body = jsonEncode({
                              "_id": Constants.user["_id"],
                              "password": newPassword.text
                            });
                            print("Body: " + body);
                            try {await http.put(url, headers: {"Content-Type": "application/json"}, body: body).then((http.Response response) async {
                                String body = response.body;
                                print(body);
                                var parsedJson = json.decode(body);
                                if (parsedJson['success'] as bool == true) {
                                  print(true);
                                  Navigator.of(context).pop();
                                  _showDialog(context, "Changement de mots de passe", "Mots de passe change avec succès", "Confirme");
                                } else {
                                  print(false);
                                  _showDialog(context, "Changement de mots de passe", "Erreur lors de la modification des mots de passe contactez l'administrateur", "Confirme");
                                }
                              });
                            } catch (error) {
                              print(error);
                            }
                            }else {
                              _showDialog(context, "Changement de mots de passe", "Confirmation de mots de passe est faux", "confirme");
                            }
                          }else {
                            _showDialog(context, "Changement de mots de passe", "L'ancien mots de passe est faux", "confirme");
                          }
                        });
                      }),
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