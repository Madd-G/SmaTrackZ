import 'package:smatrackz/core.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return _pageBuilder(
        (context) {
          if (sl<FirebaseAuth>().currentUser != null) {
            const localUser = UserModel(
              companyId: '',
              email: '',
              companyName: '',
              address: '',
            );
            context.userProvider.initUser(localUser);
            return BlocProvider(
                create: (_) => sl<CompanyBloc>(),
                child: const BottomNavigation());
          }

          return MultiBlocProvider(providers: [
            BlocProvider(create: (_) => sl<AuthBloc>()),
            BlocProvider(create: (_) => sl<CompanyBloc>()),
          ], child: const SignInScreen());
        },
        settings: settings,
      );

    case AddEmployeeScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
              create: (_) => sl<AddEmployeeBloc>(),
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
            BlocProvider(
              create: (_) => sl<AuthBloc>(),
            ),
            BlocProvider(create: (_) => sl<CompanyBloc>()),
          ],
          child: const RegisterScreen(),
        ),
        settings: settings,
      );

    case CompanyScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
            create: (context) => sl<CompanyBloc>()
              ..add(LoadCompanyEvent(
                  companyId: context.userProvider.user!.companyId)),
            child: const CompanyScreen(),
          );
        },
        settings: settings,
      );

    case MapScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
            create: (context) => sl<CompanyBloc>(),
            child: MapScreen(settings.arguments! as CompanyModel),
          );
        },
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

    case EmployeeListScreen.routeName:
      return _pageBuilder(
        (_) => const EmployeeListScreen(),
        settings: settings,
      );

    case BottomNavigation.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
            create: (context) => sl<CompanyBloc>(),
            child: const BottomNavigation(),
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
