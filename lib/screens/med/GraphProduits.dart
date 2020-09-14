import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/utils/rating.dart';
import 'package:mediapp/utils/user.dart';
import 'detail_screen.dart';

// ignore: camel_case_types
class GraphProduits extends StatefulWidget {
  @override
  _AutoCompleteState createState() => new _AutoCompleteState();
}

class _AutoCompleteState extends State<GraphProduits> {
  GlobalKey<AutoCompleteTextFieldState<User>> key = new GlobalKey();
  AutoCompleteTextField searchTextField;
  TextEditingController controller = new TextEditingController();
  _AutoCompleteState();

  void _loadData() async {
    await UserViewModel.loadPlayers();
  }

  @override
  void initState() {
    _loadData();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Center(
            child: new Column(children: <Widget>[
          new Column(children: <Widget>[

            SizedBox(height: 20),
            backButton(context),/*
            //Positioned(top: 40, left: 0, child: backButton(context)),
            searchTextField = AutoCompleteTextField<User>(
                style: new TextStyle(color: Colors.black, fontSize: 16.0),
                decoration: new InputDecoration(
                    fillColor: Constants.lightBlue,
                    suffixIcon: Container(
                      width: 55.0,
                      height: 60.0,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                    filled: true,
                    hintText: 'Recherche Patient par Nom :',
                    hintStyle: TextStyle(color: Colors.black)),
                itemSubmitted: (item) {
                  print(item.id.toString());
                  print(item.adress.toString());
                  DateTime s = DateTime.parse(item.createdAt.toString());
                  print (s.year.toString());
                  setState(
                    () => searchTextField.textField.controller.text =
                        item.email,

                    // load graph data.
                  );
                  print(item.id);
                  if(item == null ){
                    print(null);
                  }else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailPage(item)),
                  );
                  }
                },
                clearOnSubmit: false,
                key: key,
                suggestions: UserViewModel.user,
                itemBuilder: (context, item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        item.email,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Padding(padding: EdgeInsets.all(15.0)),
                      Text(item.id.toString())
                    ],
                  );
                },
                itemSorter: (a, b) {
                  return a.email.compareTo(b.email);
                },
                itemFilter: (item, query) {
                  return item.email
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                }),*/
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
                              crossAxisAlignment:
                              CrossAxisAlignment.baseline,
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
                              color: Colors.blue
                                  .withOpacity(showAvg ? 1.0 : 0.5),
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

          ]),
        ])));
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
          DateTime dt = DateTime.parse(listrates[0].createdAt.toString());
          DateTime dt2 = DateTime.parse(listrates[1].createdAt.toString());
          switch (value.toInt()) {
            case 3:
              return dt.day.toString() + "/" + dt.month.toString();
            case 6:
              return dt2.day.toString() + "/" + dt2.month.toString();
            case 9:
              return dt2.day.toString() + "/" + dt2.month.toString();
            case 12:
              return dt2.day.toString() + "/" + dt2.month.toString();
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
      FlSpot(3, double.parse(listrates[0].value.toString() + ".0")),
      FlSpot(6, double.parse(listrates[1].value.toString() + ".0")),
      FlSpot(9, double.parse(listrates[2].value.toString() + ".0")),
      FlSpot(12, double.parse(listrates[3].value.toString() + ".0")),
      FlSpot(14, double.parse(listrates[4].value.toString() + ".0")),
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
  ];
}

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
          DateTime dt = DateTime.parse(listrates[0].createdAt.toString());
          DateTime dt2 = DateTime.parse(listrates[1].createdAt.toString());
          DateTime dt3 = DateTime.parse(listrates[2].createdAt.toString());
          DateTime dt4 = DateTime.parse(listrates[3].createdAt.toString());
          DateTime dt5 = DateTime.parse(listrates[4].createdAt.toString());
          //print(listrates[9].createdAt.toString());
          switch (value.toInt()) {
            case 0:
              return dt.day.toString() +
                  "/" +
                  dt.month.toString() +
                  "/" +
                  dt.year.toString();
            case 1:
              return dt2.day.toString() +
                  "/" +
                  dt2.month.toString() +
                  "/" +
                  dt2.year.toString();
            case 2:
              return dt3.day.toString() +
                  "/" +
                  dt3.month.toString() +
                  "/" +
                  dt3.year.toString();
            case 3:
              return dt4.day.toString() +
                  "/" +
                  dt4.month.toString() +
                  "/" +
                  dt4.year.toString();
            case 4:
              return dt5.day.toString() +
                  "/" +
                  dt5.month.toString() +
                  "/" +
                  dt5.year.toString();
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
            y: double.parse(listrates[0].value.toString() + ".0"),
            width: barWidth,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItem: [
              BarChartRodStackItem(
                  0,
                  double.parse(listrates[0].value.toString() + ".0"),
                  const Color(0xff2bdb90)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            y: double.parse(listrates[1].value.toString() + ".0"),
            width: barWidth,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItem: [
              BarChartRodStackItem(
                  0,
                  double.parse(listrates[1].value.toString() + ".0"),
                  const Color(0xffffdd80)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            y: double.parse(listrates[2].value.toString() + ".0"),
            width: barWidth,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItem: [
              BarChartRodStackItem(
                  0,
                  double.parse(listrates[2].value.toString() + ".0"),
                  const Color(0xffff4d94)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            y: double.parse(listrates[3].value.toString() + ".0"),
            width: barWidth,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItem: [
              BarChartRodStackItem(
                  0,
                  double.parse(listrates[3].value.toString() + ".0"),
                  const Color(0xff19bfff)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            y: double.parse(listrates[4].value.toString() + ".0"),
            width: barWidth,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItem: [
              BarChartRodStackItem(
                  0,
                  double.parse(listrates[4].value.toString() + ".0"),
                  const Color(0xff2ffb90)),
            ],
          ),
        ],
      ),
    ],
  );
}
