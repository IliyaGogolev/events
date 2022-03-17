import 'package:event2go/features/chat/chat_list_view.dart';
import 'package:event2go/features/eventslist/ui/event_list_widget.dart';
import 'package:home/home_exports.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class HomeTabsFactory implements HomeBuilder {

  @override
  get screenTitle => Text('Events 2 Go');

  @override
  int count() => 3;

  @override
  String tabTitle(int position) {
    String title = "";
    switch (position) {
      case 0:
        title = "Events";
        break;
      case 1:
        title = "Chat";
        break;
      case 2:
        title = "Notifications";
        break;
    }
    return title;
  }

  @override
  Widget tabWidget(int position) {
    Widget widet;
    switch (position) {
      case 0:
        widet = EventListWidget();
        break;
      case 1:
        widet = ChatListView();
        break;
      case 2:
        widet = Icon(Icons.directions_bike);
        break;
    }
    return widet;
  }
}