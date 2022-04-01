import 'dart:async';
import 'dart:core';

import 'package:event2go/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:event2go/features/login/ui/signup.dart';

@Deprecated("flutter has its own splash screen, remove this")
class SplashScreen extends StatefulWidget {
  static String tag = 'splashscreen';

  final int seconds;
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final dynamic navigateAfterSeconds;
  final double photoSize;
  final dynamic onClick;
  final Color loaderColor;
  final Image image;

  SplashScreen(
      {this.loaderColor = Colors.blue,
      this.seconds = 5,
      this.photoSize = 200.0,
      this.onClick,
      this.navigateAfterSeconds,
      this.title = const Text('Welcome In Our App'),
      this.backgroundColor = Colors.white,
      this.styleTextUnderTheLoader = const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      this.image});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppModel appModel;

  @override
  void initState() {
    super.initState();

    /**
     * Called after build(BuildContext context) method called
     */
    SchedulerBinding.instance.addPostFrameCallback((_) {

      if (appModel.user.token != null)
        debugPrint("User token: " + appModel.user.token);
      else
        debugPrint("User token: ");

      if (appModel.user.token?.isEmpty ?? true) {
        // todo navigate to signup
        // navigateTo(new SignupWidget());
      } else {
        Timer(Duration(seconds: widget.seconds), () {
          navigateTo(widget.navigateAfterSeconds);
        });
      }
    });
  }

  void navigateTo(dynamic navigateTo) {
    if (navigateTo is String) {
      // It's fairly safe to assume this is using the in-built material
      // named route component
      Navigator.of(context).pushReplacementNamed(navigateTo);
    } else if (navigateTo is Widget) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) => navigateTo));
    } else {
      throw new ArgumentError(
          'widget.navigateAfterSeconds must either be a String or Widget');
    }
  }

  @override
  Widget build(BuildContext context) {
    appModel = AppModel.of(context);
    String log = "BB: $appModel.user.uid";
    debugPrint(log);

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: new InkWell(
        onTap: widget.onClick,
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Container(
              decoration: BoxDecoration(color: widget.backgroundColor),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 2,
                  child: new Container(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: new Container(child: widget.image),
                        radius: widget.photoSize,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      widget.title
                    ],
                  )),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            widget.loaderColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      Text("Loading", style: widget.styleTextUnderTheLoader),
                      new Center(
                        child:
                            Text("Now", style: widget.styleTextUnderTheLoader),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
