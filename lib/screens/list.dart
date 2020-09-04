import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/utils/user.dart';
import 'detail_screen.dart';

// ignore: camel_case_types
class listPatient extends StatefulWidget {
  @override
  _AutoCompleteState createState() => new _AutoCompleteState();
}

class _AutoCompleteState extends State<listPatient> {
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
            backButton(context),
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
                  setState(() {});
                  print(item.id.toString());
                  print(item.adress.toString());
                  DateTime s = DateTime.parse(item.createdAt.toString());
                  print (s.year.toString());
                  setState(
                    () => searchTextField.textField.controller.text =
                        item.email,
                  );
                  setState(() {});
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailPage(item)),
                  );
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
                }),
          ]),
        ])));
  }
}
