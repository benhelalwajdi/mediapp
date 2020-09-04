import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/widgets/custom_clipper.dart';
import 'package:mediapp/widgets/grid_item.dart';
import 'package:mediapp/widgets/progress_vertical.dart';

import 'detail_screen.dart';
import 'newUser_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    // For Grid Layout
    double _crossAxisSpacing = 16, _mainAxisSpacing = 16, _cellHeight = 150.0;
    int _crossAxisCount = 2;

    double _width = (MediaQuery.of(context).size.width -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    double _aspectRatio =
        _width / (_cellHeight + _mainAxisSpacing + (_crossAxisCount + 1));

    return Scaffold(
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

          // BODY
          Padding(
              padding: EdgeInsets.all(Constants.paddingSide),
              child:
                  ListView(scrollDirection: Axis.vertical, children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Back Button
                      SizedBox(
                        width: 34,
                        child: RawMaterialButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                    ]
                    ),

                    Text(
                      "Bonjour ! \n Evaluation de votre etat Ajourd'hui SVP ?",

                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < 2 ? Icons.star : Icons.star_border,
                        );
                      }),
                    ),
                    ButtonBar(mainAxisSize: MainAxisSize.min,
                        // this will take space as minimum as posible(to center)
                        children: <Widget>[
                          new RaisedButton(
                            color: Colors.lightBlue,
                            child: new Text('Enregistre'),
                            onPressed:  () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen("ee","dd")),
                              );
                            },
                          ),
                          new RaisedButton(
                            color: Colors.lightBlueAccent,
                            child: new Text('Reset'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DetailPPage()),
                              );
                            },
                          ),
                        ]),
                  ]))
        ]));
  }
}
