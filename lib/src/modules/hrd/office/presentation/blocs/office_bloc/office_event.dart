part of 'office_bloc.dart';

@immutable
abstract class OfficeEvent {}

class LoadOfficeEvent extends OfficeEvent {
  final dynamic officeData;

  LoadOfficeEvent(this.officeData);
}

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

// class UpdateOfficeEvent extends OfficeEvent {
//   final String officeId;
//   final String name;
//   final String address;
//   final String website;
//   final double latitude;
//   final double longitude;
//
//   UpdateOfficeEvent({
//     required this.officeId,
//     required this.name,
//     required this.address,
//     required this.website,
//     required this.latitude,
//     required this.longitude,
//   });
// }

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

  @override
  List<Object?> get props => [action, officeData];
}

class UpdateLocationEvent extends OfficeEvent {
  final double latitude;
  final double longitude;

  UpdateLocationEvent({
    required this.latitude,
    required this.longitude,
  });
}
