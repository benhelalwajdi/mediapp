import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/widgets/custom_clipper.dart';

class CardSection extends StatefulWidget {
  final String title;
  final String value;
  final String unit;
  final String time;
  final ImageProvider image;
  bool isDone;

  CardSection({Key key,
    @required this.title,
    @required this.value,
    @required this.unit,
    @required this.time,
    @required this.image,
    this.isDone})
      : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState(
    image: this.image,
    title: this.title,
    value: this.value,
    unit: this.unit,
    time: this.time,
    isDone: true,
  );
}

class _MyHomePageState extends State<CardSection> {
  var title;
  var value;
  var unit;
  var time;
  var image;
  var isDone;
  var icon ;

  _MyHomePageState({Key key,
    @required this.title,
    @required this.value,
    @required this.unit,
    @required this.time,
    @required this.image,
    this.isDone});

  @override
  Widget build(BuildContext context) {
    if (isDone){

      icon = Icons.remove;
    }else {

      icon= Icons.check;
    }
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
                  padding: EdgeInsets.only(left: 30,right: 0,top: 0,bottom: 0),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              time,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Constants.textPrimary
                              ),
                          ),
                        ],
                      ),
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
                                Text('$value $unit',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Constants.textPrimary
                                    ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                print(title +" "+ isDone.toString());
                                if(isDone){
                                  icon= Icons.check;
                                  print(isDone);
                                  Constants.list_medica.add(title.toString());
                                  print(Constants.list_medica.length);
                                  for (int i = 0 ; i<Constants.list_medica.length ; i++){
                                    print(i);
                                    print(Constants.list_medica.toString());
                                  }
                                  //isDone = !isDone;
                                }else {
                                  icon = Icons.remove;
                                  print(isDone);
                                  for (int i = 0 ; i<Constants.list_medica.length ; i++){
                                    print(i);
                                    print(Constants.list_medica[i]);
                                    if(Constants.list_medica[i] == title.toString()){
                                      Constants.list_medica.removeAt(i);
                                    }
                                    print(Constants.list_medica.toString());
                                  }
                                  //isDone = !isDone;
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
                                child:
                                Icon(
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
