import 'package:smatrackz/core.dart';

class EmployeeEntity extends Equatable {
  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final String companyName;
  final String? workStart;
  final String? workEnd;
  final String? companyId;

  const EmployeeEntity(
      {required this.uid,
      required this.email,
      required this.companyName,
      this.workStart,
      this.workEnd,
      this.profilePic,
      this.bio,
      this.companyId,});

  const EmployeeEntity.empty()
      : this(
          uid: '',
          email: '',
          companyName: '',
          profilePic: '',
          bio: '',
          workStart: '',
          workEnd: '',
          companyId: '',
        );

  bool get isAdmin => email == 'admin@gmail.com';

  @override
  List<Object?> get props => [
        uid,
        email,
        profilePic,
        bio,
        companyName,
        workStart,
        workEnd,
        companyId,
      ];

  @override
  String toString() {
    return 'EmployeeEntity{uid: $uid, email: $email, bio: '
        '$bio, companyName: $companyName}, work_start: $workStart, work_end: $workEnd, companyId: $companyId';
  }
}
