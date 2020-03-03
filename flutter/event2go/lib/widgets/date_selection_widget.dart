import 'package:event2go/utils/pair.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// used tutorial:
// https://medium.com/flutter-community/breaking-layouts-in-rows-and-columns-in-flutter-8ea1ce4c1316
// TODO add address auto complete https://www.youtube.com/watch?v=cRw7s4p9vn8

///  Pass `new DateTime.now()` as date to set up default value;
class DateSelectionWidget extends StatefulWidget {
  final ValueChanged<DateTime> onChange;
  DateTime date;

  DateSelectionWidget({DateTime date, TimeOfDay time, this.onChange, Key key})
      : date = date ?? DateTime.now(),
        super(key: key);

  @override
  _DateState createState() => new _DateState();
}

class _DateState extends State<DateSelectionWidget> {
  TextEditingController _c;

  var _formatter = new DateFormat('MM-dd-yyyy');

  String _dateText;
  String _timeText;

  @override
  void initState() {
    _c = new TextEditingController();
    _dateText = _formatter.format(widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay time = TimeOfDay.fromDateTime(widget.date);
    _timeText = time.format(context);

    return new Container(
      child: new Row(
        children: <Widget>[getDateTextView(context), getTimeTextView(context)],
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
                initialDate: widget.date,
                firstDate: widget.date.subtract(new Duration(days: 30)),
                lastDate: widget.date.add(new Duration(days: 30)),
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
              onTap: () =>
                  showTimePicker(context: context, initialTime: getTime())
                      .then((value) {
                    _onTimeChanged(value, context);
                  })),
        ],
      ),
    );
  }

  void _onDateChanged(date) {
    setState(() {
      if (date != null) {
        widget.date = new DateTime(date.year, date.month,
            date.day, widget.date.hour, widget.date.minute);
        _dateText = _formatter.format(date);
        onDateTimeChanged();
      }
    });
  }

  void _onTimeChanged(time, context) {
    setState(() {
      // If the lake is currently favorited, unfavorite it.
      if (time != null) {
//        widget.time = time;
        widget.date = new DateTime(widget.date.year, widget.date.month,
            widget.date.day, time.hour, time.minute);
        _timeText = time.format(context);
        onDateTimeChanged();
      }
    });
  }

  void onDateTimeChanged() {
    widget.onChange(widget.date);
  }

  TimeOfDay getTime() {
    return TimeOfDay.fromDateTime(widget.date);
  }
}
