import 'package:smatrackz/core.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.senderId,
    required super.senderName,
    required super.message,
    required super.timestamp,
    required super.groupId,
  });

  MessageModel.empty()
      : this(
    id: '',
    senderId: '',
    senderName: '',
    message: '',
    groupId: '',
    timestamp: DateTime.now(),
  );

  MessageModel.fromMap(DataMap map)
      : this(
    id: map['id'] as String,
    senderId: map['sender_id'] as String,
    senderName: map['sender_name'] as String,
    message: map['message'] as String,
    groupId: map['group_id'] as String,
    timestamp:
    (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
  );

  MessageModel copyWith({
    String? id,
    String? senderId,
    String? senderName,
    String? message,
    String? groupId,
    DateTime? timestamp,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      message: message ?? this.message,
      groupId: groupId ?? this.groupId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'id': id,
      'sender_id': senderId,
      'sender_name': senderName,
      'message': message,
      'group_id': groupId,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
