import 'package:event2go/login/data/countries.dart';
import 'package:event2go/login/domain/SendPhoneNumberUseCase.dart';
import 'package:event2go/login/ui/enter_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
//https://medium.com/@boldijar.paul/comboboxes-in-flutter-cabc9178cc95

class HomeWidget extends StatefulWidget {

  static String tag = 'home-widget';
//  final String title;
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<HomeWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
                bottom: TabBar(
                  tabs: [
                      Tab(icon: Icon(Icons.directions_car)),
                      Tab(icon: Icon(Icons.directions_transit)),
                      Tab(icon: Icon(Icons.directions_bike)),
                  ],
              ),
          ),
        ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }


}
