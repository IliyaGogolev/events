
import 'package:flutter/material.dart';
//
// const routeGroupSetupPrefix = 'group';
// const routeGroupSetupStart = '/$routeGroupSetupPrefix/$routeGroupSetupStartPage';
// const routeGroupSetupStartPage = 'select_contacts';
// const routeDeviceSetupGroupProfilePage = 'add_profile';
// const routeDeviceSetupFinishedPage = 'finished';
//
//
// Route _onGenerateRoute(RouteSettings settings) {
//   late Widget page;
//   switch (settings.name) {
//     case routeDeviceSetupStartPage:
//       page = WaitingPage(
//         message: 'Searching for nearby bulb...',
//         onWaitComplete: _onDiscoveryComplete,
//       );
//       break;
//     case routeDeviceSetupSelectDevicePage:
//       page = SelectDevicePage(
//         onDeviceSelected: _onDeviceSelected,
//       );
//       break;
//     case routeDeviceSetupConnectingPage:
//       page = WaitingPage(
//         message: 'Connecting...',
//         onWaitComplete: _onConnectionEstablished,
//       );
//       break;
//     case routeDeviceSetupFinishedPage:
//       page = FinishedPage(
//         onFinishPressed: _exitSetup,
//       );
//       break;
//   }
//
//   return MaterialPageRoute<dynamic>(
//     builder: (context) {
//       return page;
//     },
//     settings: settings,
//   );
// }