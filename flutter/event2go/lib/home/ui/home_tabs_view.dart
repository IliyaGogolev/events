import 'package:event2go/features/chat/chat_list_view.dart';
import 'package:event2go/features/eventslist/ui/event_list_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class HomeTabsView extends StatelessWidget {
  static String tag = 'home-tab-bar_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Events",
                ),
                Tab(text: "Chat",),
                Tab(text: "Notification",),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
//              Icon(Icons.directions_car),
            EventListWidget(),
            ChatListView(),
//            Text("BB"),
//              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}