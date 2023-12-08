// import 'package:smatrackz/core.dart';
//
// class EmployeeModel extends UserEntity {
//   const EmployeeModel({
//     required super.uid,
//     required super.email,
//     required super.companyName,
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
//           companyName: '',
//         );
//
//   EmployeeModel.fromMap(DataMap map)
//       : super(
//           uid: map['uid'] as String,
//           email: map['email'] as String,
//           companyName: map['company_name'] as String,
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
//     String? companyName,
//     String? workStart,
//     String? workEnd,
//     String? companyId,
//   }) {
//     return EmployeeModel(
//         uid: uid ?? this.uid,
//         email: email ?? this.email,
//         profilePic: profilePic ?? this.profilePic,
//         bio: bio ?? this.bio,
//         companyName: companyName ?? this.companyName,
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
//       'company_name': companyName,
//       'company_id': companyId,
//     };
//   }
// }
