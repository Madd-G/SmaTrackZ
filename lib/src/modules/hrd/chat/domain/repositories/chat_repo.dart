import 'package:smatrackz/core.dart';

abstract class ChatRepo {
  const ChatRepo();

  ResultFuture<void> sendMessage(MessageEntity message);

  ResultStream<List<GroupEntity>> getGroups();

  ResultStream<List<MessageEntity>> getMessages(String groupId);

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
