import 'package:smatrackz/core.dart';

class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    super.uid,
    required super.email,
    required super.username,
    super.workStart,
    super.workEnd,
    super.profilePicture,
    super.bio,
    super.companyId,
    super.role,
  });

  const EmployeeModel.empty()
      : this(
          uid: '',
          email: '',
          username: '',
        );

  EmployeeModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          username: map['username'] as String,
          email: map['email'] as String,
          workStart: map['work_start'] as String?,
          workEnd: map['work_end'] as String?,
          profilePicture: map['profile_picture'] as String?,
          bio: map['bio'] as String?,
          companyId: map['company_id'] as String?,
          role: map['role'] as String?,
        );

  EmployeeModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? profilePicture,
    String? bio,
    String? workStart,
    String? workEnd,
    String? companyId,
    String? role,
  }) {
    return EmployeeModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      workStart: workStart ?? this.workStart,
      workEnd: workEnd ?? this.workEnd,
      companyId: companyId ?? this.companyId,
      role: role ?? this.role,
    );
  }

  DataMap toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profile_picture': profilePicture,
      'work_start': workStart,
      'work_end': workEnd,
      'bio': bio,
      'company_id': companyId,
      'role': role,
    };
  }
}
