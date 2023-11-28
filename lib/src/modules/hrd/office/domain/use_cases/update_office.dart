import 'package:smatrackz/core.dart';

class UpdateOffice extends FutureUseCaseWithParams<void, UpdateOfficeParams> {
  const UpdateOffice(this._repo);

  final OfficeRepository _repo;

  @override
  ResultFuture<void> call(UpdateOfficeParams params) => _repo.updateOffice(
        action: params.action,
        officeData: params.officeData,
      );
}

class UpdateOfficeParams extends Equatable {
  const UpdateOfficeParams({required this.action, required this.officeData});

  const UpdateOfficeParams.empty()
      : this(action: UpdateOfficeAction.name, officeData: '');

  final UpdateOfficeAction action;
  final dynamic officeData;

  @override
  List<dynamic> get props => [action, officeData];
}
