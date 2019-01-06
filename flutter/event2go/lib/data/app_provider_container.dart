import 'package:event2go/data/app_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppProviderWidget extends StatefulWidget {
  // Your apps state is managed by the container
  final AppProvider appProvider;

  // This widget is simply the root of the tree,
  // so it has to have a child!
  final Widget child;

  AppProviderWidget({
    @required this.child,
    this.appProvider,
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
  AppProvider appProvider;

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
    appProvider = new AppProvider(
      child: widget.child);
//    return widget.child;
    return appProvider;
  }
}

// This is likely all your InheritedWidget will ever need.
//class _InheritedStateContainer extends InheritedWidget {
//  // The data is whatever this widget is passing down.
//  final _AppProviderContainerState data;
//
//  // InheritedWidgets are always just wrappers.
//  // So there has to be a child,
//  // Although Flutter just knows to build the Widget thats passed to it
//  // So you don't have have a build method or anything.
//  _InheritedStateContainer({
//    Key key,
//    @required this.data,
//    @required Widget child,
//  }) : super(key: key, child: child);
//
//  // This is a better way to do this, which you'll see later.
//  // But basically, Flutter automatically calls this method when any data
//  // in this widget is changed.
//  // You can use this method to make sure that flutter actually should
//  // repaint the tree, or do nothing.
//  // It helps with performance.
//  @override
//  bool updateShouldNotify(_InheritedStateContainer old) => true;
//}
