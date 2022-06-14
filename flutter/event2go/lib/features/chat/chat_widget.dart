import 'package:event2go/features/chat/contacts_selection_widget.dart';
import 'package:event2go/features/chat/contactsbloc/contacts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatWidget extends StatefulWidget {
  static String tag = 'chat_list_view';

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<ChatWidget> {
  List<String> _chatList = [];

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
        child: Icon(Icons.add),
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
    setState(() {
      Navigator.push(context, MaterialPageRoute(
          // builder: (context) => SecondScreen())
          builder: (context) => BlocProvider(create: (_) => ContactsBloc(), child: ContactsSelectionWidget())),
      );
    });
  }

  @override
  dispose() {
    super.dispose();
  }
}