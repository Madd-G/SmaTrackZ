import 'package:smatrackz/core.dart';

class DetailEmployeeScreen extends StatelessWidget {
  const DetailEmployeeScreen(this.employee, {super.key});

  static const routeName = '/employee-detail';

  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundImage(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeHeader(),
          ],
        ),
      ),
    );
  }
}
