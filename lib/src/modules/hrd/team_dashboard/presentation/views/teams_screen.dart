import 'package:smatrackz/core.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  static const routeName = '/teams';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 16.0, right: 16.0, bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  const Text('My Team', style: CustomTextStyle.headingSemiBold),
                  const SizedBox(height: 25.0),
                  const AbsenceCard(),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TeamCard(
                        onTap: () {},
                        icon: Icons.work,
                        title: 'Employee Reports',
                        color: AppColors.primaryColor,
                      ),
                      TeamCard(
                        onTap: () {},
                        icon: Icons.question_mark,
                        title: 'Requests',
                        color: AppColors.redColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TeamCard(
                        onTap: () {
                          Navigator.pushNamed(context, OfficeScreen.routeName);
                        },
                        icon: Icons.location_on,
                        title: 'Office & Location',
                        color: AppColors.blueColor,
                      ),
                      TeamCard(
                        onTap: () {
                          Navigator.pushNamed(
                              context, EmployeeListScreen.routeName);
                        },
                        icon: Icons.people_rounded,
                        title: 'Employees',
                        color: AppColors.purpleColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
