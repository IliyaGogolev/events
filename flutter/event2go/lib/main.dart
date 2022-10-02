import 'dart:async';

import 'package:dio/dio.dart';
import 'package:event2go/app_provider_container.dart';
import 'package:event2go/event2go_app.dart';
import 'package:event2go/features/repositories/repository_provider.dart';
import 'package:event2go/network/mock/mock_interceptor.dart';
import 'package:event2go/network/network_client.dart';
import 'package:event2go/network/services/groups_service.dart';
import 'package:event2go/repositories/groups_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'config/config.dart';

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final bool isLogged = await isUserAuthorized();
  print("myApp isLogged $isLogged");

  var configuredApp = Config(
    appDisplayName: "Event2Go",
    isUserAuthorized: isLogged,
    child: myApp(),
  );

  runApp(configuredApp);
}

myApp() {
  NetworkClient network = NetworkClient(Dio());
  network.addInterceptor(MockInterceptor());
  network.addInterceptor(PrettyDioLogger());
  return new AppProviderWidget(
    child: new Event2GoApp(repositoriesProvider: RepositoriesProvider(
        groupsRepository: GroupsRepositoryImp(groupsService: GroupsService(networkClient: network))
    )),
  );
}

// TODO create interface, move to firebase auth package
Future<bool> isUserAuthorized() async {
  print("isUserAuthorized called");
  var completer = new Completer<bool>();
  // .authStateChanges()
  FirebaseAuth.instance.userChanges().listen((user) {
    print("isUserAuthorized token callback)");
    // completer.complete(true);
    if (user != null) {
      // final idToken = user.getIdToken();
      final idToken = userToken(user);
      print("user not null $idToken");
      completer.complete(true);
      // _loggedIn = true;
    } else {
      print("user null");
      completer.complete(false);
      // _loggedIn = false;
    }
  });
  return completer.future;
}


Future<String> userToken(User user) async {
  print("userToken called");
  String token = await user.getIdToken();
  print("userToken token: $token");
  return token;
}