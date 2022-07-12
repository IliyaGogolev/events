import '../models/group.dart';

abstract class GroupsRepository {
  Future<List<Group>> getGroups();
}