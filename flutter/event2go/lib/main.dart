import 'package:event2go/application.dart';
import 'package:event2go/data/app_provider_container.dart';
import 'package:event2go/data/app_state_container.dart';
import 'package:flutter/material.dart';

import 'login/ui/signup.dart';
//import 'login/ui/login.dart';

//void main() => runApp(new DemoApp());
//void main() => runApp(new Application());

void main() {
// Wrap your App in your new storage container
//  runApp(new AppStateContainer(
//    child: new Application(),
//  ));
  runApp(new AppProviderWidget(
    child: new ApplicationWidget(),
  ));
}
