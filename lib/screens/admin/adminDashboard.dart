import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediapp/screens/admin/chartpathologie.dart';
import 'package:mediapp/screens/admin/chartporduit.dart';
import 'package:mediapp/screens/med/GraphProduits.dart';
import 'package:mediapp/screens/admin/ListMed/ListMed.dart';
import 'package:mediapp/screens/admin/detail_all.dart';
import 'package:mediapp/screens/loginPage.dart';
import 'package:mediapp/screens/patient/change_password.dart';
import 'package:mediapp/utils/const.dart';

import 'ajoutMed.dart';
import 'detail_med.dart';

// ignore: camel_case_types
class adminDashboardd extends StatefulWidget {
  @override
  Dashboarddd createState() => new Dashboarddd();
}
class Dashboarddd extends State<adminDashboardd> {

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    _showDialog(context, "test", "test", "test");
    super.dispose();
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
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginPage())),
            child: new Text('Oui'),
          ),
        ],
      ),
    )) ?? false;
  }
  @override
  Widget build(BuildContext context)
  {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        body: new Center(
          child:  Column(
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 34,
                          child: RawMaterialButton(
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          newPassword()));
                            },
                            child: Icon(Icons.account_circle,
                                size: 40.0, color: Colors.black),
                          ),
                        ), SizedBox(
                          height: 4,
                        ),
                        Text(
                          Constants.user["name"],
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          width: 34,
                          child: RawMaterialButton(
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          newPassword()));
                            },
                            child: Icon(Icons.account_circle,
                                size: 40.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GridDashboard()
            ],
          ),
        ),
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Items item1 =
    new Items(pos: 1, title: "Ajouter", img: "assets/icons/add-icon.png");

    Items item2 = new Items(
      pos: 2,
      title: "List des Medicien ",
      img: "assets/icons/list.png",
    );
    Items item3 = new Items(
      pos: 3,
      title: "Graph. Produit",
      img: "assets/icons/graph.png",
    );
    Items item4 = new Items(
      pos: 4,
      title: "Graph Pathologie",
      img: "assets/icons/graph.png",
    );
    Items item5 = new Items(
      pos: 5,
      title: "Graph Combine",
      img: "assets/icons/graph.png",
    );
    Items item6 = new Items(
      pos: 6,
      title: "Historique",
      img: "assets/icons/order-history.png",
    );
    Items item7 = new Items(
      pos: 7,
      title: "Aperçu",
      img: "assets/icons/graph.png",
    );
    List<Items> myList = [item1, item2, item3, item4/*, item5, item6*/, item7];
    return Flexible(
        child: GridView.count(
            childAspectRatio: 1.0,
            padding: EdgeInsets.only(left: 16, right: 16),
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            children: myList.map((data) {
              return Container(
                decoration: BoxDecoration(
                    color: Constants.lightBlue,
                    borderRadius: BorderRadius.circular(10)),
                child: InkResponse(
                  enableFeedback: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        data.img,
                        width: 42,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.title,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  onTap: () => _onTileClicked(context, data.pos),
                ),
              );
            }).toList()
        )
    );
  }
}

void _onTileClicked(BuildContext context, int index) {
  debugPrint("You tapped on item $index");
  if (index == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ajoutMed()),
    );
  } else if (index == 2) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListMed()),
    );
  } else if (index == 3) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => chartproduit()),
    );
  } else if (index == 4) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => chartpathologie()),
    );
  }  /*else if (index == 5) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  } else if (index == 6) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );}*/
    else if (index == 7) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Detailall()),
    );
  }
}
class Items {
  int pos;
  String title;
  String img;
  Items({
    this.pos,
    this.title,
    this.img,
  });
}
