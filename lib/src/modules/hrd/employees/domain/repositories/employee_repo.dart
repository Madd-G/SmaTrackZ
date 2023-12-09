import 'package:smatrackz/core.dart';

abstract class EmployeeRepo {
  const EmployeeRepo();

  ResultFuture<void> addEmployee({
    required String email,
    required String companyId,
    required EmployeeModel employee,
    required String password,
  });
}
