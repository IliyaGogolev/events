import 'package:event2go/features/repositories/repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event2go/features/navigator/routes.dart';
// import 'package:path/path.dart';

// import '../features/home/lib/home_widget.dart';
// import 'package:home/home_widget.dart';
import 'features/home/home_tabs_factory.dart';

import 'package:home/home_tabs_view.dart';


class Event2GoApp extends StatelessWidget {
  const Event2GoApp({Key? key, required RepositoriesProvider repositoriesProvider})
      : _repositoriesProvider = repositoriesProvider,
        super(key: key);

  final RepositoriesProvider _repositoriesProvider;

  // final Repositories repositories = Repositories(
  //     groupsRepository: GroupsRepositoryImp(groupsApi: GroupsApi())
  // );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _repositoriesProvider,
        child: Event2GoView()
        // child: BlocProvider(
        //   create: (_) => ThemeCubit(),
        //   child: Event2GoView(),
        // ),
        );
  }
}

class Event2GoView extends StatelessWidget {
  // final Repositories repositories = Repositories(
  //     groupsRepository: GroupsRepositoryImp(groupsApi: GroupsApi())
  // );

  // // TODO CHECK HOW ROUTE WORKS
  // final routes = <String, WidgetBuilder>{
  //   // '/': (context) => HomeTabsView(HomeTabsFactory()),
  //   // SignupWidget.tag: (context) => SignupWidget(),
  //   // HomeWidget.tag: (context) => HomeWidget(),
  //   HomeTabsView.tag: (context) => HomeTabsView(HomeTabsFactory()),
  //   AddEventWidget.tag: (context) => AddEventWidget(),
  //   SelectContactsWidget.tag: (context) => SelectContactsWidget(null),
  //   '/sign-in': (context) {
  //     // return PhoneInputView(
  //     //   actions: [AuthStateChangeAction<PhoneInputView>((context, state) {
  //     //       Navigator.pushReplacementNamed(context, HomeTabsView.tag);
  //     //     },
  //     //   ],
  //     // );
  //     return SignInScreen(
  //       providerConfigs: [PhoneProviderConfiguration()],
  //       showAuthActionSwitch: false,
  //       actions: [
  //         AuthStateChangeAction<SignedIn>((context, state) {
  //           Navigator.pushReplacementNamed(context, HomeTabsView.tag);
  //         }),
  //       ],
  //     );
  //   }

//    "SplashScreen": (context)=> new SplashScreen(
//     SplashScreen.tag: (context)=> new SplashScreen(
//         seconds: 2,
//         navigateAfterSeconds: new HomeTabsView(HomeTabsFactory()),
//         title: new Text('Welcome to Soccer',
//           style: new TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20.0
//           )
//         ),
//         image: new Image.asset('assets/soccer.png')
//      image: new Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs9UTIxpeNMfXF8xw8eEg7Kach7aKM2gocYp84Ctv8QwYqfGig'),
//      onClick: ()=>print("Flutter Egypt"),
//     ),
//   };

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: isAuthorized(),
        builder: (BuildContext context, AsyncSnapshot<bool> isAuthorized) {
          bool authorized = isAuthorized.hasData && (isAuthorized.data ?? false);

          print("repo ${context.read<RepositoriesProvider>()}");
          return new MaterialApp(
            debugShowCheckedModeBanner: false,
            // initialRoute: authorized ? HomeTabsView.tag : SplashScreen.tag,
            // initialRoute: authorized ? HomeTabsView.tag : '/sign-in',
//        routes: <String, WidgetBuilder>{
//          '/add': (BuildContext context) => new _AddContactPage()
//        },
//      home: LoginWidget(),
//      home: SignupWidget(),
//      home: ChatListView(),
          initialRoute: HomeTabsView.tag,
//             home: HomeTabsView(HomeTabsFactory()),
            // home: authorized ? HomeTabsView(HomeTabsFactory()) : Material(
            //     child: Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 25.0),
            //         child: PhoneInputView())
            // ),
              onGenerateRoute: AppRouter.generateRoute,
            // routes: routes
          );
        });
  }

  // Future<bool> isAuthorized() async => FirebaseAuth.instance.currentUser == null;
  Future<bool> isAuthorized() async => true;
}
