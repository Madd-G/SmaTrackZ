import 'package:smatrackz/core.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Center(
          child: Text(Responsive.isMobile(context)
              ? 'Mobile'
              : Responsive.isTablet(context)
                  ? 'Tablet'
                  : Responsive.isDesktop(context)
                      ? 'Desktop'
                      : 'Else'),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     HomeHeader(),
        //     CenterSection(),
        //     TimeSection(),
        //   ],
        // ),
      ),
    );
  }
}
