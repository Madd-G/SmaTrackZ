// import 'package:smatrackz/core.dart';
//
// class EmployeeRepoImpl implements EmployeeRepo {
//   const EmployeeRepoImpl(this._remoteDataSource);
//
//   final EmployeeRemoteDataSource _remoteDataSource;
//
//
//   @override
//   ResultFuture<void> addEmployee({
//     required String email,
//     required String fullName,
//     required String password,
//   }) async {
//     try {
//       await _remoteDataSource.addEmployee(
//         email: email,
//         fullName: fullName,
//         password: password,
//       );
//       return const Right(null);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
//     }
//   }
// }
