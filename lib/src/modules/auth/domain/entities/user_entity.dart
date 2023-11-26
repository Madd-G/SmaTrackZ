import 'package:smatrackz/core.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.uid,
    required this.email,
    required this.fullName,
    this.workStart,
    this.workEnd,
    this.profilePic,
    this.bio,
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
        );

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final String fullName;
  final String? workStart;
  final String? workEnd;

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
      ];

  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email, bio: '
        '$bio, fullName: $fullName}, workStart: $workStart, workEnd: $workEnd';
  }
}
