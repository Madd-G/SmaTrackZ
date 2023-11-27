import 'package:smatrackz/core.dart';

class OfficeModel extends OfficeEntity {
  const OfficeModel({
    required super.officeId,
    required super.officeName,
    required super.address,
    required super.latitude,
    required super.longitude,
    required super.website,
  });

  const OfficeModel.empty()
      : this(
          officeId: '',
          officeName: '',
          address: '',
          latitude: 0.0,
          longitude: 0.0,
          website: '',
        );

  OfficeModel.fromMap(DataMap map)
      : super(
          officeId: map['office_id'] as String,
          officeName: map['office_name'] as String,
          address: map['address'] as String,
          latitude: map['latitude'] as double,
          longitude: map['longitude'] as double,
          website: map['website'] as String,
        );

  OfficeModel copyWith({
    String? officeId,
    String? officeName,
    String? address,
    double? latitude,
    double? longitude,
    String? website,
  }) {
    return OfficeModel(
      officeId: officeId ?? this.officeId,
      officeName: officeName ?? this.officeName,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      website: website ?? this.website,
    );
  }

  DataMap toMap() {
    return {
      'office_id': officeId,
      'office_name': officeName,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'website': website,
    };
  }
}
