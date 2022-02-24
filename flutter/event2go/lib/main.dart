import 'package:event2go/app_provider_container.dart';
import 'package:event2go/application.dart';
import 'package:flutter/material.dart';
import 'package:networking/module/calc.dart';

void main() {
//  runApp(new DemoApp());
  runApp(new AppProviderWidget(
    child: new ApplicationWidget(),
  ));

  final aa = Calculator();
  print("iliya");
  print(aa.addOne(3));
}
