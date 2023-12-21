import 'package:smatrackz/core.dart';

abstract class GroupRepo {
  const GroupRepo();

  ResultStream<List<GroupEntity>> getGroups();

  ResultFuture<void> joinGroup({
    required String groupId,
    required String userId,
  });

  ResultFuture<void> leaveGroup({
    required String groupId,
    required String userId,
  });

  ResultFuture<UserEntity> getUserById(String userId);

}
