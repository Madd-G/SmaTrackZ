// import 'package:smatrackz/core.dart';
//
// class EmployeeModel extends UserEntity {
//   const EmployeeModel({
//     required super.uid,
//     required super.email,
//     required super.fullName,
//     super.workStart,
//     super.workEnd,
//     super.profilePic,
//     super.bio,
//     super.companyId,
//   });
//
//   const EmployeeModel.empty()
//       : this(
//           uid: '',
//           email: '',
//           fullName: '',
//         );
//
//   EmployeeModel.fromMap(DataMap map)
//       : super(
//           uid: map['uid'] as String,
//           email: map['email'] as String,
//           fullName: map['full_name'] as String,
//           workStart: map['work_start'] as String?,
//           workEnd: map['work_end'] as String?,
//           profilePic: map['profile_picture'] as String?,
//           bio: map['bio'] as String?,
//           companyId: map['company_id'] as String?,
//         );
//
//   EmployeeModel copyWith({
//     String? uid,
//     String? email,
//     String? profilePic,
//     String? bio,
//     String? fullName,
//     String? workStart,
//     String? workEnd,
//     String? companyId,
//   }) {
//     return EmployeeModel(
//         uid: uid ?? this.uid,
//         email: email ?? this.email,
//         profilePic: profilePic ?? this.profilePic,
//         bio: bio ?? this.bio,
//         fullName: fullName ?? this.fullName,
//         workStart: workStart ?? this.workStart,
//         workEnd: workEnd ?? this.workEnd,
//         companyId: companyId ?? this.companyId,
//     );
//   }
//
//   DataMap toMap() {
//     return {
//       'uid': uid,
//       'email': email,
//       'profile_picture': profilePic,
//       'work_start': workStart,
//       'work_end': workEnd,
//       'bio': bio,
//       'full_name': fullName,
//       'company_id': companyId,
//     };
//   }
// }
