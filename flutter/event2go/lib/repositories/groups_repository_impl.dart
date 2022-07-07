import 'package:dio/dio.dart';
import 'package:event2go/network/api/groups_api.dart';
import 'package:models/models/contact.dart';
import 'package:models/models/group.dart';

import '../network/dio_exception.dart';
import '../network/raw_models/group.dart' as rawGroup;
import '../network/raw_models/contact.dart' as rawContact;

class GroupsRepository {
  final GroupsApi groupsApi;

  GroupsRepository(this.groupsApi);

  Future<List<Group>> getUsersRequested() async {
    try {
      final response = await groupsApi.groups();
      final groups = (response.data['data'] as List)
          .map((e) => rawGroup.Group.fromJson(e))
          .map((rawGroup) => rawGroup.toGroup())
          .toList();
      return groups;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Group> addGroup(String title, List<Contact> contacts) async {
    try {
      final response = await groupsApi.add(title, contacts.map((e) => e.toRawContact()));
      return Group(title: title, contacts: contacts);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Group> update(Group group) async {
    try {
      final response = await groupsApi.update(group.id, group.title, group.contacts.map((e) => e.toRawContact()));
      return group;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> deleteNewUserRequested(int groupId) async {
    try {
      await groupsApi.delete(groupId);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

extension RawGroupMapping on rawGroup.Group {
  ///Returns items that are not null, for UI Widgets/PopupMenuItems etc.
  Group toGroup() {
    return Group(title: this.title, contacts: this.contacts.map((e) => e.toContact()).toList());
  }
}

extension RawContactMapping on rawContact.Contact {
  Contact toContact() {
    return Contact(firstName: this.name);
  }
}

extension ContactToRawMapping on Contact {
  rawContact.Contact toRawContact() {
    return rawContact.Contact(name: this.firstName);
  }
}
