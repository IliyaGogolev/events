import 'dart:math';

import '../event.dart';

class EventRepository {

  List<Event> events = [];

  void createEvent(Event event) {
    events.add(event);
  }
}