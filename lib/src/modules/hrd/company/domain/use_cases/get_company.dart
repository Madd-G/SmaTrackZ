// import 'package:smatrackz/core.dart';
//
// class GetCompany extends FutureUseCaseWithParams<void, GetCompanyParams> {
//   const GetCompany(this._companyRepo);
//
//   final CompanyRepository _companyRepo;
//
//   @override
//   ResultFuture<CompanyModel> call(GetCompanyParams params) async =>
//       _companyRepo.getCompany(params.companyId);
// }
//
// class GetCompanyParams extends Equatable {
//   final String companyId;
//
//   const GetCompanyParams({
//     required this.companyId,
//   });
//
//   const GetCompanyParams.empty()
//       : this(
//           companyId: '',
//         );
//
//   @override
//   List<Object?> get props => [
//         companyId,
//       ];
// }
