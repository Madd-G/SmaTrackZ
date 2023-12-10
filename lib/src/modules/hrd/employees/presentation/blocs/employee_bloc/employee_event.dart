part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent {}

class AddEmployeeEvent extends EmployeeEvent {
  AddEmployeeEvent({
    required this.email,
    required this.password,
    required this.employee,
    required this.companyId,
  });

  final String email;
  final String password;
  final EmployeeModel employee;
  final String companyId;

  List<String> get props => [
        email,
        password,
        companyId,
      ];
}

class GetEmployeeEvent extends EmployeeEvent {
  List<Object?> get props => [];
}

class UpdateEmployeeEvent extends EmployeeEvent {
  UpdateEmployeeEvent({
    required this.action,
    required this.uid,
    required this.employeeData,
  });

  final UpdateEmployeeAction action;
  final String uid;
  final dynamic employeeData;

  List<Object?> get props => [action, uid, employeeData];
}
