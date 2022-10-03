import 'package:event2go/app_provider.dart';
import 'package:event2go/data/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppProviderWidget extends StatefulWidget {
  // Your apps state is managed by the container
  // late AppModel appModel;

  // This widget is simply the root of the tree,
  // so it has to have a child!
  final Widget child;

  AppProviderWidget({
    required this.child,
    // required this.appModel,
  });

  // This creates a method on the AppProvider that's just like 'of'
  // On MediaQueries, Theme, etc
  // This is the secret to accessing your AppProvider all over your app
//  static _AppProviderContainerState of(BuildContext context) {
//    return (context.inheritFromWidgetOfExactType(AppProvider)
//            as AppProvider)
//        .data;
//  }

  @override
  _AppProviderWidgetState createState() => new _AppProviderWidgetState();
}

class _AppProviderWidgetState extends State<AppProviderWidget> {
  // Just padding the state through so we don't have to
  // manipulate it with widget.state.
  late AppModel appModel;

  @override
  void initState() {
    // You'll almost certainly want to do some logic
    // in InitState of your AppProviderContainer. In this example, we'll eventually
    // write the methods to check the local state
    // for existing users and all that.
    super.initState();
  }

  // So the WidgetTree is actually
  // AppProviderContainer --> InheritedStateContainer --> The rest of your app.
  @override
  Widget build(BuildContext context) {
    appModel = new AppModel(
      child: widget.child,
        user: new MyUser(phoneNumber: '', uid: '', email: '', token: '')
    );
//    return widget.child;
    return appModel;
  }
}