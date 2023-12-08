import 'package:smatrackz/core.dart';

class UpdateCompany extends FutureUseCaseWithParams<void, UpdateCompanyParams> {
  const UpdateCompany(this._repo);

  final CompanyRepository _repo;

  @override
  ResultFuture<void> call(UpdateCompanyParams params) => _repo.updateCompany(
        action: params.action,
    companyData: params.companyData,
      );
}

class UpdateCompanyParams extends Equatable {
  const UpdateCompanyParams({required this.action, required this.companyData});

  const UpdateCompanyParams.empty()
      : this(action: UpdateCompanyAction.name, companyData: '');

  final UpdateCompanyAction action;
  final dynamic companyData;

  @override
  List<dynamic> get props => [action, companyData];
}
