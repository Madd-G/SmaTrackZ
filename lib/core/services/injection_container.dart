import 'package:smatrackz/core.dart';
import 'package:smatrackz/src/modules/hrd/employees/domain/use_cases/get_employee.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initFirebaseInstances();
  await _initAuth();
  await _initCompany();
  await _initEmployee();
  // await _initCompany();
}

Future<void> _initFirebaseInstances() async {
  sl
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    );
}

Future<void> _initCompany() async {
  sl
    ..registerFactory(
      () => CompanyBloc(
        addCompany: sl(),
        getCompany: sl(),
        updateCompany: sl(),
      ),
    )
    ..registerLazySingleton(() => AddCompany(sl()))
    ..registerLazySingleton(() => GetCompany(sl()))
    ..registerLazySingleton(() => UpdateCompany(sl()))
    ..registerLazySingleton<CompanyRepository>(
        () => CompanyRepositoryImpl(sl()))
    ..registerLazySingleton<CompanyRemoteDataSource>(
      () => CompanyRemoteDataSourceImpl(
        cloudStoreClient: sl(),
        auth: sl(),
      ),
    );
}

// Future<void> _initCompany() async {
//   sl
//     ..registerLazySingleton<CompanyRemoteDataSource>(
//         () => CompanyRemoteDataSource())
//     ..registerLazySingleton<CompanyRepository>(
//         () => CompanyRepositoryImpl(sl<CompanyRemoteDataSource>()));
// }

Future<void> _initEmployee() async {
  sl
    ..registerFactory(
      () => EmployeeBloc(
        addEmployee: sl(),
        getEmployee: sl(),
      ),
    )
    ..registerLazySingleton(() => AddEmployee(sl()))
    ..registerLazySingleton(() => GetEmployee(sl()))
    ..registerLazySingleton<EmployeeRepo>(() => EmployeeRepoImpl(sl()))
    ..registerLazySingleton<EmployeeRemoteDataSource>(
      () => EmployeeRemoteDataSourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    );
}
