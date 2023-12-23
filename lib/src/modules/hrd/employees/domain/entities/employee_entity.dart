import 'package:smatrackz/core.dart';

class EmployeeEntity extends Equatable {
  final String? uid;
  final String username;
  final String email;
  final String? profilePicture;
  final String? bio;
  final String? workStart;
  final String? workEnd;
  final String? companyId;
  final String? role;
  final String? createdAt;
  final List<String>? groups;

  const EmployeeEntity({
    required this.uid,
    required this.username,
    required this.email,
    this.workStart,
    this.workEnd,
    this.profilePicture,
    this.bio,
    this.companyId,
    this.role,
    this.createdAt,
    this.groups,
  });

  const EmployeeEntity.empty()
      : this(
          uid: '',
          username: '',
          email: '',
          profilePicture: '',
          bio: '',
          workStart: '',
          workEnd: '',
          companyId: '',
          role: '',
          createdAt: '',
          groups: const [],
        );

  bool get isAdmin => email == 'admin@gmail.com';

  @override
  List<Object?> get props => [
        uid,
        username,
        email,
        profilePicture,
        bio,
        workStart,
        workEnd,
        companyId,
        role,
        createdAt,
        groups,
      ];

  @override
  String toString() {
    return 'EmployeeEntity{'
        'uid: $uid, '
        'username: $username, '
        'email: $email, '
        'bio: $bio, '
        'work_start: $workStart, '
        'work_end: $workEnd, '
        'companyId: $companyId, '
        'role: $role, '
        'created_at: $createdAt, '
        'groups: $groups, '
        '}';
  }
}
