//import 'package:event2go/data/event.dart';
import 'package:event2go/data/event.dart';
import 'package:event2go/data/repo/event_repository.dart';

class CreateEventUseCase {

  CreateEventUseCase({required this.repository});

  EventRepository repository;

  void createEvent(Event event) {
    print("CreateEventUseCase.createEvent ${event.name}");
    print("createEvent startAt: ${event.startAt}");
    print("createEvent endAt: ${event.endAt}");
    repository.createEvent(event);
  }
}
