part of 'office_bloc.dart';

@immutable
abstract class OfficeState extends Equatable {
  const OfficeState();
}

class OfficeInitialState extends OfficeState {
  @override
  List<Object?> get props => [];
}

class OfficeLoadedState extends OfficeState {
  final Map<String, dynamic> officeData;

  const OfficeLoadedState({required this.officeData});

  @override
  List<Object?> get props => [officeData];
}

class AddOfficeState extends OfficeState {
  const AddOfficeState();

  @override
  List<Object?> get props => [];
}

class OfficeErrorState extends OfficeState {
  final String errorMessage;

  const OfficeErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class LocationUpdatedState extends OfficeState {
  final double latitude;
  final double longitude;

  const LocationUpdatedState({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
