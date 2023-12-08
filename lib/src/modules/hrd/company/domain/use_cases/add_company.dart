import 'package:smatrackz/core.dart';

class AddCompany extends FutureUseCaseWithParams<void, AddCompanyParams> {
  const AddCompany(this._repo);

  final CompanyRepository _repo;

  @override
  ResultFuture<void> call(AddCompanyParams params) => _repo.addCompany(
        companyId: params.companyId,
        companyName: params.companyName,
        address: params.address,
        latitude: params.latitude,
        longitude: params.longitude,
        website: params.website,
        workStart: params.workStart,
        workEnd: params.workEnd,
        phoneNumber: params.phoneNumber,
      );
}

class AddCompanyParams extends Equatable {
  final String companyId;
  final String companyName;
  final String address;
  final double latitude;
  final double longitude;
  final String website;
  final String workStart;
  final String workEnd;
  final String phoneNumber;

  const AddCompanyParams({
    required this.companyId,
    required this.companyName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.website,
    required this.workStart,
    required this.workEnd,
    required this.phoneNumber,
  });

  const AddCompanyParams.empty()
      : this(
          companyId: '',
          companyName: '',
          address: '',
          latitude: 0.0,
          longitude: 0.0,
          website: '',
          workStart: '',
          workEnd: '',
          phoneNumber: '',
        );

  @override
  List<Object?> get props => [
        companyId,
        companyName,
        address,
        latitude,
        longitude,
        website,
        workStart,
        workEnd,
        phoneNumber
      ];
}
