import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mediapp/screens/med/dashboardd.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/utils/user.dart';
import 'package:mediapp/widgets/card_eval.dart';
import 'package:mediapp/widgets/card_malade.dart';
import 'package:mediapp/widgets/card_section.dart';

class newFich extends StatefulWidget {
  User user ;
  newFich(this.user);
  @override
  _MyHomePageState createState() => _MyHomePageState(user);
}

class _MyHomePageState extends State<newFich> {
  User user ;
  _MyHomePageState(this.user);
  final prenomController = TextEditingController();
  final nomController = TextEditingController();
  final usernomController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  DateTime now = DateTime.now();
  DateTime birthDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    Constants.list_medica = [""];
    Constants.list_malade = [""];
    Constants.list_jour = [""];
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
                        "Nouveaux,\nFiche medical \nDate : ${this.now.day}/${this.now.month}/${this.now.year}  \n",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Motif de consultation :",
                        style: TextStyle(
                          color: Constants.lightPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          icon: new Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                          onPressed: () {
                            showDialog(
                                child: new Dialog(
                                  child: new Column(
                                    children: <Widget>[
                                      Container(
                                          height: 500,
                                          child: ListView(
                                            scrollDirection: Axis.vertical,
                                            children: <Widget>[
                                              SizedBox(height: 10),
                                              Cardmalade(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "Rhumatologie",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              Cardmalade(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "Cardiologie",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              Cardmalade(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "Pneumologie",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              Cardmalade(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "Nephrologie",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              Cardmalade(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "Dermatologie",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              Cardmalade(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "Endocrinologie",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              Cardmalade(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "Traumatologie",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              Cardmalade(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "Infections",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              Cardmalade(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "Psychologie",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              Cardmalade(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "Etat général",
                                                isDone: false,
                                              )
                                            ],
                                          )),
                                      new FlatButton(
                                        child: new Text("confirme"),
                                        onPressed: () {
                                          print(prenomController.text);
                                          print(nomController.text);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                context: context);
                          }),
                      Text(
                        "",
                        style: TextStyle(
                          color: Constants.lightPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Prescription :",
                        style: TextStyle(
                          color: Constants.lightPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          icon: new Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                          onPressed: () {
                            showDialog(
                                child: new Dialog(
                                  child: new Column(
                                    children: <Widget>[
                                      Container(
                                          height: 500,
                                          child: ListView(
                                            scrollDirection: Axis.vertical,
                                            children: <Widget>[
                                              SizedBox(height: 10),
                                              CardSection(
                                                image: AssetImage(
                                                    'assets/icons/capsule.png'),
                                                title: "F",
                                                value: "",
                                                unit: "",
                                                time: "",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              CardSection(
                                                image: AssetImage(
                                                    'assets/icons/capsule.png'),
                                                title: "G",
                                                value: "",
                                                unit: "",
                                                time: "",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              CardSection(
                                                image: AssetImage(
                                                    'assets/icons/capsule.png'),
                                                title: "H",
                                                value: "",
                                                unit: "",
                                                time: "",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              CardSection(
                                                image: AssetImage(
                                                    'assets/icons/capsule.png'),
                                                title: "HFC",
                                                value: "",
                                                unit: "",
                                                time: "",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              CardSection(
                                                image: AssetImage(
                                                    'assets/icons/capsule.png'),
                                                title: "Allopathie",
                                                value: "",
                                                unit: "",
                                                time: "",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              CardSection(
                                                image: AssetImage(
                                                    'assets/icons/capsule.png'),
                                                title: "Homeopathie",
                                                value: "",
                                                unit: "",
                                                time: "",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              CardSection(
                                                image: AssetImage(
                                                    'assets/icons/capsule.png'),
                                                title: "Acupuncture",
                                                value: "",
                                                unit: "",
                                                time: "",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              CardSection(
                                                image: AssetImage(
                                                    'assets/icons/capsule.png'),
                                                title: "Phyto",
                                                value: "",
                                                unit: "",
                                                time: "",
                                                isDone: false,
                                              )
                                            ],
                                          )),
                                      new FlatButton(
                                        child: new Text("confirme"),
                                        onPressed: () {
                                          print(prenomController.text);
                                          print(nomController.text);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                context: context);
                          }),
                      Text(
                        "",
                        style: TextStyle(
                          color: Constants.lightPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),

                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Evaluation :",
                        style: TextStyle(
                          color: Constants.lightPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          icon: new Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                          onPressed: () {
                            showDialog(
                                child: new Dialog(
                                  child: new Column(
                                    children: <Widget>[
                                      Container(
                                          height: 400,
                                          child: ListView(
                                            scrollDirection: Axis.vertical,
                                            children: <Widget>[
                                              SizedBox(height: 10),
                                              Cardeval(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "1*/Jour",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              Cardeval(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "1*/Semaine",
                                                isDone: false,
                                              ),
                                              SizedBox(height: 10),
                                              Cardeval(
                                                image: AssetImage(
                                                    'assets/icons/heartbeat.png'),
                                                title: "1*/Mois",
                                                isDone: false,
                                              ),
                                            ],
                                          )),
                                      new FlatButton(
                                        child: new Text("confirme"),
                                        onPressed: () {
                                          print(prenomController.text);
                                          print(nomController.text);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                context: context);
                          }),
                      Text(
                        "",
                        style: TextStyle(
                          color: Constants.lightPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
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

                        print(Constants.list_malade.toString());
                        print(Constants.list_medica.toString());
                        print(Constants.list_jour.toString());
                        var body = jsonEncode({
                          "evaluation": Constants.list_jour[1],
                          "type": Constants.list_malade,
                          "medicaments": Constants.list_medica,
                        });
                        print("Body: " + body);
                        try {
                                var body = jsonEncode({
                                  "user": user.id.toString(),
                                  "medicaments": Constants.list_medica,
                                  "type": Constants.list_malade,
                                  "his": "true"
                                });
                                var url = Constants.url + "/api/fich/addfich";
                                await http
                                    .post(url,
                                    headers: {
                                      "Content-Type": "application/json"
                                    },
                                    body: body)
                                    .then((http.Response response) {
                                  print(
                                      "Response status: ${response.statusCode}");
                                  print(
                                      "Response body: ${response.contentLength}");
                                  print(response.headers);
                                  print(response.request);
                                  String body = response.body;
                                  print(body);
                                  var parsedJson = json.decode(body);
                                  if (parsedJson['success'] as bool == true) {
                                    print(true);
                                  }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboardd()),
                              );
                          });
                        } catch (error) {
                          print(error);
                        }
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
