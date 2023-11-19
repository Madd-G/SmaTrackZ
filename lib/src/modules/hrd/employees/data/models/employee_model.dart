import 'package:smatrackz/core.dart';

class EmployeeModel extends LocalUser {
  const EmployeeModel({
    required super.uid,
    required super.email,
    required super.fullName,
    super.workStart,
    super.workEnd,
    super.profilePic,
    super.bio,
  });

  const EmployeeModel.empty()
      : this(
          uid: '',
          email: '',
          fullName: '',
        );

  EmployeeModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          fullName: map['fullName'] as String,
          workStart: map['workStart'] as String?,
          workEnd: map['workEnd'] as String?,
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
        );

  EmployeeModel copyWith({
    String? uid,
    String? email,
    String? profilePic,
    String? bio,
    String? fullName,
    String? workStart,
    String? workEnd,
  }) {
    return EmployeeModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        profilePic: profilePic ?? this.profilePic,
        bio: bio ?? this.bio,
        fullName: fullName ?? this.fullName,
        workStart: workStart ?? this.workStart,
        workEnd: workEnd ?? this.workEnd);
  }

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'profilePic': profilePic,
      'workStart': workStart,
      'workEnd': workEnd,
      'bio': bio,
      'fullName': fullName,
    };
  }
}