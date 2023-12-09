part of 'employee_bloc.dart';

@immutable
abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeInitialState extends EmployeeState {
  const EmployeeInitialState();
}

class EmployeeLoadingState extends EmployeeState {
  const EmployeeLoadingState();
}

class EmployeeLoadedState extends EmployeeState {
  const EmployeeLoadedState(this.employees);

  final List<EmployeeEntity> employees;

  @override
  List<Object> get props => [employees];
}

class AddEmployeeState extends EmployeeState {
  const AddEmployeeState();
}

class EmployeeErrorState extends EmployeeState {
  const EmployeeErrorState(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
