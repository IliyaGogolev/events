import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:home/home_builder.dart';

export 'package:home/home_tabs_view.dart';

class HomeTabsView extends StatelessWidget {
  static String tag = 'home-tab-bar_view';
  final HomeBuilder tabBuilder;
  const HomeTabsView(this.tabBuilder);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs: createTabs(),
            ),
            title: tabBuilder.screenTitle,
          ),
          body: TabBarView(
            children: createTabWidgets(),
          ),
        ),
      ),
    );
  }

  List<Widget> createTabWidgets() {
    var tabs = <Widget>[];
    for (var i = 0; i < tabBuilder.count(); i++) {
      tabs.add(tabBuilder.tabWidget(i));
    }
    return tabs;
  }

  List<Tab> createTabs() {
    var tabs = <Tab>[];
    for (var i = 0; i < tabBuilder.count(); i++) {
      tabs.add(Tab(
        text: tabBuilder.tabTitle(i)
      ));
    }
    return tabs;
  }
}