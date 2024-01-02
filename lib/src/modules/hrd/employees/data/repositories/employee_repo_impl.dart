import 'package:smatrackz/core.dart';

class EmployeeRepoImpl implements EmployeeRepo {
  const EmployeeRepoImpl(this._remoteDataSource);

  final EmployeeRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<EmployeeEntity>> addEmployee({
    required String email,
    required String companyId,
    required EmployeeModel employee,
    required String password,
  }) async {
    try {
      await _remoteDataSource.addEmployee(
        email: email,
        companyId: companyId,
        employee: employee,
        password: password,
      );
      final employees = await _remoteDataSource.getEmployees();
      return Right(employees);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<EmployeeEntity>> getFilteredEmployees({
    required String role,
  }) async {
    try {
      await _remoteDataSource.getFilteredEmployees(
        role: role,
      );
      final employees = await _remoteDataSource.getEmployees();
      return Right(employees);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<EmployeeEntity>> getEmployees() async {
    try {
      final employees = await _remoteDataSource.getEmployees();
      return Right(employees);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateEmployee({
    required UpdateEmployeeAction action,
    required String uid,
    required dynamic employeeData,
  }) async {
    try {
      await _remoteDataSource.updateEmployee(
          action: action, uid: uid, employeeData: employeeData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
