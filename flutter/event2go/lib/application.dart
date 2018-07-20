import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_widget.dart';
import 'login/ui/login.dart';
import 'login/ui/signup.dart';

class Application extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginWidget.tag: (context) => LoginWidget(),
    HomeWidget.tag: (context) => HomeWidget(),
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
//        routes: <String, WidgetBuilder>{
//          '/add': (BuildContext context) => new _AddContactPage()
//        },
//      home: LoginWidget(),
      home: SignupWidget(),
      routes: routes,
    );
  }
}
