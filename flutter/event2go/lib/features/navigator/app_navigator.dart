import 'package:event2go/features/navigator/group_flow.dart';
import 'package:flutter/material.dart';

void navigateToCreateGroupWidget(BuildContext context) {
  Navigator.of(context).pushNamed(routeGroupSetupStart);
}

// void navigatePopToRouteName(BuildContext context, String routeName) {
//   Navigator.popUntil(context, ModalRoute.withName(routeName));
// }