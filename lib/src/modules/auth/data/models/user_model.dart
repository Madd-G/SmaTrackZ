import 'package:smatrackz/core.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    super.workStart,
    super.workEnd,
    super.profilePic,
    super.bio,
    super.created,
    super.companyId,
  });

  const UserModel.empty()
      : this(
          uid: '',
          email: '',
          fullName: '',
          created: '',
        );

  UserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          fullName: map['full_name'] as String,
          workStart: map['work_start'] as String?,
          workEnd: map['work_end'] as String?,
          profilePic: map['profile_picture'] as String?,
          bio: map['bio'] as String?,
          created: map['created'] as String?,
          companyId: map['company_id'] as String?,
        );

  UserModel copyWith({
    String? uid,
    String? email,
    String? profilePic,
    String? bio,
    String? fullName,
    String? workStart,
    String? workEnd,
    String? created,
    String? companyId,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      fullName: fullName ?? this.fullName,
      workStart: workStart ?? this.workStart,
      workEnd: workEnd ?? this.workEnd,
      created: created ?? this.created,
      companyId: companyId ?? this.companyId,
    );
  }

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'profile_picture': profilePic,
      'work_start': workStart,
      'work_end': workEnd,
      'bio': bio,
      'full_name': fullName,
      'created': created,
      'company_id': companyId,
    };
  }
}
