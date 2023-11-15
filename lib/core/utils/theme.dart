import 'package:smatrackz/core.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: AppFont.poppins,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: AppColors.primaryColor,
    ),
  );
}
