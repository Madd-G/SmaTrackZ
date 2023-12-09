part of 'add_employee_bloc.dart';

@immutable
abstract class EmployeeEvent extends Equatable{
  const EmployeeEvent();
}

class AddEmployeeEvent extends EmployeeEvent {
  const AddEmployeeEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.companyId,

  });

  final String email;
  final String password;
  final String name;
  final String companyId;


  @override
  List<String> get props => [email, password, name, companyId];
}
