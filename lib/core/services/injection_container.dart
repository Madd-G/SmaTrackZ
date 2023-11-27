import 'package:smatrackz/core.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initFirebaseInstances();
  await _initAuth();
  await _initOffice();
  // await _initAddEmployee();
  // await _initOffice();
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

Future<void> _initOffice() async {
  sl
    ..registerFactory(
      () => OfficeBloc(
        addOffice: sl(),
      ),
    )
    ..registerLazySingleton(() => AddOffice(sl()))
    ..registerLazySingleton<OfficeRepository>(() => OfficeRepositoryImpl(sl()))
    ..registerLazySingleton<OfficeRemoteDataSource>(
      () => OfficeRemoteDataSourceImpl(
        cloudStoreClient: sl(),
      ),
    );
}

// Future<void> _initOffice() async {
//   sl
//     ..registerLazySingleton<OfficeRemoteDataSource>(
//         () => OfficeRemoteDataSource())
//     ..registerLazySingleton<OfficeRepository>(
//         () => OfficeRepositoryImpl(sl<OfficeRemoteDataSource>()));
// }

// Future<void> _initAddEmployee() async {
//   sl
//     ..registerFactory(
//       () => AddEmployeeBloc(
//         addEmployee: sl(),
//       ),
//     )
//     ..registerLazySingleton(() => AddEmployee(sl()))
//     ..registerLazySingleton<EmployeeRepo>(() => EmployeeRepoImpl(sl()))
//     ..registerLazySingleton<EmployeeRemoteDataSource>(
//       () => EmployeeRemoteDataSourceImpl(
//         authClient: sl(),
//         cloudStoreClient: sl(),
//         dbClient: sl(),
//       ),
//     );
// }
