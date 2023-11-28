import 'package:smatrackz/core.dart';

part 'office_event.dart';

part 'office_state.dart';

class OfficeBloc extends Bloc<OfficeEvent, OfficeState> {
  OfficeBloc({
    required AddOffice addOffice,
    required GetOffice getOffice,
    required UpdateOffice updateOffice,
  })  : _addOffice = addOffice,
        _getOffice = getOffice,
        _updateOffice = updateOffice,
        super(OfficeInitialState()) {
    on<AddOfficeEvent>(_addOfficeHandler);
    on<LoadOfficeEvent>(_onLoadOfficeEvent);
    on<UpdateOfficeEvent>(_updateOfficeHandler);
    on<UpdateLocationEvent>(_onUpdateLocationEvent);
    // on<LoadOfficeEvent>(_onLoadOfficeEvent);
    // on<AddOfficeEvent>(_onAddOfficeEvent);
  }

  final AddOffice _addOffice;
  final GetOffice _getOffice;
  final UpdateOffice _updateOffice;

  Future<void> _addOfficeHandler(
    AddOfficeEvent event,
    Emitter<OfficeState> emit,
  ) async {
    final result = await _addOffice(
      AddOfficeParams(
        officeId: event.officeId,
        officeName: event.name,
        address: event.address,
        latitude: event.latitude,
        longitude: event.longitude,
        website: event.website,
      ),
    );
    result.fold(
      (failure) => emit(OfficeErrorState(errorMessage: failure.errorMessage)),
      (_) => emit(const AddOfficeState()),
    );
  }

  Future<void> _onLoadOfficeEvent(
    LoadOfficeEvent event,
    Emitter<OfficeState> emit,
  ) async {
    final result =
        await _getOffice(GetOfficeParams(officeData: event.officeData));
    result.fold(
      (failure) => emit(OfficeErrorState(errorMessage: failure.errorMessage)),
      (office) => emit(OfficeLoadedState(office)),
    );
  }

  // void _onUpdateOfficeEvent(
  //   UpdateOfficeEvent event,
  //   Emitter<OfficeState> emit,
  // ) async {
  //   try {
  //     var officeData = await FirebaseFirestore.instance
  //         .collection("office")
  //         .doc('abc')
  //         .update({
  //       "office_id": event.officeId,
  //       "office_name": event.name,
  //       "address": event.address,
  //       "website": event.website,
  //       "latitude": event.latitude,
  //       "longitude": event.longitude,
  //     });
  //
  //     emit(OfficeLoadedState(officeData));
  //   } catch (e) {
  //     emit(const OfficeErrorState(errorMessage: 'Error updating office data'));
  //   }
  // }

  void _onUpdateLocationEvent(
    UpdateLocationEvent event,
    Emitter<OfficeState> emit,
  ) async {
    try {
      await FirebaseFirestore.instance.collection("office").doc('abc').update({
        "latitude": event.latitude,
        "longitude": event.longitude,
      });

      emit(LocationUpdatedState(
        latitude: event.latitude,
        longitude: event.longitude,
      ));
    } catch (e) {
      emit(const OfficeErrorState(errorMessage: 'Error updating location'));
    }
  }

  Future<void> _updateOfficeHandler(
    UpdateOfficeEvent event,
    Emitter<OfficeState> emit,
  ) async {
    final result = await _updateOffice(
      UpdateOfficeParams(
        action: event.action,
        officeData: event.officeData,
      ),
    );
    result.fold(
      (failure) => emit(OfficeErrorState(errorMessage: failure.errorMessage)),
      (_) => emit(OfficeUpdatedState()),
    );
  }
}
