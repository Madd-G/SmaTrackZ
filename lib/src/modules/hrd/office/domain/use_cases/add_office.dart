import 'package:smatrackz/core.dart';

class AddOffice extends FutureUseCaseWithParams<void, AddOfficeParams> {
  const AddOffice(this._repo);

  final OfficeRepository _repo;

  @override
  ResultFuture<void> call(AddOfficeParams params) => _repo.addOffice(
        officeId: params.officeId,
        officeName: params.officeName,
        address: params.address,
        latitude: params.latitude,
        longitude: params.longitude,
        website: params.website,
        workingTime: params.workingTime,
        phoneNumber: params.phoneNumber,
      );
}

class AddOfficeParams extends Equatable {
  final String officeId;
  final String officeName;
  final String address;
  final double latitude;
  final double longitude;
  final String website;
  final String workingTime;
  final String phoneNumber;

  const AddOfficeParams({
    required this.officeId,
    required this.officeName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.website,
    required this.workingTime,
    required this.phoneNumber,
  });

  const AddOfficeParams.empty()
      : this(
          officeId: '',
          officeName: '',
          address: '',
          latitude: 0.0,
          longitude: 0.0,
          website: '',
          workingTime: '',
          phoneNumber: '',
        );

  @override
  List<Object?> get props => [
        officeId,
        officeName,
        address,
        latitude,
        longitude,
        website,
        workingTime,
        phoneNumber
      ];
}
