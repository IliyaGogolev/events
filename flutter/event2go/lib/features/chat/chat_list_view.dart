import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatListView extends StatefulWidget {

  static String tag = 'chat_list_view';

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatListView> {

  List<String> _todoItems = [];

  @override
  void initState() {
    super.initState();
  }

  Widget chatFab() {
    return Scaffold(
      backgroundColor: Colors.white,
//      appBar: new AppBar(title: new Text('Todo List')),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _onFabButtonClicked,
        tooltip: 'Toggle',
        child: Icon(Icons.chat),
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
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        }
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
