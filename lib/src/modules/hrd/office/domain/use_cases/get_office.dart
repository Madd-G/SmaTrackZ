import 'package:smatrackz/core.dart';

class GetOffice extends FutureUseCaseWithParams<OfficeModel, GetOfficeParams> {
  const GetOffice(this._repo);

  final OfficeRepository _repo;

  @override
  ResultFuture<OfficeModel> call(GetOfficeParams params) =>
      _repo.getOffice(officeData: params.officeData);
}

class GetOfficeParams extends Equatable {
  const GetOfficeParams({required this.officeData});

  const GetOfficeParams.empty() : this(officeData: '');

  final dynamic officeData;

  @override
  List<Object?> get props => [officeData];
}
