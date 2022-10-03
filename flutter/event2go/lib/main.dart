import 'dart:async';
import 'package:dio/dio.dart';
import 'package:event2go/app_provider_container.dart';
import 'package:event2go/event2go_app.dart';
import 'package:event2go/features/repositories/repository_provider.dart';
import 'package:event2go/network/mock/mock_interceptor.dart';
import 'package:event2go/network/mock/token_interceptor.dart';
import 'package:event2go/network/network_client.dart';
import 'package:event2go/network/services/groups_service.dart';
import 'package:event2go/repositories/groups_repository_impl.dart';
import 'package:event2go/utils/pair.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'config/config.dart';

StreamSubscription? authStreamSubscription;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final Pair isLoggedAndToken = await isUserAuthorized();
  authStreamSubscription?.cancel();
  final bool isLoggedIn = isLoggedAndToken.left;
  final String? token = isLoggedAndToken.right;
  print("main isLogged ${isLoggedAndToken.left}");
  NetworkClient networkClient = initNetworkClient(token);

  var configuredApp = Config(
    appDisplayName: "Event2Go",
    isUserAuthorized: isLoggedIn,
    child: myApp(networkClient),
  );

  runApp(configuredApp);
}

myApp(NetworkClient networkClient) {
  return new AppProviderWidget(
    child: new Event2GoApp(
        repositoriesProvider: RepositoriesProvider(
            groupsRepository: GroupsRepositoryImp(groupsService: GroupsService(networkClient: networkClient)))),
  );
}

NetworkClient initNetworkClient(String? token) {
  Stream<String?> onTokenChanged = idTokenChanges();
  NetworkClient network = NetworkClient(Dio());
  network.addInterceptor(MockInterceptor());
  network.addInterceptor(PrettyDioLogger());
  network.addInterceptor(TokenInterceptor(onTokenChanged: onTokenChanged, token: token));
  return network;
}

// TODO create interface, move to firebase auth package
Stream<String?> idTokenChanges() async* {
  FirebaseAuth.instance.idTokenChanges().asyncMap<String?>(
          (User? user) => fetchTokenFromUser(user)
  );
}

// TODO create interface, move to firebase auth package
/// Return Pair<LoggedIn,Token>
Future<Pair> isUserAuthorized() async {
  print("[isUserAuthorized] called");
  var completer = new Completer<Pair>();
  // .authStateChanges()

  authStreamSubscription = FirebaseAuth.instance.userChanges().listen((user) {
    print("[isUserAuthorized] token callback");
    // completer.complete(true);
    if (user != null) {
      // final idToken = user.getIdToken();
      fetchTokenFromUser(user).then((token) =>
          completer.complete(Pair(true, token))
      );
    } else {
      print("user null");
      completer.complete(Pair(false, null));
    }
  });
  return completer.future;
}

Future<String?> fetchTokenFromUser(User? user) async {
  if (user != null) {
    String token = await user.getIdToken();
    print("userToken token: $token");
    return token;
  } else {
    return null;
  }
}

Future<String> userToken(User user) async {
  print("userToken called");
  String token = await user.getIdToken();
  print("userToken token: $token");
  return token;
}
