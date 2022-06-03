import 'package:flutter/material.dart';

class UsersSelectionWidget extends StatefulWidget {
  static String tag = 'chat_list_view';

  @override
  UsersSelectionState createState() => UsersSelectionState();
}

class UsersSelectionState extends State<UsersSelectionWidget> {
  List<String> _chatList = [];

  @override
  void initState() {
    super.initState();
  }

  Widget chatFab() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(title: new Text('Add Participants'), actions: <Widget>[
          new TextButton(
              child: new Text(
                'Next',
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {})
        ]),
        body: Column(
          children: <Widget>[
            createSearchEditText(),
            Text('Deliver features faster'),
            Text('Craft beautiful UIs'),
          ],
        ));
  }

  Container createSearchEditText() {
    return Container(
            // padding: const Edge.only(left: 8, top: 8, right: 8, bottom: 8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: Colors.red,
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            // decoration: const BoxDecoration(
            //   border: const Border(
            //     bottom: BorderSide(
            //       color: CupertinoColors.inactiveGray,
            //     ),
            //   ),
            // ),
            child: const ListTile(
              horizontalTitleGap: 0,
              leading: Icon(
                Icons.search,
                // color: Colors.black,
                size: 28,
              ),
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    // color: Colors.black,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return chatFab();
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if (index < _chatList.length) {
          return _buildTodoItem(_chatList[index]);
        }

        return _buildTodoItem("");
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText) {
    return new ListTile(title: new Text(todoText));
  }

  void _onFabButtonClicked() {
    // Putting our code inside "setState" tells the app that our state has changed, and
    // it will automatically re-render the list
    setState(() {
//      int index = _todoItems.length;
//      _todoItems.add('Item ' + index.toString());
    });
  }

  @override
  dispose() {
    super.dispose();
  }
}
