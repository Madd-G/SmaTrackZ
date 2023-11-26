import 'package:smatrackz/core.dart';

class SignUp extends FutureUseCaseWithParams<void, SignUpParams> {
  const SignUp(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(SignUpParams params) => _repo.signUp(
        email: params.email,
        password: params.password,
        fullName: params.fullName,
        companyId: params.companyId,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.companyId,
  });

  const SignUpParams.empty()
      : this(email: '', password: '', fullName: '', companyId: '');

  final String email;
  final String password;
  final String fullName;
  final String companyId;

  @override
  List<String> get props => [email, password, fullName, companyId];
}
