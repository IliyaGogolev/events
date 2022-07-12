import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:models/models.dart';

part 'group_event.dart';

part 'group_state.dart';

class GroupBloc extends Bloc<GroupLoadedEvent, GroupState> {
  Group _group;

  Group get selectedGroupProfile => _group;

  GroupBloc() : super(GroupStateInitial()) {
    on<GroupLoadedEvent>(_onGroupLoadedEvent);
    // on<GroupProfileelectedEvent>(_onGroupProfileelectedEvent);
  }

  void _onGroupLoadedEvent(
    GroupLoadedEvent event,
    Emitter<GroupState> emit,
  ) async {
    _group = event.group;
    print("_onGroupProfileLoadedEvent $_group");
    emit(GroupStateLoaded(_group));
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
