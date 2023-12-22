import 'package:smatrackz/core.dart';

class GroupEntity extends Equatable {
  const GroupEntity({
    required this.id,
    required this.name,
    required this.companyId,
    required this.members,
    this.lastMessage,
    this.groupImageUrl,
    this.lastMessageTimestamp,
    this.lastMessageSenderName,
    this.imageIsFile = false,
  });

  const GroupEntity.empty()
      : this(
          id: '',
          name: '',
          companyId: '',
          members: const [],
          lastMessage: null,
          groupImageUrl: null,
          lastMessageTimestamp: null,
          lastMessageSenderName: null,
        );

  final String id;
  final String name;
  final String companyId;
  final List<String> members;
  final String? lastMessage;
  final String? groupImageUrl;
  final DateTime? lastMessageTimestamp;
  final String? lastMessageSenderName;
  final bool imageIsFile;

  @override
  List<Object?> get props => [id, name, companyId];
}
