import 'package:smatrackz/core.dart';

abstract class ChatRepo {
  const ChatRepo();

  ResultFuture<void> sendMessage(MessageEntity message);

  ResultStream<List<MessageEntity>> getMessages(String groupId);

}
