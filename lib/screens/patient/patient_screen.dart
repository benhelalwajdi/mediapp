import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/widgets/custom_clipper.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
  home: DetailPPage(),
));

class DetailPPage extends StatefulWidget {
  @override
  DetailScreen createState() => DetailScreen();
}

class DetailScreen extends State<DetailPPage> {
  bool H = false;
  bool F = false;
  bool G = false;
  bool HFC = false;
  var rating = 3.0;
  var ratingBol = true;
  var dateConsultation;
  var medicament = "";
  var malade = "";
  List<dynamic> listmed;
  List<dynamic> listIdMed = [" "];

  @override
  initState() {
    // TODO: implement initState
    dateConsultation = DateTime.parse(Constants.user["updatedAt"].toString());
    print(dateConsultation.toString());
    List<dynamic> listType = Constants.user["type"];
    for (int i = 0; i < listType.length; i++) {
      print(listType[i].toString());
      malade = malade + " " + listType[i].toString();
    }
    List<dynamic> listmed = Constants.user["medicaments"];
    for (int i = 0; i < listmed.length; i++) {
      print(listmed[i].toString());
      medicament = medicament + " " + listmed[i].toString();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget child;
    Widget childBtn;
    if (ratingBol) {
      child = SmoothStarRating(
        rating: rating,
        isReadOnly: false,
        size: 50,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_half,
        defaultIconData: Icons.star_border,
        starCount: 5,
        allowHalfRating: false,
        spacing: 2.0,
        borderColor: Colors.greenAccent,
        color: Colors.greenAccent,
        onRated: (value) {
          print("rating value -> $value");
          rating = value;
          print(rating);
        },
      );
      childBtn = InkWell(
        onTap: () {
          setState(() {
            var url = Constants.url + "/api/rates/addRates/";

            listmed = Constants.user["medicaments"];
            for (int i = 0; i < listmed.length; i++) {
              //print(listmed[i].toString());
              if (i == 0) {
                if (listmed[i].toString() == "F") {
                  listIdMed[0] = "5f48dec211eb111dc04693c8";
                } else if (listmed[i].toString() == "H") {
                  listIdMed[0] = "5f48dec211eb111dc04693c9";
                } else if (listmed[i].toString() == "G") {
                  listIdMed[0] = "5f48dec211eb111dc04693ca";
                } else if (listmed[i].toString() == "HFC") {
                  listIdMed[0] = "5f48dec211eb111dc04693cb";
                }
              } else {
                if (listmed[i].toString() == "F") {
                  listIdMed.add("5f48dec211eb111dc04693c8");
                } else if (listmed[i].toString() == "H") {
                  listIdMed.add("5f48dec211eb111dc04693c9");
                } else if (listmed[i].toString() == "G") {
                  listIdMed.add("5f48dec211eb111dc04693ca");
                } else if (listmed[i].toString() == "HFC") {
                  listIdMed.add("5f48dec211eb111dc04693cb");
                }
              }
            }

            for (int j = 0; j < listIdMed.length; j++) {
              print(listIdMed[j].toString());
              var body = jsonEncode({
                "value": rating,
                "user": Constants.user["_id"],
                "med": Constants.user["monmed"],
                "medicament": listIdMed[j],
              });

              if (j == ((listIdMed.length) - 1)) {
                ratingBol = false;
              }
              print("Body: " + body);
              http
                  .post(url,
                  headers: {"Content-Type": "application/json"}, body: body)
                  .then((http.Response response) {
                print("Response status: ${response.statusCode}");
                print("Response body: ${response.contentLength}");
                print(response.headers);
                print(response.request);
                String body = response.body;
                print(body);
                var parsedJson = json.decode(body);
                if (parsedJson['success'] as bool == true) {
                  Constants.user = parsedJson['user'];
                  print(true);
                } else {
                  print(false);
                }
              });
              print(ratingBol);
            }
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.all(15),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'ENVOYER',
                style: TextStyle(
                    color: Constants.darkBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      );
    } else {
      print(rating);
      print(ratingBol);
      child = Text(
        "",
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.w900, color: Colors.white),
      );
      childBtn = InkWell(
        onTap: () {
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.all(15),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Historique',
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

    double statusBarHeight = MediaQuery.of(context).padding.top;
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: Stack(children: <Widget>[
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
          Padding(
              padding: EdgeInsets.all(Constants.paddingSide),
              child:
              ListView(scrollDirection: Axis.vertical, children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 34,
                        child: RawMaterialButton(
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            _onWillPop();
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
                      SizedBox(
                        width: 34,
                        child: RawMaterialButton(
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {

                          },
                          child: Icon(Icons.account_circle,
                              size: 40.0, color: Colors.white),
                        ),
                      ),
                    ]),
                Text(
                  "Bonjour ! \n" + Constants.user["name"].toString() + "\n",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                SizedBox(height: 80),
                Text(
                  "DERNIERE CONSULTATION :\nLe " +
                      dateConsultation.day.toString() +
                      "/" +
                      dateConsultation.month.toString() +
                      "/" +
                      dateConsultation.month.toString() +
                      " avec Dr." +
                      Constants.b["name"],
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
                SizedBox(height: 40),
                Text(
                  "MOTIF DE CONSULTATION : " + malade.toString() + "\n",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
                Text(
                  "LACTOSE NIGELLE : " + medicament.toString() + "\n",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
                Text(
                  "Comment allez-vous aujourd’hui ?: \n",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
                child,
                childBtn,
              ]))
        ])
        )
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Vous étes sur ?'),
        content: new Text('Voulez-vous quitter une application ?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Non'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Oui'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
