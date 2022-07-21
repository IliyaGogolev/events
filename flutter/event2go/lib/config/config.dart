import 'package:event2go/utils/build_mode.dart';
import 'package:flutter/material.dart';


// TODO Move to core module
class Config extends InheritedWidget {

  Config({this.appDisplayName, Widget child}):super(child: child);

  final String appDisplayName;

  static Config of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Config>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

//
// enum Flavor {
//   DEVELOPMENT,
//   RELEASE,
// }
//
// class Config {
//
//   static Flavor appFlavor;
//
//   final String appDisplayName;
//   final int appInternalId;
//
// }

