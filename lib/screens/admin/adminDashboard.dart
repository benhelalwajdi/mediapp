import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediapp/screens/GraphProduits.dart';
import 'package:mediapp/screens/admin/ListMed/ListMed.dart';
import 'package:mediapp/screens/loginPage.dart';
import 'package:mediapp/utils/const.dart';

import 'ajoutMed.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
      img: "assets/icons/order-history.png",
    );
    List<Items> myList = [item1, item2, item3, item4, item5, item6, item7];
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
      MaterialPageRoute(builder: (context) => GraphProduits()),
    );
  } else if (index == 4) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  } else if (index == 5) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  } else if (index == 6) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
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
