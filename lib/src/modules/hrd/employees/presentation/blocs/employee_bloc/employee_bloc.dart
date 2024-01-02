import 'package:smatrackz/core.dart';

part 'employee_event.dart';

part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({
    required AddEmployee addEmployee,
    required GetFilteredEmployee getFilteredEmployee,
    required GetEmployee getEmployee,
    required UpdateEmployee updateEmployee,
  })  : _addEmployee = addEmployee,
        _getEmployee = getEmployee,
        _getFilteredEmployee = getFilteredEmployee,
        _updateEmployee = updateEmployee,
        super(EmployeeInitialState()) {
    on<EmployeeEvent>((event, emit) {
      emit(EmployeeLoadingState());
    });
    // on<AddEmployeeEvent>((event, emit) => _addEmployeeHandler(event, emit)); // Corrected this line
    // on<AddEmployeeEvent>((event, emit) => _addEmployeeHandler);
    on<GetEmployeeEvent>(_getEmployeesHandler);
    on<GetFilteredEmployeeEvent>(_getFilteredEmployeesHandler);
    on<AddEmployeeEvent>(_addEmployeeHandler);
    on<UpdateEmployeeEvent>(_updateEmployeeHandler);
  }

  final AddEmployee _addEmployee;
  final GetEmployee _getEmployee;
  final GetFilteredEmployee _getFilteredEmployee;
  final UpdateEmployee _updateEmployee;

  Future<void> _addEmployeeHandler(
    AddEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    final result = await _addEmployee(
      AddEmployeeParams(
        email: event.email,
        companyId: event.companyId,
        employee: event.employee,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(EmployeeErrorState(failure.errorMessage)),
      (employees) => emit(EmployeeLoadedState(employees)),
    );
  }

  Future<void> _getEmployeesHandler(
    GetEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoadingState());
    final result = await _getEmployee();
    result.fold(
      (failure) => emit(EmployeeErrorState(failure.errorMessage)),
      (employee) => emit(EmployeeLoadedState(employee)),
    );
  }

  Future<void> _getFilteredEmployeesHandler(
    GetFilteredEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoadingState());
    final result = await _getFilteredEmployee(
        GetFilteredEmployeesParams(role: event.role));
    result.fold(
      (failure) => emit(EmployeeErrorState(failure.errorMessage)),
      (employee) => emit(FilteredEmployeeLoadedState(employee)),
    );
  }

  Future<void> _updateEmployeeHandler(
    UpdateEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    final result = await _updateEmployee(
      UpdateEmployeeParams(
        action: event.action,
        uid: event.uid,
        employeeData: event.employeeData,
      ),
    );
    result.fold(
      (failure) => emit(EmployeeErrorState(failure.errorMessage)),
      (_) => emit(const EmployeeUpdatedState()),
    );
  }
}
