import 'package:flutter/material.dart';

import '../utils/const.dart';
import '../widgets/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: non_constant_identifier_names
  final user_Controller = TextEditingController();

  // ignore: non_constant_identifier_names
  final password_Controller = TextEditingController();

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      title(),
                      SizedBox(height: 50),
                      emailPasswordWidget(user_Controller, password_Controller),
                      SizedBox(height: 20),
                      submitButton(
                          context, user_Controller, password_Controller),
                      /*Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: Text('Oublier Mots de passe ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w900)),
                    ),*/
                      //_divider(),
                      //_facebookButton(),
                      SizedBox(height: height * .055),
                      //createAccountLabel(context),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: backButton(context)),
            ],
          ),
        ),
      ),
    );
  }
}
