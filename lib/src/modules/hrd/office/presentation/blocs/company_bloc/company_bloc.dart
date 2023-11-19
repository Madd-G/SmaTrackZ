import 'package:smatrackz/core.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(CompanyInitialState()) {
    on<LoadCompanyEvent>(_onLoadCompanyEvent);
    on<UpdateCompanyEvent>(_onUpdateCompanyEvent);
    // Tambahkan handler untuk event UpdateLocationEvent
    on<UpdateLocationEvent>(_onUpdateLocationEvent);
  }

  void _onLoadCompanyEvent(
      LoadCompanyEvent event,
      Emitter<CompanyState> emit,
      ) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("company_profile")
          .snapshots()
          .first;

      if (snapshot.docs.isNotEmpty) {
        final currentData = snapshot.docs.first.data() as Map<String, dynamic>;
        emit(CompanyLoadedState(companyData: currentData));
      } else {
        emit(CompanyLoadedState(companyData: {}));
      }
    } catch (e) {
      emit(CompanyErrorState(errorMessage: 'Error loading company data'));
    }
  }

  void _onUpdateCompanyEvent(
      UpdateCompanyEvent event,
      Emitter<CompanyState> emit,
      ) async {
    try {
      await FirebaseFirestore.instance
          .collection("company_profile")
          .doc("main-company")
          .set({
        "company_name": event.companyName,
        "address": event.address,
        "latitude": event.latitude,
        "longitude": event.longitude,
      });

      emit(CompanyLoadedState(companyData: {
        "company_name": event.companyName,
        "address": event.address,
        "latitude": event.latitude,
        "longitude": event.longitude,
      }));
    } catch (e) {
      emit(CompanyErrorState(errorMessage: 'Error updating company data'));
    }
  }

  // Handler untuk event UpdateLocationEvent
  void _onUpdateLocationEvent(
      UpdateLocationEvent event,
      Emitter<CompanyState> emit,
      ) async {
    try {
      // Update lokasi pada Firestore di sini.
      await FirebaseFirestore.instance
          .collection("company_profile")
          .doc("main-company")
          .update({
        "latitude": event.latitude,
        "longitude": event.longitude,
      });

      // Kirim state yang diperbarui ke widget yang membutuhkannya.
      emit(LocationUpdatedState(
        latitude: event.latitude,
        longitude: event.longitude,
      ));
    } catch (e) {
      emit(CompanyErrorState(errorMessage: 'Error updating location'));
    }
  }
}
