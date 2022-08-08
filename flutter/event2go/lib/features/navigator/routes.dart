
import 'package:auth/auth.dart';
import 'package:event2go/features/addevent/add_event_widget.dart';
import 'package:event2go/features/home/home_tabs_factory.dart';
import 'package:event2go/features/navigator/group_flow.dart';
import 'package:event2go/features/phone/ui/select_contacts.dart';
import 'package:flutter/material.dart';
import 'package:home/home_tabs_view.dart';

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
        case '/sign-in':
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
        AuthStateChangeAction<SignedIn>((context, state) {
          Navigator.pushReplacementNamed(context, HomeTabsView.tag);
        }),
      ],
    );
  }
}