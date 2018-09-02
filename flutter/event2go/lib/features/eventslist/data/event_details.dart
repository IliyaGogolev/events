import 'attendee.dart';

class EventDetails {

  String eventId;
  List<Attendee> attendees = new List<Attendee>();

  void addAttendee(Attendee attendee) {
    attendees.add(attendee);
  }
}
