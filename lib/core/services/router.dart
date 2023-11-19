import 'package:smatrackz/core.dart';
import 'package:smatrackz/src/modules/hrd/employees/presentation/views/add_employee_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return _pageBuilder(
        (context) {
          if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              fullName: user.displayName ?? '',
            );
            context.userProvider.initUser(localUser);
            return const BottomNavigation();
          }
          return BlocProvider(
              create: (_) => sl<AuthBloc>(), child: const SignInScreen());
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
    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
            create: (_) => sl<AuthBloc>(), child: const SignUpScreen()),
        settings: settings,
      );
    case OfficeScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
            create: (_) => CompanyBloc()..add(LoadCompanyEvent()),
            child: const OfficeScreen()),
        settings: settings,
      );
    case EmployeeListScreen.routeName:
      return _pageBuilder(
        (_) => const EmployeeListScreen(),
        settings: settings,
      );

    case BottomNavigation.routeName:
      return _pageBuilder(
        (_) => const BottomNavigation(),
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
