import 'package:smatrackz/core.dart';

class GetOffice extends FutureUseCaseWithoutParams<OfficeModel> {
  const GetOffice(this._repo);

  final OfficeRepository _repo;

  @override
  ResultFuture<OfficeModel> call() async => _repo.getOffice();
}

class GetOfficeParams extends Equatable {
  const GetOfficeParams();

  const GetOfficeParams.empty() : this();

  // final dynamic officeData;

  @override
  List<Object?> get props => [];
}
