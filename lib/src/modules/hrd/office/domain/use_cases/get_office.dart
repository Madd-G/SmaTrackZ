import 'package:smatrackz/core.dart';

class GetOffice extends FutureUseCaseWithParams<void, GetOfficeParams> {
  const GetOffice(this._officeRepo);

  final OfficeRepository _officeRepo;

  @override
  ResultFuture<OfficeModel> call(GetOfficeParams params) async => _officeRepo.getOffice(params.officeId);
}

class GetOfficeParams extends Equatable {
  final String officeId;

  const GetOfficeParams({
    required this.officeId,
  });

  const GetOfficeParams.empty()
      : this(
    officeId: '',
  );

  @override
  List<Object?> get props =>
      [officeId];
}
