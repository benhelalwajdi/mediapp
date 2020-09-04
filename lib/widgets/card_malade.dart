import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/widgets/custom_clipper.dart';

class Cardmalade extends StatefulWidget {
  final String title;
  final ImageProvider image;
  bool isDone;

  Cardmalade({Key key,
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

class _MyHomePageState extends State<Cardmalade> {
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
                                  Constants.list_malade.add(title.toString());
                                  print(Constants.list_malade.length);
                                  for (int i = 0 ; i<Constants.list_malade.length ; i++){
                                    print(i);
                                    print(Constants.list_malade.toString());
                                  }
                                  //isDone = !isDone;
                                }else {
                                  icon = Icons.remove;
                                  print(isDone);
                                  for (int i = 0 ; i<Constants.list_malade.length ; i++){
                                    print(i);
                                    print(Constants.list_malade[i]);
                                    if(Constants.list_malade[i] == title.toString()){
                                      Constants.list_malade.removeAt(i);
                                    }
                                    print(Constants.list_malade.toString());
                                  }
                                  //isDone = !isDone;
                                }
                                isDone = !isDone;


                                /*if(isDone){
                                  /*for (int i = 0 ; i<Constants.list_malade.length ; i++){
                                    print(i);
                                    print(Constants.list_malade[i]);
                                    /*if(Constants.list_malade[i] == title.toString()){
                                      Constants.list_malade.removeAt(i);
                                    }*/
                                  }*/

                                  icon = Icons.check;
                                  print("object");
                                  int j = Constants.list_malade.indexOf(title.toString());
                                  print(Constants.list_malade.indexOf(title.toString()));
                                  for (int i = 0 ; i<Constants.list_malade.length ; i++){
                                    print(i);
                                    print(Constants.list_malade[i]);
                                  }

                                }else{
                                  print(isDone.toString());
                                  icon = Icons.remove;
                                  Constants.list_malade.add(title.toString());
                                  print(Constants.list_malade.length);
                                  for (int i = 0 ; i<Constants.list_malade.length ; i++){
                                    print(i);
                                    print(Constants.list_malade[i]);
                                  }
                                }*/
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
