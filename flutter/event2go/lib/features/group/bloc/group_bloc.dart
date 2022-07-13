import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:models/models.dart';

part 'group_event.dart';

part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  Group group;

  final GroupsRepository groupsRepository;

  // Group get group => _group;

  GroupBloc({this.group, @required this.groupsRepository}) : super(GroupStateInitial()) {
    // GroupBloc({this.group}) : super(GroupStateInitial()) {
    on<GroupLoadedEvent>(_onGroupLoadedEvent);
    on<CreateGroupEvent>(_onCreateGroupEvent);
    on<ErrorDialogDismissedCreateGroupEvent>(_onErrorDialogDismissedCreateGroupEvent);
  }

  void _onGroupLoadedEvent(
    GroupLoadedEvent event,
    Emitter<GroupState> emit,
  ) async {
    group = event.group;
    print("_onGroupProfileLoadedEvent $group");
    emit(GroupStateLoaded(group));
  }

  void _onCreateGroupEvent(
    CreateGroupEvent event,
    Emitter<GroupState> emit,
  ) async {
    print("_onCreateGroupEvent $event");

    groupsRepository.addGroup(event.title, group.contacts).then((value) {
      print("_onCreateGroupEvent created");
      group.title = event.title;
      emit(GroupCreated(group));
    }).onError((error, stackTrace) {
      print("_onCreateGroupEvent onError");
      GroupStateError error = GroupStateError(message: "We're sorry, but something went wrong. Please try again");
      emit(error);
    });
  }

  void _onErrorDialogDismissedCreateGroupEvent(
    ErrorDialogDismissedCreateGroupEvent event,
    Emitter<GroupState> emit,
  ) async {
    print("_onErrorDialogDismissedCreateGroupEvent");
    emit(GroupStateLoaded(group));
  }
// void _onGroupProfileelectedEvent(
//   GroupProfileelectedEvent event,
//   Emitter<GroupProfileState> emit,
// ) async {
//   if (event.selected) {
//     print ("contact added ${event.group.displayName}");
//     _selectedGroupProfile.add(event.group);
//   } else {
//     _selectedGroupProfile.remove(event.group);
//   }
//   emit(GroupProfileSelected(event.group, event.selected));
// }
}
