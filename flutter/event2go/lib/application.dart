import 'package:event2go/features/splash/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

import 'home_widget.dart';
import 'login/ui/signup.dart';
import 'home/ui/home_tabs_view.dart';
import 'features/addevent/add_event_widget.dart';
import 'features/phone/ui/select_contacts.dart';


class ApplicationWidget extends StatelessWidget {


  final routes = <String, WidgetBuilder>{
    '/': (context) => HomeTabsView(),
    SignupWidget.tag: (context) => SignupWidget(),
    HomeWidget.tag: (context) => HomeWidget(),
    HomeTabsView.tag: (context) => HomeTabsView(),
    AddEventWidget.tag: (context) => AddEventWidget(),
    SelectContactsWidget.tag: (context)=> SelectContactsWidget(null),

//    "SplashScreen": (context)=> new SplashScreen(
    SplashScreen.tag: (context)=> new SplashScreen(
//      seconds: 14,
      navigateAfterSeconds: new HomeTabsView(),
      title: new Text('Welcome to Events',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),),
      image: new Image.asset('assets/soccer.png')
//      image: new Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs9UTIxpeNMfXF8xw8eEg7Kach7aKM2gocYp84Ctv8QwYqfGig'),
//      onClick: ()=>print("Flutter Egypt"),
    ),

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
//      initialRoute: '/',
      initialRoute: SplashScreen.tag,
//      routes: routes,
      routes: routes
    );
  }
}
