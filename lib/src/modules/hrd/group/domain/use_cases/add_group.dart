import 'package:smatrackz/core.dart';

class AddGroup extends FutureUseCaseWithParams<void, GroupEntity> {
  const AddGroup(this._repo);

  final GroupRepo _repo;

  @override
  ResultFuture<void> call(GroupEntity params) async => _repo.addGroup(params);
}