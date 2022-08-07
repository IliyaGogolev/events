part of 'group_bloc.dart';

@immutable
abstract class GroupEvent extends Equatable {
  const GroupEvent();
}

class GroupLoadedEvent extends GroupEvent {
  const GroupLoadedEvent({required this.group});

  final Group group;

  @override
  List<Object> get props => [group];

  @override
  String toString() => 'Group $group';
}

class CreateGroupEvent extends GroupEvent {
  CreateGroupEvent({required this.title});
  final String title;

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'CreateGroupEvent title $title';

}

class ErrorDialogDismissedCreateGroupEvent extends GroupEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ErrorDialogDismissedCreateGroupEvent';

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

