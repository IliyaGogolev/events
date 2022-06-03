import 'package:flutter/material.dart';

abstract class TabsFactory {
  get screenTitle => Text;
  int count();
  String tabTitle(int position);
  Widget tabWidget(int position);
}
