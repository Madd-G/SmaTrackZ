import 'package:smatrackz/core.dart';

class NavigationController extends ChangeNotifier {
  final List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(child: const HomeScreen()),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(child: const CompanyScreen()),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
            child: const Scaffold(body: Center(child: Text('Attendances')))),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          // child: BlocProvider(
          //   create: (_) => sl<GroupCubit>(),
          //   child: const ChatHomeView(),
          // ),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<GroupCubit>()),
              BlocProvider(create: (_) => sl<ChatCubit>()),
            ],
            child: const ChatHomeView(),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(child: const ProfileScreen()),
      ),
      child: const PersistentView(),
    ),
  ];

  List<Widget> get screens => _screens;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }
}
