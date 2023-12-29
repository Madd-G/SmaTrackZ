// part of 'company_bloc.dart';
//
// @immutable
// abstract class CompanyEvent {}
//
// class LoadCompanyEvent extends CompanyEvent {
//   final String companyId;
//
//   LoadCompanyEvent({required this.companyId});
// }
//
// class AddCompanyEvent extends CompanyEvent {
//   final String? companyId;
//   final String? name;
//   final String? address;
//   final String? website;
//   final double? latitude;
//   final double? longitude;
//   final String? workStart;
//   final String? workEnd;
//   final String? phoneNumber;
//   final String? createdAt;
//
//   AddCompanyEvent({
//     this.companyId,
//     this.name,
//     this.address,
//     this.website,
//     this.latitude,
//     this.longitude,
//     this.workStart,
//     this.workEnd,
//     this.phoneNumber,
//     this.createdAt,
//   });
// }
//
// class UpdateCompanyEvent extends CompanyEvent {
//   UpdateCompanyEvent({
//     required this.action,
//     required this.companyData,
//   });
//
//   // : assert(
//   //     companyData is String || companyData is File,
//   //     '[userData] must be either a String or a File, but '
//   //     'was ${companyData.runtimeType}',
//   //   );
//
//   final UpdateCompanyAction action;
//   final dynamic companyData;
//
//   List<Object?> get props => [action, companyData];
// }
//
// class UpdateLocationEvent extends CompanyEvent {
//   final String companyId;
//   final double latitude;
//   final double longitude;
//
//   UpdateLocationEvent({
//     required this.companyId,
//     required this.latitude,
//     required this.longitude,
//   });
// }
