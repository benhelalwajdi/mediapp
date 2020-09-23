import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mediapp/screens/patient/product_card.dart';
import 'package:mediapp/utils/const.dart';
import 'package:http/http.dart' as http;


class historique extends StatefulWidget {
  historique({Key key})
      : super(key: key);

  @override
  body createState() => body();
}


class body extends State<historique> with SingleTickerProviderStateMixin {


  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController controller;
  Animation<double> scaleAnimation;
  Animation<double> menuScaleAnimation;
  Animation<Offset> slideAnimation;

  get listIdMed => null;
  var length = 0;

  List<rating> lr = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          dashboard(context),
        ],
      ),
    );
  }

  @override
  void initState() {
    _load();
    controller = AnimationController(vsync: this, duration: duration);
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(controller);
    menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(controller);
    slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(controller);
    super.initState();
  }

  Widget dashboard(context) {
    String strDate = "";
    return AnimatedPositioned(
      duration: duration,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Material(
          color: Constants.lightBlue,
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Colors.grey,
                      Constants.lightBlue,
                    ],
                    begin: const FractionalOffset(1.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              //color: Constants.lightBlue,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 35 ,bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 34,
                    child: RawMaterialButton(
                      materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        Navigator.of(context).pop(true);
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
                  ListView.builder(
                      itemBuilder: (context, index) {
                        return ProductCard(
                          itemIndex: index,
                          rate : lr[index].rate.toString(),
                          medicament : lr[index].medicament,
                          date : DateTime.parse(lr[index].date)
                        );
                      },
                      shrinkWrap: true,
                      itemCount: length),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _load() async {
    var url = Constants.url + "/api/rates/ratesByUser/" + Constants.user["_id"].toString();
    await http.get(url, headers: {"Content-Type": "application/json"}).then((http.Response response) async {
          String body = response.body;
          print(body);
          var parsedJson = json.decode(body);
          if (parsedJson['success'] as bool == true) {
            if (parsedJson['rates'] == null) {
              print(parsedJson['rates']);
            } else {
              print(parsedJson['rates']);
              var parsedJson2 = parsedJson['rates'];
              List<rating> lrs =[];
              print(parsedJson2);
              for (int i = parsedJson2.length-1 ; i >= 0; i--){
                print(i);
                var med ;
                if (parsedJson2[i]["medicament"].toString() == "5f48dec211eb111dc04693c8") {
                  med = "F";
                } else if (parsedJson2[i]["medicament"].toString() == "5f48dec211eb111dc04693c9") {
                  med="H";
                } else if (parsedJson2[i]["medicament"].toString()== "5f48dec211eb111dc04693ca") {
                  med= "G";
                } else if (parsedJson2[i]["medicament"].toString() == "5f48dec211eb111dc04693cb") {
                  med= "HFC";
                }
                var user = new rating(rate: parsedJson2[i]["value"],date: parsedJson2[i]["createdAt"], medicament: med);
                lrs.add(user);
              }

              setState(() {
                lr = lrs;
                length = lrs.length;
              });
            }
          }
    });
  }
}
class rating {
  var rate;
  var date;
  var medicament;

  rating({
    this.rate,
    this.date,
    this.medicament,
  });
}

