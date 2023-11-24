import 'package:smatrackz/core.dart';

part 'office_event.dart';
part 'office_state.dart';

class OfficeBloc extends Bloc<OfficeEvent, OfficeState> {
  OfficeBloc() : super(OfficeInitialState()) {
    on<LoadOfficeEvent>(_onLoadOfficeEvent);
    on<UpdateOfficeEvent>(_onUpdateOfficeEvent);
    on<UpdateLocationEvent>(_onUpdateLocationEvent);
  }

  void _onLoadOfficeEvent(
      LoadOfficeEvent event,
      Emitter<OfficeState> emit,
      ) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("office")
          .doc("main-company")
          .get();

      final officeData = snapshot.data() ?? {};
      emit(OfficeLoadedState(officeData: officeData));
    } catch (e) {
      emit(OfficeErrorState(errorMessage: 'Error loading office data'));
    }
  }

  void _onUpdateOfficeEvent(
      UpdateOfficeEvent event,
      Emitter<OfficeState> emit,
      ) async {
    try {
      await FirebaseFirestore.instance
          .collection("office")
          .doc("main-company")
          .set({
        "office_name": event.officeName,
        "address": event.address,
        "latitude": event.latitude,
        "longitude": event.longitude,
      });

      emit(OfficeLoadedState(officeData: {
        "office_name": event.officeName,
        "address": event.address,
        "latitude": event.latitude,
        "longitude": event.longitude,
      }));
    } catch (e) {
      emit(OfficeErrorState(errorMessage: 'Error updating office data'));
    }
  }

  void _onUpdateLocationEvent(
      UpdateLocationEvent event,
      Emitter<OfficeState> emit,
      ) async {
    try {
      await FirebaseFirestore.instance
          .collection("office")
          .doc("main-company")
          .update({
        "latitude": event.latitude,
        "longitude": event.longitude,
      });

      emit(LocationUpdatedState(
        latitude: event.latitude,
        longitude: event.longitude,
      ));
    } catch (e) {
      emit(OfficeErrorState(errorMessage: 'Error updating location'));
    }
  }
}
