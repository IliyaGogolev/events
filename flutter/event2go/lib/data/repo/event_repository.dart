import 'dart:math';

import '../event.dart';

class EventRepository {

  List<Event> events = new List();

  void createEvent(Event event) {
    events.add(event);
  }
}