import 'package:smatrackz/core.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return _pageBuilder(
        (context) {
          if (sl<FirebaseAuth>().currentUser != null) {
            const localUser = UserModel(
              uid: '',
              email: '',
              fullName: '',
              bio: '',
            );
            context.userProvider.initUser(localUser);
            return BlocProvider(
                create: (_) => sl<OfficeBloc>(),
                child: const BottomNavigation());
          }

          return MultiBlocProvider(providers: [
            BlocProvider(create: (_) => sl<AuthBloc>()),
            BlocProvider(create: (_) => sl<OfficeBloc>()),
          ], child: const SignInScreen());
        },
        settings: settings,
      );

    case AddEmployeeScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
              create: (_) => sl<AuthBloc>(), child: const AddEmployeeScreen());
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
            BlocProvider(create: (_) => sl<OfficeBloc>()),
          ],
          child: const RegisterScreen(),
        ),
        settings: settings,
      );

    case OfficeScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
            create: (context) => sl<OfficeBloc>()
              ..add(LoadOfficeEvent(
                  officeId: context.userProvider.user!.companyId!)),
            child: const OfficeScreen(),
          );
        },
        settings: settings,
      );

    case MapScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
            create: (context) => sl<OfficeBloc>(),
            child: MapScreen(settings.arguments! as OfficeModel),
          );
        },
        settings: settings,
      );

    case EditOfficeScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
            create: (context) => sl<OfficeBloc>(),
            child: EditOfficeScreen(settings.arguments! as OfficeModel),
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
            create: (context) => sl<OfficeBloc>(),
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
