import 'package:smatrackz/core.dart';

class SignUp extends FutureUseCaseWithParams<void, SignUpParams> {
  const SignUp(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(SignUpParams params) => _repo.signUp(
        email: params.email,
        password: params.password,
        companyName: params.companyName,
        companyId: params.companyId,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.companyId,
    required this.companyName,
  });

  const SignUpParams.empty()
      : this(
          email: '',
          password: '',
          companyId: '',
          companyName: '',
        );

  final String email;
  final String password;
  final String companyId;
  final String companyName;

  @override
  List<String> get props => [
        email,
        password,
        companyId,
        companyName,
      ];
}
