// import 'package:smatrackz/core.dart';
//
// class CompanyModel extends CompanyEntity {
//   const CompanyModel({
//     super.companyId,
//     super.companyName,
//     super.email,
//     super.address,
//     super.website,
//     super.phoneNumber,
//     super.profilePicture,
//     super.bio,
//     super.latitude,
//     super.longitude,
//     super.workStart,
//     super.workEnd,
//     super.created,
//   });
//
//   const CompanyModel.empty()
//       : this(
//           companyId: '',
//           companyName: '',
//           email: '',
//           address: '',
//           website: '',
//           phoneNumber: '',
//           profilePicture: '',
//           bio: '',
//           latitude: 0,
//           longitude: 0,
//           workStart: '',
//           workEnd: '',
//           created: '',
//         );
//
//   CompanyModel.fromMap(DataMap map)
//       : super(
//           companyId: map['company_id'] as String,
//           companyName: map['company_name'] as String,
//           email: map['email'] as String,
//           address: map['address'] as String,
//           website: map['website'] as String,
//           phoneNumber: map['phone_number'] as String,
//           profilePicture: map['profile_picture'] as String?,
//           bio: map['bio'] as String?,
//           latitude: map['latitude'] as num?,
//           longitude: map['longitude'] as num?,
//           workStart: map['work_start'] as String?,
//           workEnd: map['work_end'] as String?,
//           created: map['created'] as String?,
//         );
//
//   CompanyModel copyWith({
//     String? companyId,
//     String? companyName,
//     String? email,
//     String? address,
//     String? website,
//     String? phoneNumber,
//     String? profilePicture,
//     String? bio,
//     num? latitude,
//     num? longitude,
//     String? workStart,
//     String? workEnd,
//     String? created,
//   }) {
//     return CompanyModel(
//       companyId: companyId ?? this.companyId,
//       companyName: companyName ?? this.companyName,
//       email: email ?? this.email,
//       address: address ?? this.address,
//       website: website ?? this.website,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       profilePicture: profilePicture ?? this.profilePicture,
//       bio: bio ?? this.bio,
//       latitude: latitude ?? this.latitude,
//       longitude: longitude ?? this.longitude,
//       workStart: workStart ?? this.workStart,
//       workEnd: workEnd ?? this.workEnd,
//       created: created ?? this.created,
//     );
//   }
//
//   DataMap toMap() {
//     return {
//       'company_id': companyId,
//       'company_name': companyName,
//       'email': email,
//       'address': address,
//       'website': website,
//       'phone_number': phoneNumber,
//       'profile_picture': profilePicture,
//       'bio': bio,
//       'latitude': latitude,
//       'longitude': longitude,
//       'work_start': workStart,
//       'work_end': workEnd,
//       'created': created,
//     };
//   }
// }
