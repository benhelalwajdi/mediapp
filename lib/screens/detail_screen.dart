import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/utils/rating.dart';
import 'package:mediapp/utils/user.dart';
import 'package:mediapp/widgets/custom_clipper.dart';

import 'dashboardd.dart';

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

bool showAvg = false;

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  User item;
  DetailPage(this.item);
  @override
  DetailScreen createState() => DetailScreen(this.item);
}

class DetailScreen extends State<DetailPage> {
  bool H = false;
  bool F = false;
  bool G = false;
  // ignore: non_constant_identifier_names
  bool HFC = false;
  User user;
  List<String> listType = [""];

  void _loadData() async {
    await RatesViewModel.loadPlayers();
  }

  @override
  void initState() {
    _loadData();
    print(user.name.toString());
    for (int i = 0 ; i< user.type.length ; i++){
      if(i == 0){
        listType[i] = (user.type[i].toString());
      }else{
      print(user.type[i].toString());
      listType.add(user.type[i].toString());
      }
    }
    super.initState();
  }

  DetailScreen(this.user);

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: <Widget>[
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
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                    Spacer(),
                    Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/icons/heartbeatthin.png'),
                        height: 73,
                        width: 80,
                        color: Colors.white.withOpacity(1)),
                  ],
                ),
                Text(
                  "Nom : " + user.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                Text(
                  "Email : " + user.email.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                Text(
                  "Adresse : " + user.adress.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                Text(
                  "Télephone : " + user.tel.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                SizedBox(height: 30),
                Material(
                  shadowColor: Colors.grey.withOpacity(0.01),
                  // added
                  type: MaterialType.card,
                  elevation: 10,
                  borderRadius: new BorderRadius.circular(20.0),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 210,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Date de consultation :"),//: 27/08/2020
                            Text(DateTime.parse(user.createdAt).day.toString()+"/"+DateTime.parse(user.createdAt).month.toString()+"/"+DateTime.parse(user.createdAt).year.toString()),//: 27/08/2020
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Pathologie : "),//Infection
                            Text("")//Infection
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Prescription :"),// Lactose nigelle H"),"),
                          ]
                        ),
                      ],
                    ),
                  ), // added
                ),
                SizedBox(height: 30),
                Material(
                    shadowColor: Colors.grey.withOpacity(0.01),
                    type: MaterialType.card,
                    elevation: 10,
                    borderRadius: new BorderRadius.circular(10.0),
                    child: Container(
                        padding: EdgeInsets.all(0.0),
                        height: 360,
                        child: Column(children: <Widget>[
                          Row(children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Change type de graph : ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: <Widget>[],
                                )
                              ],
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 34,
                              child: IconButton(
                                icon: Icon(
                                  Icons.refresh,
                                  color:
                                  Colors.blue.withOpacity(showAvg ? 1.0 : 0.5),
                                ),
                                onPressed: () {
                                  setState(() {
                                    showAvg = !showAvg;
                                  });
                                },
                              ),
                            ),
                          ]),
                          showAvg
                              ? LineChart(
                                  sampleData1(RatesViewModel.Listrates),
                                  swapAnimationDuration:
                                      const Duration(milliseconds: 250),
                                )
                              : BarChart(
                                  barChartData(RatesViewModel.Listrates),
                                  swapAnimationDuration:
                                      const Duration(milliseconds: 250),
                                )
                        ]))),
                SizedBox(height: 30),
                Material(
                  shadowColor: Colors.grey.withOpacity(0.01),
                  // added
                  type: MaterialType.card,
                  elevation: 10,
                  borderRadius: new BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 100,
                    child: Column(
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              //Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboardd()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        offset: Offset(2, 4),
                                        blurRadius: 5,
                                        spreadRadius: 2)
                                  ],
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Constants.darkBlue,
                                        Constants.darkGreen
                                      ])),
                              child: Text(
                                'Archive',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ))
                      ],
                    ),
                  ), // added
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

LineChartData sampleData1(List<Rates> listrates) {
  return LineChartData(
    minX: 0,
    maxX: 14,
    maxY: 6,
    minY: 0,
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
      ),
      touchCallback: (LineTouchResponse touchResponse) {},
      handleBuiltInTouches: true,
    ),
    gridData: FlGridData(
      show: false,
    ),
    titlesData: FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,

        textStyle: const TextStyle(
          color: Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        margin: 10,
        getTitles: (value) {
          DateTime dt= DateTime.parse(listrates[0].createdAt.toString());
          DateTime dt2= DateTime.parse(listrates[1].createdAt.toString());
          switch (value.toInt()) {
            case 3:
              return dt.day.toString()+"/"+dt.month.toString();
            case 6:
              return dt2.day.toString()+"/"+dt2.month.toString();
            case 9:
              return dt2.day.toString()+"/"+dt2.month.toString();
            case 12:
              return dt2.day.toString()+"/"+dt2.month.toString();
          }
          return '';
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        textStyle: const TextStyle(
          color: Color(0xff75729e),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '1';
            case 2:
              return '2';
            case 3:
              return '3';
            case 4:
              return '4';
            case 5:
              return '5';
          }
          return '';
        },
        margin: 0,
        reservedSize: 20,
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: const Border(
        bottom: BorderSide(
          color: Color(0xff4e4965),
          width: 2,
        ),
        left: BorderSide(
          color: Colors.transparent,
        ),
        right: BorderSide(
          color: Colors.transparent,
        ),
        top: BorderSide(
          color: Colors.transparent,
        ),
      ),
    ),

    lineBarsData: linesBarData1(listrates),
  );
}

List<LineChartBarData> linesBarData1(listrates) {
  final LineChartBarData lineChartBarData1 = LineChartBarData(
    spots: [
      FlSpot(3, double.parse(listrates[1].value.toString()+".0")),
      FlSpot(6, double.parse(listrates[0].value.toString()+".0")),
      FlSpot(9, double.parse(listrates[0].value.toString()+".0")),
      FlSpot(12, double.parse(listrates[1].value.toString()+".0")),
    ],
    isCurved: true,
    colors: [
      const Color(0xff4af699),
    ],
    barWidth: 8,
    isStrokeCapRound: false,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(
      show: false,
    ),
  );

  final LineChartBarData lineChartBarData2 = LineChartBarData(
    spots: [
      FlSpot(1, 1),
      FlSpot(3, 2.8),
      FlSpot(7, 1.2),
      FlSpot(10, 2.8),
      FlSpot(12, 2.6),
      FlSpot(13, 3.9),
    ],
    isCurved: true,
    colors: [
      const Color(0xffaa4cfc),
    ],
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(show: false, colors: [
      const Color(0x00aa4cfc),
    ]),
  );

  final LineChartBarData lineChartBarData3 = LineChartBarData(
    spots: [
      FlSpot(1, 2.8),
      FlSpot(3, 1.9),
      FlSpot(6, 3),
      FlSpot(10, 1.3),
      FlSpot(13, 2.5),
    ],
    isCurved: true,
    colors: const [
      Colors.black,
    ],
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(
      show: false,
    ),
  );

  return [
    lineChartBarData1,
    //lineChartBarData2,
    //lineChartBarData3,
  ];
}

/*List<LineChartBarData> linesBarData2() {
  return [
    LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 4),
        FlSpot(5, 1.8),
        FlSpot(7, 5),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      curveSmoothness: 0,
      colors: const [
        Color(0x444af699),
      ],
      barWidth: 6,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    ),
    LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: false,
      colors: const [
        Color(0x99aa4cfc),
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(show: true, colors: [
        const Color(0x33aa4cfc),
      ]),
    ),
    LineChartBarData(
      spots: [
        FlSpot(1, 3.8),
        FlSpot(3, 1.9),
        FlSpot(6, 5),
        FlSpot(10, 3.3),
        FlSpot(13, 4.5),
      ],
      isCurved: true,
      curveSmoothness: 0,
      colors: const [
        Colors.black,
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(
        show: false,
      ),
    ),
  ];
}*/


// bar Chart
BarChartData barChartData(List<Rates> listrates) {
  const double barWidth = 22;
  return BarChartData(
    alignment: BarChartAlignment.center,
    maxY: 6,
    minY: 0,
    groupsSpace: 30,
    barTouchData: BarTouchData(
      enabled: true,
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        textStyle: const TextStyle(color: Colors.black, fontSize: 10),
        margin: 10,
        rotateAngle: 0,
        getTitles: (double value) {
          DateTime dt= DateTime.parse(listrates[0].createdAt.toString());
          DateTime dt2= DateTime.parse(listrates[1].createdAt.toString());
          switch (value.toInt()) {
            case 0:
              return dt.day.toString()+"/"+dt.month.toString()+"/"+dt.year.toString();
            case 1:
              return dt2.day.toString()+"/"+dt2.month.toString()+"/"+dt2.year.toString();
            default:
              return '';
          }
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        textStyle: const TextStyle(
          color: Color(0xff75729e),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '1';
            case 2:
              return '2';
            case 3:
              return '3';
            case 4:
              return '4';
            case 5:
              return '5';
          }
          return '';
        },
        margin: 8,
        reservedSize: 30,
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    barGroups: [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            y: double.parse(listrates[0].value.toString()+".0"),
            width: barWidth,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItem: [
              BarChartRodStackItem(0, double.parse(listrates[0].value.toString()+".0"), const Color(0xff2bdb90)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            y: double.parse(listrates[1].value.toString()+".0"),
            width: barWidth,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItem: [
              BarChartRodStackItem(0, double.parse(listrates[1].value.toString()+".0"), const Color(0xffffdd80)),
            ],
          ),
        ],
      ),

      /*
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            y: 3.5,
            width: barWidth,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItem: [
              BarChartRodStackItem(0, 1.5, const Color(0xff2bdb90)),
              BarChartRodStackItem(1.5, 3, const Color(0xffffdd80)),
              BarChartRodStackItem(3, 5, const Color(0xffff4d94)),
              BarChartRodStackItem(5, 3.5, const Color(0xff19bfff)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            y: 5,
            width: barWidth,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItem: [
              BarChartRodStackItem(0, 1.2, const Color(0xff2bdb90)),
              BarChartRodStackItem(1.2, 3, const Color(0xffffdd80)),
              BarChartRodStackItem(4, 1, const Color(0xffff4d94)),
              BarChartRodStackItem(5, 4, const Color(0xff19bfff)),
            ],
          ),
        ],
      ),*/
    ],
  );
}