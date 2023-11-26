import 'package:smatrackz/core.dart';
import 'package:smatrackz/src/modules/hrd/employees/presentation/views/add_employee_screen.dart';
import 'package:smatrackz/src/modules/hrd/office/presentation/views/edit_office_screen.dart';

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

    case OfficeScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
            create: (context) => OfficeBloc()..add(LoadOfficeEvent()),
            child: BlocBuilder<OfficeBloc, OfficeState>(
              builder: (context, state) {
                if (state is OfficeInitialState) {
                  return const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                } else if (state is OfficeLoadedState) {
                  final office = OfficeModel(
                    officeName: state.officeData['office_name'],
                    address: state.officeData['address'],
                    latitude: state.officeData['latitude'],
                    longitude: state.officeData['longitude'],
                  );
                  context.officeProvider.initOffice(office);
                  return const OfficeScreen();
                } else if (state is OfficeErrorState) {
                  return Center(child: Text(state.errorMessage));
                }

                const office = OfficeModel(
                  officeName: '',
                  address: '',
                  latitude: 0.0,
                  longitude: 0.0,
                );
                context.officeProvider.initOffice(office);
                return const OfficeScreen();
              },
            ),
          );
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
        (_) => MultiBlocProvider(providers: [
          BlocProvider(
            create: (_) => sl<AuthBloc>(),
          ),
          BlocProvider(create: (_) => OfficeBloc()),
        ], child: const RegisterScreen()),
        settings: settings,
      );

    case EditOfficeScreen.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => OfficeBloc()..add(LoadOfficeEvent())),
          ],
          child: const EditOfficeScreen(),
        ),
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
