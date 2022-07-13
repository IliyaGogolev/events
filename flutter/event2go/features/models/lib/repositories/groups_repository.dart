import 'package:models/models/contact.dart';
import 'package:models/models/group.dart';

abstract class GroupsRepository {
  Future<List<Group>> getGroups();
  Future<Group> addGroup(String title, List<Contact> contacts);
  Future<Group> update(Group group);
  Future<void> delete(int groupId);
}