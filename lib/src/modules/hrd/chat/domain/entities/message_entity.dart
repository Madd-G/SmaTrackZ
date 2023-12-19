import 'package:smatrackz/core.dart';

class MessageEntity extends Equatable {
  const MessageEntity({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.timestamp,
    required this.groupId,
  });

  MessageEntity.empty()
      : id = '',
        senderId = '',
        senderName = '',
        message = '',
        groupId = '',
        timestamp = DateTime.now();

  final String id;
  final String senderId;
  final String senderName;
  final String message;
  final String groupId;
  final DateTime timestamp;

  @override
  String toString() {
    return '\n Message{'
        '\n id: $id, '
        '\n sender_id: $senderId, '
        '\n sender_name: $senderName, '
        '\n message: $message, '
        '\n id: $groupId, '
        '\n timestamp: $timestamp'
        '\n }';
  }

  @override
  List<Object> get props => [id, groupId];
}
