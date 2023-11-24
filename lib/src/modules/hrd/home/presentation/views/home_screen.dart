import 'package:smatrackz/core.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundImage(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeHeader(),
            CenterSection(),
            TimeSection(),
          ],
        ),
      ),
    );
  }
}
