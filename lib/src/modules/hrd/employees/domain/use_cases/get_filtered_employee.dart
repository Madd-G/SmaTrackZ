import 'package:smatrackz/core.dart';

class GetFilteredEmployee extends FutureUseCaseWithParams<List<EmployeeEntity>,
    GetFilteredEmployeesParams> {
  const GetFilteredEmployee(this._repo);

  final EmployeeRepo _repo;

  @override
  ResultFuture<List<EmployeeEntity>> call(GetFilteredEmployeesParams params) =>
      _repo.getFilteredEmployees(
        role: params.role,
        // password: params.password,
        // companyId: params.companyId,
        // employee: params.employee,
      );
}

class GetFilteredEmployeesParams extends Equatable {
  const GetFilteredEmployeesParams({
    required this.role,
  });

  const GetFilteredEmployeesParams.empty() : this(role: '');

  final String role;

  @override
  List<String> get props => [role];
}
