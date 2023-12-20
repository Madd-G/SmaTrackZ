import 'package:smatrackz/core.dart';

class GetUserById extends FutureUseCaseWithParams<UserEntity, String> {
  const GetUserById(this._repo);

  final ChatRepo _repo;

  @override
  ResultFuture<UserEntity> call(String params) => _repo.getUserById(params);
}
