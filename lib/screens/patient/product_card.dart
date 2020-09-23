import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/utils/user.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.itemIndex,
    this.medicament,
    this.rate,
    this.date,
  }) : super(key: key);


  final int itemIndex;
  final String rate ;
  final String medicament ;
  final DateTime date ;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Constants.kDefaultPadding,
        vertical: Constants.kDefaultPadding / 2,
      ),
      height: 160,
      child:
      InkWell(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color:  Constants.kBlueColor,
                boxShadow: [Constants.kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),

            // our product image
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: itemIndex,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Constants.kDefaultPadding),
                  height: 10,
                  width: 100,
                ),
              ),
            ),
            // Product title and price
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 70,
                width: size.width - 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.kDefaultPadding),
                      child: Text(
                        "Le : "+date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString() +"\n Vous vote le medicament : "+ medicament+
                            "\n par "+ rate +"/5 .",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    // it use the available space
                    /*Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.kDefaultPadding * 1.5, // 30 padding
                        vertical: Constants.kDefaultPadding / 4, // 5 top and bottom
                      ),
                      decoration: BoxDecoration(
                        color: Constants.darkBlue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        rate.toString(),
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
