import 'package:smatrackz/core.dart';

part 'add_employee_event.dart';

part 'add_employee_state.dart';

class AddEmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  AddEmployeeBloc({
    required AddEmployee addEmployee,
  })  : _addEmployee = addEmployee,
        super(const AddEmployeeInitialState()) {
    on<EmployeeEvent>((event, emit) {
      emit(const AddEmployeeLoadingState());
    });
    // on<AddEmployeeEvent>((event, emit) => _addEmployeeHandler(event, emit)); // Corrected this line
    // on<AddEmployeeEvent>((event, emit) => _addEmployeeHandler);
    on<AddEmployeeEvent>(_addEmployeeHandler);
  }

  final AddEmployee _addEmployee;

  Future<void> _addEmployeeHandler(
    AddEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    final result = await _addEmployee(
      AddEmployeeParams(
        email: event.email,
        companyId: event.companyId,
        companyName: event.name,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(AddEmployeeErrorState(failure.errorMessage)),
      (_) => emit(const AddEmployeeState()),
    );
  }
}
