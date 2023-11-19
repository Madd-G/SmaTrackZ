part of 'company_bloc.dart';

@immutable
abstract class CompanyState {}

class CompanyInitialState extends CompanyState {}

class CompanyLoadedState extends CompanyState {
  final Map<String, dynamic> companyData;

  CompanyLoadedState({required this.companyData});
}

class CompanyErrorState extends CompanyState {
  final String errorMessage;

  CompanyErrorState({required this.errorMessage});
}

// Tambahkan state baru untuk pembaruan lokasi
class LocationUpdatedState extends CompanyState {
  final double latitude;
  final double longitude;

  LocationUpdatedState({
    required this.latitude,
    required this.longitude,
  });
}