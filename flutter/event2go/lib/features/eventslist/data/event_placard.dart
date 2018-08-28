class EventPlacard {

  final String eventId;
  final DateTime dateStart;
  final DateTime dateEnd;
  final AttendeeCounts counts;
}

class AttendeeCounts {
  int coming;
  int needsAction;
  int tentative;
  int notComing;
}