import 'package:smatrackz/core.dart';

class ForgotPassword extends FutureUseCaseWithParams<void, String> {
  const ForgotPassword(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);
}
