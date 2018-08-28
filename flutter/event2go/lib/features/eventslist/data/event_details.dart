import 'attendee.dart';

class EventDetails {
  final String eventId;
  List<Attendee> attendees = new List<Attendee>();

  void addAttendee(Attendee attendee) {
    attendees.add(attendee);
  }
}
