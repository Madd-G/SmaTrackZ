part of 'office_bloc.dart';

@immutable
abstract class OfficeEvent {}

class LoadOfficeEvent extends OfficeEvent {}

class AddOfficeEvent extends OfficeEvent {
  final String officeId;
  final String name;
  final String address;
  final String website;
  final double latitude;
  final double longitude;

  AddOfficeEvent({
    required this.officeId,
    required this.name,
    required this.address,
    required this.website,
    required this.latitude,
    required this.longitude,
  });
}

class UpdateOfficeEvent extends OfficeEvent {
  final String officeId;
  final String name;
  final String address;
  final String website;
  final double latitude;
  final double longitude;

  UpdateOfficeEvent({
    required this.officeId,
    required this.name,
    required this.address,
    required this.website,
    required this.latitude,
    required this.longitude,
  });
}

class UpdateLocationEvent extends OfficeEvent {
  final double latitude;
  final double longitude;

  UpdateLocationEvent({
    required this.latitude,
    required this.longitude,
  });
}
