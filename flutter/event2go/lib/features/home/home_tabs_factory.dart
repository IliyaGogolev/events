import 'package:event2go/features/chat/chat_widget.dart';
import 'package:event2go/features/eventslist/ui/event_list_widget.dart';
import 'package:home/home_exports.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class HomeTabsFactory implements TabsFactory {

  @override
  get screenTitle => Text('Events 2 Go');

  @override
  int count() => 3;

  @override
  String tabTitle(int position) {
    String title = "";
    switch (position) {
      case 0:
        title = "Chat";
        break;
      case 1:
        title = "Events";
        break;
      case 2:
        title = "Notifications";
        break;
    }
    return title;
  }

  @override
  Widget tabWidget(int position) {
    Widget widget;
    switch (position) {
      case 0:
        widget = ChatWidget();
        break;
      case 1:
        widget = EventListWidget();
        break;
      case 2:
        widget = Icon(Icons.notifications);
        break;
      case 3:
        widget = Icon(Icons.settings);
        break;
    }
    return widget;
  }
}