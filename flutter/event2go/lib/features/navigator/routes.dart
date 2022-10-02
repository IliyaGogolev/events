import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:event2go/features/addevent/add_event_widget.dart';
import 'package:event2go/features/home/home_tabs_factory.dart';
import 'package:event2go/features/navigator/group_flow.dart';
import 'package:event2go/features/phone/ui/select_contacts.dart';
import 'package:flutter/material.dart';
import 'package:home/home_tabs_view.dart';

const String SIGN_IN_TAG = '/sign-in';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name!.startsWith(routeGroupSetupPrefix)) {
      final subRoute = settings.name!.substring(routeGroupSetupPrefix.length);
      return MaterialPageRoute<dynamic>(
        builder: (context) {
          return GroupFlow(initialPageRoute: subRoute);
        },
        settings: settings,
      );
    } else {
      switch (settings.name) {
        case HomeTabsView.tag:
          return MaterialPageRoute(builder: (_) => HomeTabsView(HomeTabsFactory()));
        case SelectContactsWidget.tag:
          return MaterialPageRoute(builder: (_) => SelectContactsWidget(null));
        case AddEventWidget.tag:
          return MaterialPageRoute(builder: (_) => AddEventWidget());
        case SIGN_IN_TAG:
          return MaterialPageRoute(builder: (_) => createSingIn());
        default:
          return MaterialPageRoute(
              builder: (_) =>
                  Scaffold(
                    body: Center(
                        child: Text('No route defined for ${settings.name}')),
                  ));
      }
    }
  }

  static Widget createSingIn() {
    return SignInScreen(
      providerConfigs: [PhoneProviderConfiguration()],
      showAuthActionSwitch: false,
      actions: [
        AuthStateChangeAction<AuthState>((context, state) async {

          String? token = await FirebaseAuth.instance.currentUser?.getIdToken(false);
          print("state:  $state");
          print("token:  $token");
          if (state is SigningIn && token != null) {
            Navigator.pushReplacementNamed(context, HomeTabsView.tag);
          }
        }),
      ],
    );
  }
}

/////////  DRAFT SplashScreen //////////

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
//   };