import 'package:smatrackz/core.dart';

class OfficeEntity extends Equatable {
  final String officeName;
  final String address;
  final double latitude;
  final double longitude;

  const OfficeEntity({
    required this.officeName,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        officeName,
        address,
        latitude,
        longitude,
      ];

  @override
  String toString() {
    return 'OfficeEntity { '
        '\n officeName: $officeName, '
        '\n address: $address, '
        '\n latitude: $latitude, '
        '\n longitude: $longitude, '
        '\n}';
  }
}
