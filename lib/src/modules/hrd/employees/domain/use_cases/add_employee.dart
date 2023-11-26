// import 'package:smatrackz/core.dart';
//
// class AddEmployee extends FutureUseCaseWithParams<void, AddEmployeeParams> {
//   const AddEmployee(this._repo);
//
//   final EmployeeRepo _repo;
//
//   @override
//   ResultFuture<void> call(AddEmployeeParams params) => _repo.addEmployee(
//         email: params.email,
//         password: params.password,
//         fullName: params.fullName,
//       );
// }
//
// class AddEmployeeParams extends Equatable {
//   const AddEmployeeParams({
//     required this.email,
//     required this.password,
//     required this.fullName,
//   });
//
//   const AddEmployeeParams.empty() : this(email: '', password: '', fullName: '');
//
//   final String email;
//   final String password;
//   final String fullName;
//
//   @override
//   List<String> get props => [email, password, fullName];
// }
