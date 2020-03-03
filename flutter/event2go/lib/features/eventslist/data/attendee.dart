class Attendee {

  final AttendeeRole role;
  final String eventId;
  final String userId;

  Attendee(this.eventId,
      this.userId,
      this.role);
}

enum AttendeeRole {
  admin,
  participant
}
