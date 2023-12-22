import 'package:smatrackz/core.dart';

class GroupModel extends GroupEntity {
  const GroupModel({
    required super.id,
    required super.name,
    required super.members,
    required super.companyId,
    super.lastMessage,
    super.lastMessageSenderName,
    super.lastMessageTimestamp,
    super.groupImageUrl,
    super.imageIsFile = false,
  });

  GroupModel.empty()
      : this(
          id: '',
          name: '',
          members: const [],
          lastMessage: '',
          companyId: '',
          groupImageUrl: '',
          lastMessageSenderName: '',
          lastMessageTimestamp: DateTime.now(),
        );

  GroupModel.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          companyId: map['company_id'] as String,
          members: List<String>.from(map['members'] as List<dynamic>),
          lastMessage: map['last_message'] as String?,
          lastMessageSenderName: map['last_message_sender_name'] as String?,
          lastMessageTimestamp:
              (map['last_message_timestamp'] as Timestamp?)?.toDate(),
          groupImageUrl: map['group_image_url'] as String?,
        );

  GroupModel copyWith({
    String? id,
    String? name,
    String? companyId,
    List<String>? members,
    DateTime? lastMessageTimestamp,
    String? lastMessageSenderName,
    String? lastMessage,
    String? groupImageUrl,
    bool? imageIsFile,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      companyId: companyId ?? this.companyId,
      members: members ?? this.members,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSenderName:
          lastMessageSenderName ?? this.lastMessageSenderName,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      groupImageUrl: groupImageUrl ?? this.groupImageUrl,
      imageIsFile: imageIsFile ?? this.imageIsFile,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'company_id': companyId,
      'name': name,
      'members': members,
      'last_message': lastMessage,
      'last_message_sender_name': lastMessageSenderName,
      'last_message_timestamp':
          lastMessage == null ? null : FieldValue.serverTimestamp(),
      'group_image_url': groupImageUrl,
    };
  }
}
