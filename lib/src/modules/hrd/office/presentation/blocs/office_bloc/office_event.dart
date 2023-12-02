part of 'office_bloc.dart';

@immutable
abstract class OfficeEvent {}

class LoadOfficeEvent extends OfficeEvent {
  final String officeId;

  LoadOfficeEvent({required this.officeId});
}

class AddOfficeEvent extends OfficeEvent {
  final String officeId;
  final String name;
  final String address;
  final String? website;
  final double? latitude;
  final double? longitude;
  final String? workingTime;
  final String? phoneNumber;

  AddOfficeEvent({
    required this.officeId,
    required this.name,
    required this.address,
    this.website,
    this.latitude,
    this.longitude,
    this.workingTime,
    this.phoneNumber,
  });
}

class UpdateOfficeEvent extends OfficeEvent {
  UpdateOfficeEvent({
    required this.action,
    required this.officeData,
  }) : assert(
          officeData is String || officeData is File,
          '[userData] must be either a String or a File, but '
          'was ${officeData.runtimeType}',
        );

  final UpdateOfficeAction action;
  final dynamic officeData;

  List<Object?> get props => [action, officeData];
}

class UpdateLocationEvent extends OfficeEvent {
  final String officeId;
  final double latitude;
  final double longitude;

  UpdateLocationEvent({
    required this.officeId,
    required this.latitude,
    required this.longitude,
  });
}
