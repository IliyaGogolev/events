import 'package:flutter/material.dart';

abstract class HomeBuilder {
  get screenTitle => Text;
  int count();
  String tabTitle(int position);
  Widget tabWidget(int position);
  Future<bool> authorized();
}
