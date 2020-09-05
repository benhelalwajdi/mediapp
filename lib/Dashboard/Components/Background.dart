import 'package:flutter/material.dart';
import 'package:mediapp/screens/dashboardd.dart';
import 'package:mediapp/screens/profil.dart';


Widget menu(BuildContext context, Animation<Offset> slideAnimation,
    Animation<double> menuScaleAnimation) {
  return SlideTransition(
    position: slideAnimation,
    child: ScaleTransition(
      scale: menuScaleAnimation,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Text("Dashboard", style: TextStyle(color: Colors.black, fontSize: 22)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Dashboardd()));
                },
                child: new Text("Dashboard",
                    style: TextStyle(color: Colors.black, fontSize: 22)),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                child: new Text("Profile",
                    style: TextStyle(color: Colors.black, fontSize: 22)),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  /*Navigator.push(
                      context, MaterialPageRoute(builder: (context) => DetailPage()));
                */},
                child: new Text("Statistique",
                    style: TextStyle(color: Colors.black, fontSize: 22)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
