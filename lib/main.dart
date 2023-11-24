import 'package:smatrackz/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirebaseAppCheck.instance.activate();
  // FirebaseAppCheck.instance.onTokenChange.listen((token) {
  //   print('App Check token refreshed: $token');
  // });

  await init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OfficeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavController()),
        ChangeNotifierProvider(create: (_) => CustomTabController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.navigatorKey,
        theme: AppTheme.lightTheme,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
