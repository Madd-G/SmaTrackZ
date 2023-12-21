import 'package:smatrackz/core.dart';

class GetGroups extends StreamUseCaseWithoutParams<List<GroupEntity>> {
  const GetGroups(this._repo);

  final GroupRepo _repo;

  @override
  ResultStream<List<GroupEntity>> call() => _repo.getGroups();
}
