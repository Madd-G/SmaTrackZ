part of 'office_bloc.dart';

@immutable
abstract class OfficeEvent {}

class LoadOfficeEvent extends OfficeEvent {}

class UpdateOfficeEvent extends OfficeEvent {
  final String officeName;
  final String address;
  final double latitude;
  final double longitude;

  UpdateOfficeEvent({
    required this.officeName,
    required this.address,
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


