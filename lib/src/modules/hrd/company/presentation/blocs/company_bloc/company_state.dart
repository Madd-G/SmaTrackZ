part of 'company_bloc.dart';

@immutable
abstract class CompanyState extends Equatable {
  const CompanyState();
}

class CompanyInitialState extends CompanyState {
  @override
  List<Object?> get props => [];
}

class CompanyLoadedState extends CompanyState {
  final CompanyModel companyData;

  const CompanyLoadedState(this.companyData);

  @override
  List<Object?> get props => [];
}

class AddCompanyState extends CompanyState {
  const AddCompanyState();

  @override
  List<Object?> get props => [];
}

class CompanyErrorState extends CompanyState {
  final String errorMessage;

  const CompanyErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class LocationUpdatedState extends CompanyState {
  final double latitude;
  final double longitude;

  const LocationUpdatedState({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}

class CompanyUpdatedState extends CompanyState {
  const CompanyUpdatedState();

  @override
  List<Object?> get props => [];
}
