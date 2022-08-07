part of 'group_bloc.dart';

@immutable
abstract class GroupState extends Equatable {
  const GroupState();
}

class GroupStateInitial extends GroupState {

  @override
  List<Object> get props => [];
}

class GroupStateLoaded extends GroupState {
  const GroupStateLoaded(this.group);

  final Group group;

  @override
  List<Object> get props => [group];

  @override
  String toString() => 'GroupStateLoaded $group';
}

class GroupStateError extends GroupState {
  const GroupStateError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'GroupStateError, message $message';
}

class GroupCreated extends GroupState {
  const GroupCreated(this.group);

  final Group group;

  @override
  List<Object> get props => [group];

}

