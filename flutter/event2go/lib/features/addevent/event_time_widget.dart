import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// used tutorial:
// https://medium.com/flutter-community/breaking-layouts-in-rows-and-columns-in-flutter-8ea1ce4c1316

class EventTimeItem extends StatefulWidget {

  @override
  _DateState createState() => new _DateState();
}

class _DateState extends State<EventTimeItem> {
  TextEditingController _c;

  var _formatter = new DateFormat('MM-dd-yyyy');

  DateTime _date;
  TimeOfDay _time;
  String _dateText;
  String _timeText;

  @override
  void initState() {
    _c = new TextEditingController();

    _date = new DateTime.now();
    _time = new TimeOfDay.now();
    _dateText = _formatter.format(_date);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _timeText = _time.format(context);

    return new Container(
      child: new Row(
        children: <Widget>[
          getDateTextView(context),
          getTimeTextView(context)
        ],
      ),
    );
  }

  Widget getDateTextView(BuildContext context) {
    return new Expanded(
      child: new Container(
//      padding: new EdgeInsets.only(left: 8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new GestureDetector(
              child: new Text('$_dateText',
                  style: new TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  )),
              onTap: () => showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: _date.subtract(new Duration(days: 30)),
                    lastDate: _date.add(new Duration(days: 30)),
                  ).then((value) {
                    _onDateChanged(value);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTimeTextView(BuildContext context) {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new GestureDetector(
              child: new Text(
                '$_timeText',
//                "9:50",
                style: new TextStyle(fontSize: 16.0),
              ),
              onTap: () => showTimePicker(context: context, initialTime: _time)
                      .then((value) {
                    _onTimeChanged(value, context);
                  })),
        ],
      ),
    );
  }

  void _onDateChanged(date) {
    setState(() {
      // If the lake is currently favorited, unfavorite it.
      if (date != null) {
        _date = date;
        _dateText = _formatter.format(date);
      }
    });
  }

  void _onTimeChanged(time, context) {
    setState(() {
      // If the lake is currently favorited, unfavorite it.
      if (time != null) {
        _time = time;
        _timeText =_time.format(context);
      }
    });
  }
}
