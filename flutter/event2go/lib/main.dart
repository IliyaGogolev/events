import 'package:event2go/app_provider_container.dart';
import 'package:event2go/application.dart';
import 'package:flutter/material.dart';
// import 'package:networking/module/calc.dart';
import 'package:home/home_widget.dart';
import 'package:auth/auth.dart';

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//  runApp(new DemoApp());
  runApp(new AppProviderWidget(
    child: new Event2GoAppWidget(),
  ));

  // final aa = Calculator();
  // print("iliya");
  // print(aa.addOne(3));

}
