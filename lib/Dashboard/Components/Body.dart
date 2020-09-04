import 'dart:async';
import 'dart:convert';
import 'package:calendar_vertical_scroll/calendar_vertical_scroll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/Dashboard/Components/product_card.dart';
import 'package:mediapp/screens/newUser_screen.dart';
import 'package:mediapp/utils/const.dart';
import '../Dashboard.dart';
import 'Background.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class body extends State<Dashboard> with SingleTickerProviderStateMixin {
  var first = true;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController controller;
  Animation<double> scaleAnimation;
  Animation<double> menuScaleAnimation;
  Animation<Offset> slideAnimation;
  final prenom_Controller = TextEditingController();
  final nom_Controller = TextEditingController();

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: duration);
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(controller);
    menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(controller);
    slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      build(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          menu(context, slideAnimation, menuScaleAnimation),
          dashboard(context),
        ],
      ),
    );
  }

  // ignore: missing_return
  Widget dashboard(context) {
    String strDate = "";
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left:  0 * screenWidth,
      right:  0 * screenWidth,
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
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.black),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              controller.forward();
                            else
                              controller.reverse();
                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text(
                        'Liste des patients',
                        textScaleFactor: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 8),
                      ),
                      IconButton(
                          icon: new Icon(Icons.add, color: Colors.black),
                          onPressed: () {
                            showDialog(
                                child: new Dialog(
                                  child: new Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 30,
                                      ),
                                      TextField(
                                          controller: nom_Controller,
                                          decoration: InputDecoration(
                                              hintText: "Nom :",
                                              border: InputBorder.none,
                                              fillColor: Color(0xfff3f3f4),
                                              filled: true)),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      TextField(
                                          controller: prenom_Controller,
                                          decoration: InputDecoration(
                                              hintText: "Prénom :",
                                              border: InputBorder.none,
                                              fillColor: Color(0xfff3f3f4),
                                              filled: true)),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      RaisedButton(
                                          onPressed: () async {
                                            strDate = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => CalendarChoose(
                                                      Calendar.BIRTHDAY,
                                                      currentDateFontColor: Colors.blue,
                                                      currentDateBackgroundColor:
                                                      Colors.amberAccent,
                                                      selectionBackgroundColor: Colors.amber,
                                                      selectionFontColor: Colors.green,
                                                    )));
                                            if (strDate == null) strDate = "";
                                          },
                                          child: Text("Birthday")),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      new FlatButton(
                                        child: new Text("Save"),
                                        onPressed: () {
                                          /*setState((){
                                        this._text = _c.text;
                                      });*/
                                          print(prenom_Controller.text);
                                          print(nom_Controller.text);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(nom_Controller.text,prenom_Controller.text)),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                context: context);
                          }
                          ),
                    ],
                  ),
                  SizedBox(height: 5),
                  ListView.builder(
                      itemBuilder: (context, index) {
                        return ProductCard(
                          itemIndex: index,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(nom_Controller.text, prenom_Controller.text)),
                            );
                          },
                        );
                      },
                      shrinkWrap: true,
                      itemCount: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
