import 'package:models/models.dart';

abstract class GroupsRepository {
  Future<List<Group>> getGroups({required String userId});
}