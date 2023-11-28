import 'package:smatrackz/core.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  Size get mediaQuery => MediaQuery.sizeOf(this);

  Size get size => mediaQuery;

  double get width => size.width;

  double get height => size.height;

  UserProvider get userProvider => read<UserProvider>();

  UserEntity? get currentUser => userProvider.user;

  OfficeProvider get officeProvider => read<OfficeProvider>();

  OfficeEntity? get office => officeProvider.office;

  TabNavigator get tabNavigator => read<TabNavigator>();

  void pop() => tabNavigator.pop();

  void push(Widget page) => tabNavigator.push(TabItem(child: page));
}
