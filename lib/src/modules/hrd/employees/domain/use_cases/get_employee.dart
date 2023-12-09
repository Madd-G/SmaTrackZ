import 'package:smatrackz/core.dart';

class GetEmployee extends FutureUseCaseWithoutParams<List<EmployeeEntity>> {
  const GetEmployee(this._repo);

  final EmployeeRepo _repo;

  @override
  ResultFuture<List<EmployeeEntity>> call() async => _repo.getEmployees();
}
