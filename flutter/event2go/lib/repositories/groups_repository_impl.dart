import 'package:dio/dio.dart';
import 'package:event2go/network/network_exception.dart';
import 'package:event2go/network/services/groups_service.dart';
import 'package:event2go/repositories/mapper/groups_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:models/models.dart';
import 'package:models/models/contact.dart';

import '../network/dio_exception.dart';
import '../network/raw_models/group.dart'  as rawGroup;
import '../network/raw_models/contact.dart' as rawContact;

class GroupsRepositoryImp extends GroupsRepository {
  final GroupsService groupsService;

  GroupsRepositoryImp({required this.groupsService});

  String test = "HELLO WORLD";

  @override
  Future<List<Group>> getGroups() async {
    try {
      final response = await groupsService.groups();
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

  @override
  Future<Group> addGroup(String title, List<Contact> contacts) async {
    try {
      List<rawContact.Contact> rawContacts = contacts.map((e) => e.toRawContact()).toList();
      final response = await groupsService.add(title, rawContacts);
      print("GroupsRepositoryImp addGroup");
      final data = response.data['group'];
      return rawGroup.Group.fromJson(data).toGroup();
    }  on NetworkException catch (e) {
      throw e.message;
    }
  }

  @override
  Future<Group> update(Group group) async {
    try {
      final response = await groupsService.update(
          group.id!,
          group.title,
          group.contacts.map((e) => e.toRawContact()).toList());
      return group;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  @override
  Future<void> delete(int groupId) async {
    try {
      await groupsService.delete(groupId);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

}

