import 'package:smatrackz/core.dart';

class OfficeEntity extends Equatable {
  final String officeId;
  final String officeName;
  final String address;
  final double latitude;
  final double longitude;
  final String website;
  final String workingTime;
  final String phoneNumber;

  const OfficeEntity({
    required this.officeId,
    required this.officeName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.website,
    required this.workingTime,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        officeId,
        officeName,
        address,
        latitude,
        longitude,
        website,
        workingTime,
        phoneNumber,
      ];

  @override
  String toString() {
    return 'OfficeEntity { '
        '\n office_id: $officeId, '
        '\n office_name: $officeName, '
        '\n address: $address, '
        '\n latitude: $latitude, '
        '\n longitude: $longitude, '
        '\n website: $website, '
        '\n working_time: $workingTime, '
        '\n phone_number: $phoneNumber, '
        '\n}';
  }
}
