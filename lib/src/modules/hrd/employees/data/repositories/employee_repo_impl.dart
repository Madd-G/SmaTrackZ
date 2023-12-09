import 'package:smatrackz/core.dart';

class EmployeeRepoImpl implements EmployeeRepo {
  const EmployeeRepoImpl(this._remoteDataSource);

  final EmployeeRemoteDataSource _remoteDataSource;


  @override
  ResultFuture<void> addEmployee({
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
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
