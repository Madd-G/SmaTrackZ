import 'package:smatrackz/core.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc({
    required AddCompany addCompany,
    required GetCompany getCompany,
    required UpdateCompany updateCompany,
  })  : _addCompany = addCompany,
        _getCompany = getCompany,
        _updateCompany = updateCompany,
        super(CompanyInitialState()) {
    on<AddCompanyEvent>(_addCompanyHandler);
    on<LoadCompanyEvent>(_getCompanyEvent);
    on<UpdateCompanyEvent>(_updateCompanyHandler);
    on<UpdateLocationEvent>(_onUpdateLocationEvent);
    // on<LoadCompanyEvent>(_onLoadCompanyEvent);
    // on<AddCompanyEvent>(_onAddCompanyEvent);
  }

  final AddCompany _addCompany;
  final GetCompany _getCompany;
  final UpdateCompany _updateCompany;

  Future<void> _addCompanyHandler(
    AddCompanyEvent event,
    Emitter<CompanyState> emit,
  ) async {
    final result = await _addCompany(
      AddCompanyParams(
        companyId: event.companyId ?? '',
        companyName: event.name ?? '',
        address: event.address ?? '',
        latitude: event.latitude ?? 0.0,
        longitude: event.longitude ?? 0.0,
        website: event.website ?? "-",
        workStart: event.workStart ?? "-",
        workEnd: event.workEnd ?? "-",
        phoneNumber: event.phoneNumber ?? "-",
      ),
    );
    result.fold(
      (failure) => emit(CompanyErrorState(errorMessage: failure.errorMessage)),
      (_) => emit(const AddCompanyState()),
    );
  }

  Future<void> _getCompanyEvent(
    LoadCompanyEvent event,
    Emitter<CompanyState> emit,
  ) async {
    emit(CompanyInitialState());
    final result = await _getCompany(GetCompanyParams(companyId: event.companyId));
    result.fold(
      (failure) => emit(CompanyErrorState(errorMessage: failure.errorMessage)),
      (company) => emit(CompanyLoadedState(company)),
    );
  }

  void _onUpdateLocationEvent(
    UpdateLocationEvent event,
    Emitter<CompanyState> emit,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection("company")
          .doc(event.companyId)
          .update({
        "latitude": event.latitude,
        "longitude": event.longitude,
      });

      emit(LocationUpdatedState(
        latitude: event.latitude,
        longitude: event.longitude,
      ));
    } catch (e) {
      emit(const CompanyErrorState(errorMessage: 'Error updating location'));
    }
  }

  Future<void> _updateCompanyHandler(
    UpdateCompanyEvent event,
    Emitter<CompanyState> emit,
  ) async {
    final result = await _updateCompany(
      UpdateCompanyParams(
        action: event.action,
        companyData: event.companyData,
      ),
    );
    result.fold(
      (failure) => emit(CompanyErrorState(errorMessage: failure.errorMessage)),
      (_) => emit(const CompanyUpdatedState()),
    );
  }
}
