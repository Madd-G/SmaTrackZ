import 'package:smatrackz/core.dart';

class AddEmployee extends FutureUseCaseWithParams<void, AddEmployeeParams> {
  const AddEmployee(this._repo);

  final EmployeeRepo _repo;

  @override
  ResultFuture<void> call(AddEmployeeParams params) => _repo.addEmployee(
        email: params.email,
        password: params.password,
        companyId: params.companyId,
        employee: params.employee,
      );
}

class AddEmployeeParams extends Equatable {
  const AddEmployeeParams({
    required this.email,
    required this.password,
    required this.companyId,
    required this.employee,
  });

  AddEmployeeParams.empty()
      : this(
            email: '',
            password: '',
            companyId: '',
            employee: EmployeeModel.empty());

  final String email;
  final String password;
  final String companyId;
  final EmployeeModel employee;

  @override
  List<String> get props => [email, password, companyId];
}
