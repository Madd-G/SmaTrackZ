import 'package:smatrackz/core.dart';

class OfficeModel extends OfficeEntity {
  const OfficeModel({
    required super.officeName,
    required super.address,
    required super.latitude,
    required super.longitude,
  });

  const OfficeModel.empty()
      : this(
          officeName: '',
          address: '',
          latitude: 0.0,
          longitude: 0.0,
        );

  OfficeModel.fromMap(DataMap map)
      : super(
          officeName: map['office_name'] as String,
          address: map['address'] as String,
          latitude: map['latitude'] as double,
          longitude: map['longitude'] as double,
        );

  OfficeModel copyWith({
    String? officeName,
    String? address,
    double? latitude,
    double? longitude,
  }) {
    return OfficeModel(
      officeName: officeName ?? this.officeName,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  DataMap toMap() {
    return {
      'office_name': officeName,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
