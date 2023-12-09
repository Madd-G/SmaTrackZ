import 'package:smatrackz/core.dart';
import 'package:smatrackz/src/modules/hrd/employees/domain/use_cases/get_employee.dart';

part 'employee_event.dart';

part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({
    required AddEmployee addEmployee,
    required GetEmployee getEmployee,
  })  : _addEmployee = addEmployee,
        _getEmployee = getEmployee,
        super(const EmployeeInitialState()) {
    on<EmployeeEvent>((event, emit) {
      emit(const EmployeeLoadingState());
    });
    // on<AddEmployeeEvent>((event, emit) => _addEmployeeHandler(event, emit)); // Corrected this line
    // on<AddEmployeeEvent>((event, emit) => _addEmployeeHandler);
    on<GetEmployeeEvent>(_getEmployeesHandler);
    on<AddEmployeeEvent>(_addEmployeeHandler);
  }

  final AddEmployee _addEmployee;
  final GetEmployee _getEmployee;

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
      (_) => emit(const EmployeeUpdatedState()),
    );
  }

  Future<void> _getEmployeesHandler(
    GetEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(const EmployeeLoadingState());
    final result = await _getEmployee();
    result.fold(
      (failure) => emit(EmployeeErrorState(failure.errorMessage)),
      (courses) => emit(EmployeeLoadedState(courses)),
    );
  }
}
