import 'attendee.dart';

class EventDetails {

  late String eventId;
  List<Attendee> attendees = [];

  void addAttendee(Attendee attendee) {
    attendees.add(attendee);
  }
}
