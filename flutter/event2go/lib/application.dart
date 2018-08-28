import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

import 'home_widget.dart';
import 'login/ui/signup.dart';
import 'home/ui/home_tabs_view.dart';
import 'features/addevent/add_event_widget.dart';

class Application extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/': (context) => HomeTabsView(),
    SignupWidget.tag: (context) => SignupWidget(),
    HomeWidget.tag: (context) => HomeWidget(),
    HomeTabsView.tag: (context) => HomeTabsView(),
    AddEventWidget.tag: (context) => AddEventWidget(),
//

  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
//        routes: <String, WidgetBuilder>{
//          '/add': (BuildContext context) => new _AddContactPage()
//        },
//      home: LoginWidget(),
//      home: SignupWidget(),

//      home: HomeTabsView(),
//      home: ChatListView(),
      initialRoute: '/',
//      routes: routes,
      routes: routes
    );
  }
}
