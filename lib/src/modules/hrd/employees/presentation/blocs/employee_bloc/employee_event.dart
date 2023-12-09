part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
}

class AddEmployeeEvent extends EmployeeEvent {
  const AddEmployeeEvent({
    required this.email,
    required this.password,
    required this.employee,
    required this.companyId,
  });

  final String email;
  final String password;
  final EmployeeModel employee;
  final String companyId;

  @override
  List<String> get props => [
        email,
        password,
        companyId,
      ];
}

class GetEmployeeEvent extends EmployeeEvent {
  @override
  List<Object?> get props => [];
}
