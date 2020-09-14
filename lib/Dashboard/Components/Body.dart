import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/Dashboard/Components/product_card.dart';
import 'package:mediapp/screens/detail_screen.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/utils/rating.dart';
import 'package:mediapp/utils/user.dart';
import '../Dashboard.dart';

// ignore: camel_case_types
class body extends State<Dashboard> with SingleTickerProviderStateMixin {
  var first = true;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController controller;
  Animation<double> scaleAnimation;
  Animation<double> menuScaleAnimation;
  Animation<Offset> slideAnimation;
  final prenom_Controller = TextEditingController();
  final nom_Controller = TextEditingController();

  GlobalKey<AutoCompleteTextFieldState<User>> key = new GlobalKey();
  AutoCompleteTextField searchTextField;
  TextEditingController econtroller = new TextEditingController();
  int numberPat = 0 ;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: duration);
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(controller);
    menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(controller);
    slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(controller);

    RatesViewModel.Listrates = [];
    _loadData();

    if (UserViewModel.user != null ){
      setState(() {
        numberPat = UserViewModel.user.length;
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      build(context);
    });
  }

  void _loadData() async {
    await UserViewModel.loadPlayers();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          dashboard(context),
        ],
      ),
    );
  }

  // ignore: missing_return
  Widget dashboard(context) {
    String strDate = "";
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: 0 * screenWidth,
      right: 0 * screenWidth,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Material(
          color: Constants.lightBlue,
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Colors.grey,
                      Constants.lightBlue,
                    ],
                    begin: const FractionalOffset(1.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              //color: Constants.lightBlue,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(children: <Widget>[
                    Column(children: <Widget>[
                      SizedBox(height: 20),
                      backButton(context),
                      //Positioned(top: 40, left: 0, child: backButton(context)),
                      searchTextField = AutoCompleteTextField<User>(
                          style: new TextStyle(
                              color: Colors.black, fontSize: 16.0),
                          decoration: new InputDecoration(
                              fillColor: Colors.transparent,
                              suffixIcon: Container(
                                width: 55.0,
                                height: 60.0,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              filled: true,
                              hintText: 'Recherche Patient par Nom :',
                              hintStyle: TextStyle(color: Colors.black)),
                          itemSubmitted: (item) {
                            print(item.id.toString());
                            print(item.adress.toString());
                            DateTime s =
                                DateTime.parse(item.createdAt.toString());
                            print(s.year.toString());
                            setState(
                              () => searchTextField.textField.controller.text =
                                  item.email,
                            );
                            print(item.id);
                            if (item == null) {
                              print(null);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(item)),
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
                                Text(item.name.toString())
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
                          }),
                    ]),
                  ]),
                  SizedBox(height: 5),
                  ListView.builder(
                      itemBuilder: (context, index) {
                        return ProductCard(
                          itemIndex: index,
                          user: UserViewModel.user[index],
                          press: (){
                            try {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(UserViewModel.user[index])),
                              );
                            } catch (error) {
                              print("list patiant : "+error);
                            }
                          },
                        );
                      },
                      shrinkWrap: true,
                      itemCount: numberPat),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
