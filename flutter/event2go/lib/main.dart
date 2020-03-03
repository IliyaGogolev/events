import 'package:event2go/app_provider_container.dart';
import 'package:event2go/application.dart';
import 'package:flutter/material.dart';

void main() {
//  runApp(new DemoApp());
  runApp(new AppProviderWidget(
    child: new ApplicationWidget(),
  ));
}
