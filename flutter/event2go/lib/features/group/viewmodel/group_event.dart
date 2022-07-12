part of 'group_bloc.dart';

@immutable
abstract class GroupEvent extends Equatable {
  const GroupEvent();
}

class GroupLoadedEvent extends GroupEvent {
  const GroupLoadedEvent({@required this.group});

  final Group group;

  @override
  List<Object> get props => [group];

  @override
  String toString() => 'Group $group';
}

// class ContactSelectedEvent extends GroupEvent {
//   const ContactSelectedEvent({@required this.group, @required this.selected});
//
//   final Group group;
//   final bool selected;
//
//   @override
//   List<Object> get props => [group, selected];
//
//   @override
//   String toString() => 'Contact selected { contacts: $group, selected $selected }';
// }

