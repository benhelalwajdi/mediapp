import 'dart:convert';
import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/utils/rating.dart';
import 'package:mediapp/utils/user.dart';
import 'package:mediapp/widgets/custom_clipper.dart';
import 'package:http/http.dart' as http;

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

bool showAvg = false;
bool isNull = true;
List<Rates> Listrates = [];

// ignore: must_be_immutable
class Detailall extends StatefulWidget {
  @override
  DetailScreen createState() => DetailScreen();
}

class DetailScreen extends State<Detailall> {
  bool H = false;
  bool F = false;
  bool G = false;
  bool HFC = false;
  List<String> listType = [""];
  var medicament = " ";
  var medicaments = " ";
  List<User> med = [];
  int numberAllMed = 0 ;

  Future<void> loadallMed() async {
    var url = Constants.url+"/api/admin/allUsersByRole/med";
    await http.get(url, headers: {"Content-Type": "application/json"}).then(
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
            User us = new User.fromJson(parsedJson[i]);
            print(us.createdAt.toString());
            if(i==0){
              user2 = [us];
            }
            if(i != 0){
              user2.add(us);
            }
            print(us.email.toString());
          }
          setState(() {
            med = user2;
            try{
              numberAllMed = med.length;
            }catch(error){
              numberAllMed = 0 ;
            }
          });
        });
  }
  List<User> pat = [];
  int numberAllpat = 0 ;

  Future<void> loadallpat() async {
    var url = Constants.url+"/api/admin/allUsersByRole/pat";
    await http.get(url, headers: {"Content-Type": "application/json"}).then(
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
            User us = new User.fromJson(parsedJson[i]);
            print(us.createdAt.toString());
            if(i==0){
              user2 = [us];
            }
            if(i != 0){
              user2.add(us);
            }
            print(us.email.toString());
          }
          setState(() {
            pat = user2;
            try{
              numberAllpat = pat.length;
            }catch(error){
              numberAllpat = 0 ;
            }
          });
        });
  }
  Future<bool> _loadData() async {
    await loadallMed();
  }

  Future<bool> _loadData2() async {
    await loadallpat();
  }

  @override
  void dispose() {
    super.dispose();
    isNull = true ;
    Listrates = [];
  }

  @override
  initState() {
    _loadData();
    _loadData2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(isNull.toString() + "in build");
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Constants.lightBlue,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),

          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),
          // BODY
          Padding(
            padding: EdgeInsets.all(Constants.paddingSide),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 34,
                      child: RawMaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios,
                            size: 15.0, color: Colors.white),
                        shape: CircleBorder(
                          side: BorderSide(
                              color: Colors.white,
                              width: 2,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    Spacer(),
                    Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/icons/heartbeatthin.png'),
                        height: 73,
                        width: 80,
                        color: Colors.white.withOpacity(1)),
                  ],
                ),
                Text(
                  "Dr ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                Text(
                  "Email : ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                SizedBox(height: 30),
                Material(
                  shadowColor: Colors.grey.withOpacity(0.01),
                  // added
                  type: MaterialType.card,
                  elevation: 10,
                  borderRadius: new BorderRadius.circular(20.0),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 600,
                    width:  400,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Télephone : \n-" ,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),//Infection
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Adresse : \n-" ,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Nombre de patient : \n - " + numberAllMed.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Appréciation moyenne : \n - ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                            ]),
                      ],
                    ),
                  ), // added
                ),
                ],
            ),
          ),
        ],
      ),
    );
  }
}
