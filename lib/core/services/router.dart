import 'package:smatrackz/core.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return _pageBuilder(
        (context) {
          if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser!;
            final localUser = UserModel(
              companyId: user.uid,
              email: user.email ?? '',
              companyName: user.displayName ?? '',
              address: '',
            );
            context.userProvider.initUser(localUser);
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<CompanyBloc>()),
                BlocProvider(create: (_) => sl<EmployeeBloc>()),
              ],
              child: const MainNavigation(),
            );
          }

          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<AuthBloc>()),
              BlocProvider(create: (_) => sl<CompanyBloc>()),
              BlocProvider(create: (_) => sl<EmployeeBloc>()),
            ],
            child: const SignInScreen(),
          );
        },
        settings: settings,
      );

    case MainNavigation.routeName:
      return _pageBuilder(
        (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (_) => sl<CompanyBloc>()
                    ..add(LoadCompanyEvent(
                        companyId: context.userProvider.user!.companyId))),
              BlocProvider(
                  create: (_) => sl<EmployeeBloc>()..add(GetEmployeeEvent())),
            ],
            child: const MainNavigation(),
          );
        },
        settings: settings,
      );

    case GroupsScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
            create: (_) => sl<GroupCubit>(),
            child: const GroupsScreen(),
          );
        },
        settings: settings,
      );

    case CompanyScreen.routeName:
      return _pageBuilder(
        (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<CompanyBloc>()
                // ..add(LoadCompanyEvent(
                //     companyId: context.userProvider.user!.companyId)),
            ),
            BlocProvider(
                create: (_) => sl<EmployeeBloc>()..add(GetEmployeeEvent())),
          ],
          child: const CompanyScreen(),
        ),
        settings: settings,
      );

    case EmployeeListScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
              create: (_) => sl<EmployeeBloc>(),
              child: const EmployeeListScreen());
        },
        settings: settings,
      );

    case DetailEmployeeScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
              create: (_) => sl<EmployeeBloc>(),
              child:
                  DetailEmployeeScreen(settings.arguments! as EmployeeModel));
        },
        settings: settings,
      );

    case AddEmployeeScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
              create: (_) => sl<EmployeeBloc>(),
              child: const AddEmployeeScreen());
        },
        settings: settings,
      );

    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
            create: (_) => sl<AuthBloc>(), child: const SignInScreen()),
        settings: settings,
      );
    case RegisterScreen.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<AuthBloc>()),
            BlocProvider(create: (_) => sl<CompanyBloc>()),
            BlocProvider(create: (_) => sl<EmployeeBloc>()),
          ],
          child: const RegisterScreen(),
        ),
        settings: settings,
      );

    case MapScreen.routeName:
      return _pageBuilder(
        (context) => BlocProvider(
          create: (context) => sl<CompanyBloc>(),
          child: MapScreen(settings.arguments! as CompanyModel),
        ),
        settings: settings,
      );

    case EditCompanyScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
            create: (context) => sl<CompanyBloc>(),
            child: EditCompanyScreen(settings.arguments! as CompanyModel),
          );
        },
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const ErrorScreen(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, _, __) => page(context),
  );
}
