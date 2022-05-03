import 'package:event2go/features/splash/splashscreen.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';

// import '../features/home/lib/home_widget.dart';
// import 'package:home/home_widget.dart';
import 'features/home/home_tabs_factory.dart';
import 'features/login/ui/signup.dart';

// import '../features/home/lib/home_tabs_view.dart';
import 'package:home/home_tabs_view.dart';
import 'package:home/home_builder.dart';
import 'features/addevent/add_event_widget.dart';
import 'features/phone/ui/select_contacts.dart';

// import 'package:flutterfire_ui/auth.dart';
import 'package:auth/auth.dart';

class Event2GoAppWidget extends StatelessWidget {
  // TODO CHECK HOW ROUTE WORKS
  final routes = <String, WidgetBuilder>{
    // '/': (context) => HomeTabsView(HomeTabsFactory()),
    // SignupWidget.tag: (context) => SignupWidget(),
    // HomeWidget.tag: (context) => HomeWidget(),
    HomeTabsView.tag: (context) => HomeTabsView(HomeTabsFactory()),
    AddEventWidget.tag: (context) => AddEventWidget(),
    SelectContactsWidget.tag: (context) => SelectContactsWidget(null),

//    "SplashScreen": (context)=> new SplashScreen(
//     SplashScreen.tag: (context)=> new SplashScreen(
//         seconds: 2,
//         navigateAfterSeconds: new HomeTabsView(HomeTabsFactory()),
//         title: new Text('Welcome to Soccer',
//           style: new TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20.0
//           )
//         ),
//         image: new Image.asset('assets/soccer.png')
//      image: new Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs9UTIxpeNMfXF8xw8eEg7Kach7aKM2gocYp84Ctv8QwYqfGig'),
//      onClick: ()=>print("Flutter Egypt"),
//     ),
  };

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: isAuthorized(),
        builder: (BuildContext context, AsyncSnapshot<bool> isAuthorized) {
          bool authorized = isAuthorized.hasData && isAuthorized.data;
          debugPrint("authorized $authorized");
          return new MaterialApp(
              debugShowCheckedModeBanner: false,
//        routes: <String, WidgetBuilder>{
//          '/add': (BuildContext context) => new _AddContactPage()
//        },
//      home: LoginWidget(),
//      home: SignupWidget(),

//      home: HomeTabsView(),
//      home: ChatListView(),
//       initialRoute: '/',
//         home: HomeTabsView(HomeTabsFactory()),
              home: authorized ? HomeTabsView(HomeTabsFactory()) : Material(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 25.0),
                      child: PhoneInputView())
              ),
              // initialRoute: authorized ? HomeTabsView.tag : SplashScreen.tag,
              // initialRoute:
//      routes: routes,
              routes: routes);
        });
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
//        routes: <String, WidgetBuilder>{
//          '/add': (BuildContext context) => new _AddContactPage()
//        },
//      home: LoginWidget(),
//      home: SignupWidget(),

//      home: HomeTabsView(),
//      home: ChatListView(),
//       initialRoute: '/',
        initialRoute: SplashScreen.tag,
//      routes: routes,
        routes: routes);
  }

  Future<bool> isAuthorized() async => false;
}
