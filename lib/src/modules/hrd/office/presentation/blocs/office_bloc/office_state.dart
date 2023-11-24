part of 'office_bloc.dart';

@immutable
abstract class OfficeState {}

class OfficeInitialState extends OfficeState {}

class OfficeLoadedState extends OfficeState {
  final Map<String, dynamic> officeData;

  OfficeLoadedState({required this.officeData});
}

class OfficeErrorState extends OfficeState {
  final String errorMessage;

  OfficeErrorState({required this.errorMessage});
}

class LocationUpdatedState extends OfficeState {
  final double latitude;
  final double longitude;

  LocationUpdatedState({
    required this.latitude,
    required this.longitude,
  });
}