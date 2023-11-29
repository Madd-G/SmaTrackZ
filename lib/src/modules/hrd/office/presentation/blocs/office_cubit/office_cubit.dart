// import 'package:smatrackz/core.dart';
//
// part 'office_state.dart';
//
// class OfficeCubit extends Cubit<OfficeState> {
//   OfficeCubit({
//     required AddOffice addOffice,
//     required GetOffice getOffice,
//     required UpdateOffice updateOffice,
//   })  : _addOffice = addOffice,
//         _getOffice = getOffice,
//         _updateOffice = updateOffice,
//         super(const OfficeInitial());
//
//   final AddOffice _addOffice;
//   final GetOffice _getOffice;
//   final UpdateOffice _updateOffice;
//
//   Future<void> addOffice(OfficeModel officeModel) async {
//     emit(const AddingOffice());
//     final result = await _addOffice(officeModel);
//     result.fold(
//       (failure) => emit(OfficeError(failure.errorMessage)),
//       (_) => emit(const OfficeAdded()),
//     );
//   }
//
//   Future<void> getOffice() async {
//     emit(const LoadingOffices());
//     final result = await _getOffice();
//     result.fold(
//       (failure) => emit(OfficeError(failure.errorMessage)),
//       (office) => emit(OfficesLoaded(office)),
//     );
//   }
// }
