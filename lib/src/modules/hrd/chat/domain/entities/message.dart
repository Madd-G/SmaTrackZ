import 'package:smatrackz/core.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.senderId,
    required this.message,
    required this.timestamp,
    required this.groupId,
  });

  Message.empty()
      : id = '',
        senderId = '',
        message = '',
        groupId = '',
        timestamp = DateTime.now();

  final String id;
  final String senderId;
  final String message;
  final String groupId;
  final DateTime timestamp;

  @override
  String toString() {
    return 'Message{id: $id, sender_id: $senderId, message: $message, id: '
        '$groupId, timestamp: $timestamp}';
  }

  @override
  List<Object> get props => [id, groupId];
}
