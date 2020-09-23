import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mediapp/screens/patient/theme/color/light_color.dart';
import 'package:mediapp/utils/const.dart';

import 'helper/courseModel.dart';
import 'helper/quad_clipper.dart';
import 'theme/theme.dart';

class RecomendedPage extends StatefulWidget {
  @override
  _RecomendedPage createState() => _RecomendedPage();
}

List<CourseModel> list;
bool listIsEmpty;

class _RecomendedPage extends State<RecomendedPage> {
  double width;

  @override
  initState() {
    print(list.length);
    listIsEmpty = true;
    list = [];

    _loadRatingHistory();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      child: Column(
        children: <Widget>[
          _header(context),
          SizedBox(height: 20),
          //_categoryRow("Start a new career"),
          _courseList()
        ],
      ),
    )));
  }

  Future<void> _loadRatingHistory() async {
    var url = Constants.url +
        "/api/fich/fichByUser/" +
        Constants.user["_id"].toString();
    await http.get(url, headers: {"Content-Type": "application/json"}).then(
        (http.Response response) async {
      String body = response.body;
      print(body);
      var parsedJson = json.decode(body);
      if (parsedJson['success'] as bool == true) {
        if (parsedJson['fich'] == null) {
          print("fichier et null");
        } else {
          List<dynamic> d = parsedJson['fich'];
          String typeText = "";
          String medText = "";

          /*
               String name;
               String description;
               String university;
               String noOfCource;
               String tag1;
               String tag2;*/

          for (int i = 0; i < d.length; i++) {
            List<dynamic> type = d[i]["type"];
            for (int j = 0; j < type.length; j++) {
              typeText = typeText + " " + type[j].toString();
              print(typeText);
            }
            List<dynamic> med = d[i]["medicaments"];
            for (int j = 0; j < med.length; j++) {
              medText = medText + " " + med[j].toString();
              print(medText);
            }
            print(d[d.length - 1]["createdAt"]);
            if (list == null) {
              list[0] = new CourseModel(
                  name: "Consultation le : " +
                      DateTime.parse(Constants.user["createdAt"].toString())
                          .day
                          .toString() +
                      "/" +
                      DateTime.parse(Constants.user["createdAt"].toString())
                          .month
                          .toString() +
                      "/" +
                      DateTime.parse(Constants.user["createdAt"].toString())
                          .year
                          .toString(),
                  description: "Information de la consultation  : " + typeText,
                  noOfCource: "",
                  university: Constants.user["evaluation"].toString(),
                  tag1: medText);
              setState(() {
                listIsEmpty = false;
              });
            } else {
              list.add(new CourseModel(
                  name: "Consultation le : " +
                      DateTime.parse(Constants.user["createdAt"].toString())
                          .day
                          .toString() +
                      "/" +
                      DateTime.parse(Constants.user["createdAt"].toString())
                          .month
                          .toString() +
                      "/" +
                      DateTime.parse(Constants.user["createdAt"].toString())
                          .year
                          .toString(),
                  description:
                      "Information de la consultation : \n cas général\n"
                              "Motif : " +
                          typeText,
                  noOfCource: Constants.user["evaluation"].toString(),
                  university: "Dr Mohamed Haded",
                  tag1: "Lactose Nigelle : " + medText));
              setState(() {
                listIsEmpty = false;
              });
            }
            var birthday =
                DateTime.parse(d[d.length - 1]["createdAt"].toString());
            var date2 = DateTime.now();
          }
        }
      }
    });
  }

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 120,
          width: width,
          decoration: BoxDecoration(
            color: Constants.lightBlue,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: _circularContainer(300, Constants.lightBlue)),
              Positioned(
                  top: -60,
                  left: -65,
                  child: _circularContainer(width * .5, Constants.lightBlue)),
              Positioned(
                  top: -230,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 50,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Historique\ndes consultations",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ))),
            ],
          )),
    );
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _categoryRow(String title) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
      height: 68,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: TextStyle(
                  color: LightColor.extraDarkPurple,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: width,
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 20),
                  _chip("Data Scientist", LightColor.yellow, height: 5),
                  SizedBox(width: 10),
                  _chip("Data Analyst", LightColor.seeBlue, height: 5),
                  SizedBox(width: 10),
                  _chip("Data Engineer", LightColor.orange, height: 5),
                  SizedBox(width: 10),
                  _chip("Data Scientist", LightColor.lightBlue, height: 5),
                ],
              )),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _courseList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: ListView.builder(
            // ignore: missing_return
            itemBuilder: (context, index) {
              return !listIsEmpty
                  ? _courceInfo(
                      list[0], _decorationContainerA(Colors.black, -110, -85),
                      background: LightColor.seeBlue)
                  : Text("");
              /*Divider(
                  thickness: 1,
                  endIndent: 20,
                  indent: 20,
                  );*/
            },
            shrinkWrap: true,
            itemCount: list.length),
        /* !listIsEmpty ? _courceInfo(list[0], _decorationContainerA(Colors.lightBlue, -110, -85), background: LightColor.seeBlue): Text(""),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            !listIsEmpty ? _courceInfo(CourseList.list[1], _decorationContainerB(), background: LightColor.darkOrange): Text(""),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),*/
      ),
    );
  }

  Widget _card(
      {Color primaryColor = Colors.blueAccent,
      String imgPath,
      Widget backWidget}) {
    return Container(
        height: 190,
        width: width * .34,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  color: Color(0x12000000))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: backWidget,
        ));
  }

  Widget _courceInfo(CourseModel model, Widget decoration, {Color background}) {
    return Container(
        height: 300,
        width: width,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .2,
              child: Text(""),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text(model.name,
                            style: TextStyle(
                                color: LightColor.purple,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: background,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(model.noOfCource,
                          style: TextStyle(
                            color: LightColor.grey,
                            fontSize: 14,
                          )),
                      SizedBox(width: 10)
                    ],
                  ),
                ),
                Text(model.university,
                    style: AppTheme.h6Style.copyWith(
                      fontSize: 14,
                      color: LightColor.grey,
                    )),
                SizedBox(height: 15),
                Text(model.description,
                    style: AppTheme.h6Style.copyWith(
                        fontSize: 20, color: LightColor.extraDarkPurple)),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    _chip(model.tag1, LightColor.seeBlue, height: 5),
                    SizedBox(
                      width: 10,
                    ),
                    // _chip(model.tag2, LightColor.seeBlue, height: 5),
                  ],
                ),
                Divider(
                  thickness: 1,
                  endIndent: 20,
                  indent: 20,
                ),
              ],
            ))
          ],
        ));
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }

  Widget _decorationContainerA(Color primaryColor, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: LightColor.darkseeBlue,
          ),
        ),
        _smallContainer(LightColor.yellow, 40, 20),
        Positioned(
          top: -30,
          right: -10,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: LightColor.darkseeBlue,
            child:
                CircleAvatar(radius: 40, backgroundColor: LightColor.seeBlue),
          ),
        ),
      ],
    );
  }

  Widget _decorationContainerB() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          left: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.lightOrange2,
            child: CircleAvatar(
                radius: 30, backgroundColor: LightColor.darkOrange),
          ),
        ),
        Positioned(
            bottom: -35,
            right: -40,
            child:
                CircleAvatar(backgroundColor: LightColor.yellow, radius: 40)),
        Positioned(
          top: 50,
          left: -40,
          child: _circularContainer(70, Colors.transparent,
              borderColor: Colors.white),
        ),
      ],
    );
  }

  Widget _decorationContainerC() {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: -65,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Color(0xfffeeaea),
          ),
        ),
        Positioned(
            bottom: -30,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.yellow, radius: 40))),
        _smallContainer(
          Colors.yellow,
          35,
          70,
        ),
      ],
    );
  }

  Positioned _smallContainer(Color primaryColor, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primaryColor.withAlpha(255),
        ));
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(
        //  backgroundColor: Colors.blue,
        icon: Icon(icon),
        title: Text(""));
  }
}
