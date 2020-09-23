import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/utils/user.dart';

// ignore: camel_case_types
class chartpathologie extends StatefulWidget {
  final Widget child;

  chartpathologie({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<chartpathologie> {
  List<charts.Series<Pollution, String>> _seriesData;
  List<charts.Series<Task, String>> _seriesPieData;
  List<charts.Series<Sales, int>> _seriesLineData;
  List<User> user = [];
  List<RateOfMed> lrate = [];
  bool isnotEmpty = false;

  _generateData() async {
    List<RateOfMed> lrate2 = [];
    var url = Constants.url +
        "/api/admin/allUsersByRole/pat";
    var med = "0";
    var med2 = "0";
    await http.get(url, headers: {"Content-Type": "application/json"}).then(
            (http.Response response) async {
          String body = response.body;
          List<dynamic> parsedJson = json.decode(body);
          List<User> user2;

          for (int i = 0; i < parsedJson.length; i++) {
            User us = new User.fromJson(parsedJson[i]);
            if (i == 0) {
              user2 = [us];
            }
            if (i != 0) {
              user2.add(us);
            }
            for (int i = 1; i < us.medicaments.length; i++) {
              if (us.medicaments[i].toString() == "F") {
                med = "5f48dec211eb111dc04693c8";
                med2 = us.medicaments[i].toString();
              } else if (us.medicaments[i].toString() == "H") {
                med = "5f48dec211eb111dc04693c9";
                med2 = us.medicaments[i].toString();
              } else if (us.medicaments[i].toString() == "G") {
                med = "5f48dec211eb111dc04693ca";
                med2 = us.medicaments[i].toString();
              } else if (us.medicaments[i].toString() == "HFC") {
                med = "5f48dec211eb111dc04693cb";
                med2 = us.medicaments[i].toString();
              }
            }


            var url =
                Constants.url + "/api/rates/ratesByMedicament/" + med.toString();
            await http.get(url, headers: {"Content-Type": "application/json"}).then(
                    (http.Response response) {
                  String body = response.body;
                  List<dynamic> listRates;
                  Map<String, dynamic> parsedJson = json.decode(body);
                  for (int i = 0; i < parsedJson["rates"].length; i++) {
                    listRates = parsedJson["rates"];
                    RateOfMed rates2 = new RateOfMed(listRates[i]["value"], med2,
                        DateTime.parse(listRates[i]["createdAt"]));
                    if (lrate2 == null) {
                      lrate2[0] = rates2;
                    } else {
                      lrate2.add(rates2);
                    }
                    print("in  refresh");
                    if (i == parsedJson["rates"].length - 1) {
                      print("in  refresh");
                      setState(() {
                        lrate = lrate2;
                      });
                    }
                  }

                  List<Pollution> data1 = [];
                  List<Pollution> data2 = [];
                  List<Pollution> data3 = [];

                  List<Sales> linesalesdata = [
                  ];
                  var linesalesdata1 = [
                    new Sales(0, 3),
                    new Sales(1, 4),
                    new Sales(2, 4),
                    new Sales(3, 5),
                    new Sales(4, 5),
                    new Sales(5, 6),
                  ];

                  var linesalesdata2 = [
                    new Sales(0, 2),
                    new Sales(1, 2),
                    new Sales(2, 2),
                    new Sales(3, 4),
                    new Sales(4, 4),
                    new Sales(5, 6),
                  ];

                  for (int i = 1; i < us.type.length; i++) {
                    print(us.type[i]);
                  }
                  for (int i = 0; i < lrate.length; i++) {

                    for (int i = 1; i < us.type.length; i++) {
                    print(lrate[i].mal.toString());
                    print(lrate[i].rate.toString());
                    DateTime date2 = DateTime.now();
                    var difference = date2.difference(lrate[i].date).inHours;
                    var difference2 = date2.difference(lrate[i].date).inDays;
                    if (difference < 24) {
                      print("difference : " + difference.toString());
                      data1.add(new Pollution(
                          lrate[i].date.year, us.type[i].toString(), lrate[i].rate));
                    } else {
                      if (difference2 < 7) {
                        data2.add(new Pollution(
                            lrate[i].date.year, us.type[i].toString(), lrate[i].rate));
                      } else {
                        data3.add(new Pollution(
                            lrate[i].date.year, us.type[i].toString(), lrate[i].rate));
                      }
                    }
                    linesalesdata.add(new Sales(lrate[i].date.day, lrate[i].rate));
                      }
                    }

                  if (data1.isNotEmpty) {
                    _seriesData.add(
                      charts.Series(
                        domainFn: (Pollution pollution, _) => pollution.place,
                        measureFn: (Pollution pollution, _) => pollution.quantity,
                        id: 'Jour',
                        data: data1,
                        fillPatternFn: (_, __) => charts.FillPatternType.solid,
                        fillColorFn: (Pollution pollution, _) =>
                            charts.ColorUtil.fromDartColor(Color(0xff990099)),
                      ),
                    );
                    setState(() {
                      isnotEmpty = true;
                    });
                  }
                  if (data2.isNotEmpty) {
                    _seriesData.add(
                      charts.Series(
                        domainFn: (Pollution pollution, _) => pollution.place,
                        measureFn: (Pollution pollution, _) => pollution.quantity,
                        id: 'Semaine',
                        data: data2,
                        fillPatternFn: (_, __) => charts.FillPatternType.solid,
                        fillColorFn: (Pollution pollution, _) =>
                            charts.ColorUtil.fromDartColor(Color(0xff109618)),
                      ),
                    );
                    setState(() {
                      isnotEmpty = true;
                    });
                  }
                  if (data3.isNotEmpty) {
                    _seriesData.add(
                      charts.Series(
                        domainFn: (Pollution pollution, _) => pollution.place,
                        measureFn: (Pollution pollution, _) => pollution.quantity,
                        id: 'Mois',
                        data: data3,
                        fillPatternFn: (_, __) => charts.FillPatternType.solid,
                        fillColorFn: (Pollution pollution, _) =>
                            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
                      ),
                    );
                    setState(() {
                      isnotEmpty = true;
                    });
                  }

                  _seriesLineData.add(
                    charts.Series(
                      colorFn: (__, _) =>
                          charts.ColorUtil.fromDartColor(Color(0xff990099)),
                      id: 'H',
                      data: linesalesdata,
                      domainFn: (Sales sales, _) => sales.yearval,
                      measureFn: (Sales sales, _) => sales.salesval,
                    ),
                  );
                  _seriesLineData.add(
                    charts.Series(
                      colorFn: (__, _) =>
                          charts.ColorUtil.fromDartColor(Color(0xff109618)),
                      id: 'G',
                      data: linesalesdata1,
                      domainFn: (Sales sales, _) => sales.yearval,
                      measureFn: (Sales sales, _) => sales.salesval,
                    ),
                  );
                  _seriesLineData.add(
                    charts.Series(
                      colorFn: (__, _) =>
                          charts.ColorUtil.fromDartColor(Color(0xffff9900)),
                      id: 'HFC',
                      data: linesalesdata2,
                      domainFn: (Sales sales, _) => sales.yearval,
                      measureFn: (Sales sales, _) => sales.salesval,
                    ),
                  );
                  _seriesLineData.add(
                    charts.Series(
                      colorFn: (__, _) =>
                          charts.ColorUtil.fromDartColor(Color(0xffff1900)),
                      id: 'F',
                      data: linesalesdata2,
                      domainFn: (Sales sales, _) => sales.yearval,
                      measureFn: (Sales sales, _) => sales.salesval,
                    ),
                  );
                });
          }
          user = user2;
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<Pollution, String>>();
    _seriesLineData = List<charts.Series<Sales, int>>();
    lrate = List<RateOfMed>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1976d2),
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(icon: Icon(Icons.trending_up)),
                Tab(
                  icon: Icon(Icons.assessment),
                ),
              ],
            ),
            title: Text('Flutter Charts'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Vote pour les pathologie :',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.brightness_1,
                              color: Color(0xffff1900),
                            ),
                            Text(
                              'F',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.brightness_1, color: Color(0xffff9900)),
                            Text(
                              'HFC',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.brightness_1,
                                color: Color(
                                  0xff109618,
                                )),
                            Text(
                              'G',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.brightness_1,
                              color: Color(0xff990099),
                            ),
                            Text(
                              'H',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        */Expanded(
                          child: charts.LineChart(_seriesLineData,
                              defaultRenderer: new charts.LineRendererConfig(
                                  includeArea: true, stacked: true),
                              animate: true,
                              animationDuration: Duration(seconds: 5),
                              behaviors: [
                                new charts.ChartTitle('année',
                                    behaviorPosition:
                                    charts.BehaviorPosition.bottom,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                                new charts.ChartTitle('Vote',
                                    behaviorPosition:
                                    charts.BehaviorPosition.start,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.start),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Courbe de donnée collecter pendants un jour, une semaine ou un mois',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        isnotEmpty
                            ? Expanded(
                          child: charts.BarChart(
                            _seriesData,
                            animate: true,
                            barGroupingType:
                            charts.BarGroupingType.grouped,
                            behaviors: [new charts.SeriesLegend()],
                            animationDuration: Duration(seconds: 2),
                          ),
                        )
                            : Text("Actualment il n'a pas de données "),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}

class RateOfMed {
  int rate;
  String mal;
  DateTime date;

  RateOfMed(this.rate, this.mal, this.date);
}
