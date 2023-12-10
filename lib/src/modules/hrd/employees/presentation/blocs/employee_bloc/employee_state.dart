part of 'employee_bloc.dart';

@immutable
abstract class EmployeeState extends Equatable {
  const EmployeeState();
}

class EmployeeInitialState extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeLoadingState extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeLoadedState extends EmployeeState {
  const EmployeeLoadedState(this.employees);

  final List<EmployeeEntity> employees;

  @override
  List<Object> get props => [employees];
}

class AddEmployeeState extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeErrorState extends EmployeeState {
  const EmployeeErrorState(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

class EmployeeUpdatedState extends EmployeeState {
  const EmployeeUpdatedState();

  @override
  List<Object?> get props => [];
}
