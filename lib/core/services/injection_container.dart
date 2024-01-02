import 'package:smatrackz/core.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initFirebaseInstances();
  await _initAuth();
  // await _initCompany();
  await _initEmployee();
  await _initGroup();
  await _initChat();
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

Future<void> _initGroup() async {
  sl
    ..registerFactory(
      () => GroupCubit(
        getGroups: sl(),
        getUserById: sl(),
        joinGroup: sl(),
        leaveGroup: sl(),
        addGroup: sl(),
      ),
    )
    ..registerLazySingleton(() => GetGroups(sl()))
    ..registerLazySingleton(() => GetUserById(sl()))
    ..registerLazySingleton(() => JoinGroup(sl()))
    ..registerLazySingleton(() => LeaveGroup(sl()))
    ..registerLazySingleton(() => AddGroup(sl()))
    ..registerLazySingleton<GroupRepo>(() => GroupRepoImpl(sl()))
    ..registerLazySingleton<GroupRemoteDataSource>(
      () =>
          GroupRemoteDataSourceImpl(firestore: sl(), auth: sl(), storage: sl()),
    );
}

Future<void> _initChat() async {
  sl
    ..registerFactory(
      () => ChatCubit(
        getMessages: sl(),
        getUserById: sl(),
        sendMessage: sl(),
      ),
    )
    ..registerLazySingleton(() => GetMessages(sl()))
    ..registerLazySingleton(() => SendMessage(sl()))
    ..registerLazySingleton<ChatRepo>(() => ChatRepoImpl(sl()))
    ..registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(firestore: sl(), auth: sl()),
    );
}

// Future<void> _initCompany() async {
//   sl
//     ..registerFactory(
//       () => CompanyBloc(
//         addCompany: sl(),
//         getCompany: sl(),
//         updateCompany: sl(),
//       ),
//     )
//     ..registerLazySingleton(() => AddCompany(sl()))
//     ..registerLazySingleton(() => GetCompany(sl()))
//     ..registerLazySingleton(() => UpdateCompany(sl()))
//     ..registerLazySingleton<CompanyRepository>(
//         () => CompanyRepositoryImpl(sl()))
//     ..registerLazySingleton<CompanyRemoteDataSource>(
//       () => CompanyRemoteDataSourceImpl(
//         cloudStoreClient: sl(),
//         auth: sl(),
//       ),
//     );
// }

Future<void> _initEmployee() async {
  sl
    ..registerFactory(
      () => EmployeeBloc(
        addEmployee: sl(),
        getEmployee: sl(),
        getFilteredEmployee: sl(),
        updateEmployee: sl(),
      ),
    )
    ..registerLazySingleton(() => AddEmployee(sl()))
    ..registerLazySingleton(() => GetEmployee(sl()))
    ..registerLazySingleton(() => GetFilteredEmployee(sl()))
    ..registerLazySingleton(() => UpdateEmployee(sl()))
    ..registerLazySingleton<EmployeeRepo>(() => EmployeeRepoImpl(sl()))
    ..registerLazySingleton<EmployeeRemoteDataSource>(
      () => EmployeeRemoteDataSourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    );
}
