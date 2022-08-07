
import 'package:auth/auth.dart';
import 'package:event2go/features/home/home_tabs_factory.dart';
import 'package:event2go/features/phone/ui/select_contacts.dart';
import 'package:flutter/material.dart';
import 'package:home/home_tabs_view.dart';

const routeGroupSetupPrefix = 'group';
const routeGroupSetupStart = '/group/$routeGroupSetupStartPage';
const routeGroupSetupStartPage = 'select_contacts';
const routeDeviceSetupGroupProfilePage = 'profile';
const routeDeviceSetupFinishedPage = 'finished';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Pass data to view
    //    Use Navigator.pushNamed(context, feedRoute, arguments: 'Data from home');
    //    var data = settings.arguments as String;
    switch (settings.name) {

      case HomeTabsView.tag:
        return MaterialPageRoute(builder: (_) => HomeTabsView(HomeTabsFactory()));
      case SelectContactsWidget.tag:
        return MaterialPageRoute(builder: (_) => SelectContactsWidget(null));
      case '/sign-in':
        return MaterialPageRoute(builder: (_) => createSingIn());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }

  static Widget createSingIn() {
    return SignInScreen(
      providerConfigs: [PhoneProviderConfiguration()],
      showAuthActionSwitch: false,
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          Navigator.pushReplacementNamed(context, HomeTabsView.tag);
        }),
      ],
    );
  }
}
//
// final _navigatorKey = GlobalKey<NavigatorState>();
//
// void _onDiscoveryComplete() {
//   _navigatorKey.currentState!.pushNamed(routeDeviceSetupSelectDevicePage);
// }
//
// void _onDeviceSelected(String deviceId) {
//   _navigatorKey.currentState!.pushNamed(routeDeviceSetupConnectingPage);
// }
//
// void _onConnectionEstablished() {
//   _navigatorKey.currentState!.pushNamed(routeDeviceSetupFinishedPage);
// }
//
// Route _onGenerateRoute(RouteSettings settings) {
//   late Widget page;
//   switch (settings.name) {
//     case routeGroupSetupStartPage:
//       page = ContactsSelectionWidget(
//         message: 'Searching for nearby bulb...',
//         onWaitComplete: _onDiscoveryComplete,
//       );
//       break;
//     case routeDeviceSetupSelectDevicePage:
//       page = SelectDevicePage(
//         onDeviceSelected: _onDeviceSelected,
//       );
//       break;
//     case routeDeviceSetupConnectingPage:
//       page = WaitingPage(
//         message: 'Connecting...',
//         onWaitComplete: _onConnectionEstablished,
//       );
//       break;
//     case routeDeviceSetupFinishedPage:
//       page = FinishedPage(
//         onFinishPressed: _exitSetup,
//       );
//       break;
//   }
//
//   return MaterialPageRoute<dynamic>(
//     builder: (context) {
//       return page;
//     },
//     settings: settings,
//   );
// }