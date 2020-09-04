import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/widgets/custom_clipper.dart';

class Cardeval extends StatefulWidget {
  final String title;
  final ImageProvider image;
  bool isDone;

  Cardeval({Key key,
    @required this.title,
    @required this.image,
    this.isDone})
      : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState(
    image: this.image,
    title: this.title,
    isDone: true,
  );
}

class _MyHomePageState extends State<Cardeval> {
  var title;
  var image;
  var isDone;
  var icon = Icons.remove;
  // ignore: non_constant_identifier_names

  _MyHomePageState({Key key,
    @required this.title,
    @required this.image,
    this.isDone});

  @override
  Widget build(BuildContext context) {
    /*if (isDone){
      icon = Icons.remove;
    }else {
      icon= Icons.check;
    }*/
    return Align(
        alignment: Alignment.center,
        child: Container(
            margin: const EdgeInsets.only(right: 15.0),
            width: 400,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              shape: BoxShape.rectangle,
              color: Colors.white,
            ),
            child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Constants.textPrimary
                                    ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              setState(() {
                                print(title +" "+ isDone.toString());
                                if(isDone){
                                  icon= Icons.check;
                                  print(isDone);
                                  Constants.list_jour.add(title.toString());
                                  print(Constants.list_jour.length);
                                  for (int i = 0 ; i<Constants.list_jour.length ; i++){
                                    print(i);
                                    print(Constants.list_jour.toString());
                                  }
                                }else {
                                  icon = Icons.remove;
                                  print(isDone);
                                  for (int i = 0 ; i<Constants.list_jour.length ; i++){
                                    print(i);
                                    print(Constants.list_jour[i]);
                                    if(Constants.list_jour[i] == title.toString()){
                                      Constants.list_jour.removeAt(i);
                                    }
                                    print(Constants.list_jour.toString());
                                  }
                                }
                                isDone = !isDone;
                                });
                            },
                            child: Container(
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                shape: BoxShape.rectangle,
                                color: !isDone ? Theme.of(context).accentColor : Color(0xFFF0F4F8),
                              ),
                              width: 44,
                              height: 24,
                              child: Center(
                                child: Icon(
                                  icon,
                                  color: !isDone ? Colors.white : Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
        ),
    );
  }
}
