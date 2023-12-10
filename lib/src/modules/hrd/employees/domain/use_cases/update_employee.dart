import 'package:smatrackz/core.dart';

class UpdateEmployee
    extends FutureUseCaseWithParams<void, UpdateEmployeeParams> {
  const UpdateEmployee(this._repo);

  final EmployeeRepo _repo;

  @override
  ResultFuture<void> call(UpdateEmployeeParams params) => _repo.updateEmployee(
        action: params.action,
        uid: params.uid,
        employeeData: params.employeeData,
      );
}

class UpdateEmployeeParams extends Equatable {
  const UpdateEmployeeParams(
      {required this.action, required this.uid, required this.employeeData});

  const UpdateEmployeeParams.empty()
      : this(action: UpdateEmployeeAction.username, uid: '', employeeData: '');

  final UpdateEmployeeAction action;
  final String uid;
  final dynamic employeeData;

  @override
  List<dynamic> get props => [action, uid, employeeData];
}
