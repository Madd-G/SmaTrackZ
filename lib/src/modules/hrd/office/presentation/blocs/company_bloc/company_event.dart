part of 'company_bloc.dart';

@immutable
abstract class CompanyEvent {}

class LoadCompanyEvent extends CompanyEvent {}

class UpdateCompanyEvent extends CompanyEvent {
  final String companyName;
  final String address;
  final double latitude;
  final double longitude;

  UpdateCompanyEvent({
    required this.companyName,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

// Tambahkan event baru untuk pembaruan lokasi
class UpdateLocationEvent extends CompanyEvent {
  final double latitude;
  final double longitude;

  UpdateLocationEvent({
    required this.latitude,
    required this.longitude,
  });
}


