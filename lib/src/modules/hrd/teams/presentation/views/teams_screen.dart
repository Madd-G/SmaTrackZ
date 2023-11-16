import 'package:smatrackz/core.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  static const routeName = '/teams';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 16.0, top: 16.0, right: 16.0, bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Team', style: CustomTextStyle.headingSemiBold),
                  SizedBox(height: 25.0),
                  AbsenceCard(),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TeamCard(
                        icon: Icons.work,
                        title: 'Employee Reports',
                        color: AppColors.primaryColor,
                      ),
                      TeamCard(
                        icon: Icons.question_mark,
                        title: 'Requests',
                        color: AppColors.redColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TeamCard(
                        icon: CupertinoIcons.bell_fill,
                        title: 'Events',
                        color: AppColors.blueColor,
                      ),
                      TeamCard(
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
