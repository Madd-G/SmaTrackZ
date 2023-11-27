import 'package:smatrackz/core.dart';

class UserEntity extends Equatable {
  // TODO: add department id
  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final String fullName;
  final String? workStart;
  final String? workEnd;
  final String? created;
  final String? companyId;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.fullName,
    this.workStart,
    this.workEnd,
    this.profilePic,
    this.bio,
    this.created,
    this.companyId,
  });

  const UserEntity.empty()
      : this(
          uid: '',
          email: '',
          fullName: '',
          profilePic: '',
          bio: '',
          workStart: '',
          workEnd: '',
          created: '',
          companyId: '',
        );

  bool get isAdmin => email == 'admin@gmail.com';

  @override
  List<Object?> get props => [
        uid,
        email,
        profilePic,
        bio,
        fullName,
        workStart,
        workEnd,
        created,
        companyId,
      ];

  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email, created: $created, bio: '
        '$bio, fullName: $fullName}, workStart: $workStart, workEnd: $workEnd, companyId: $companyId';
  }
}
