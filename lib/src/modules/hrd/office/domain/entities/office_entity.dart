import 'package:smatrackz/core.dart';

class OfficeEntity extends Equatable {
  final String officeId;
  final String officeName;
  final String address;
  final double latitude;
  final double longitude;
  final String website;

  const OfficeEntity({
    required this.officeId,
    required this.officeName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.website,
  });

  @override
  List<Object?> get props => [
        officeId,
        officeName,
        address,
        latitude,
        longitude,
        website,
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
        '\n}';
  }
}
