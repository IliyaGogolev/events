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

