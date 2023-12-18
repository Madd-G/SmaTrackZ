import 'package:smatrackz/core.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  static const routeName = '/bottom_navigation';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: UserUtils.userDataStream,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data is UserModel) {
          context.read<UserProvider>().user = snapshot.data;
        }
        return Consumer<BottomNavController>(
          builder: (context, controller, __) {
            return Scaffold(
              body: IndexedStack(
                index: controller.currentIndex,
                children: controller.screens,
              ),
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  color: AppColors.redColor,
                  border: Border(
                    top: BorderSide(width: 0.3, color: AppColors.greyColor),
                  ),
                ),
                child: BottomNavigationBar(
                  currentIndex: controller.currentIndex,
                  showSelectedLabels: false,
                  backgroundColor: AppColors.redColor,
                  elevation: 0,
                  onTap: controller.changeIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 0
                            ? IconlyBold.home
                            : IconlyLight.home,
                        color: controller.currentIndex == 0
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 1
                            ? CupertinoIcons.person_2_fill
                            : CupertinoIcons.person_2,
                        color: controller.currentIndex == 1
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                      label: 'Teams',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 2
                            ? IconlyBold.chart
                            : IconlyLight.chart,
                        color: controller.currentIndex == 2
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                      label: 'Attendances',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 3
                            ? IconlyBold.chat
                            : IconlyLight.chat,
                        color: controller.currentIndex == 3
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 4
                            ? IconlyBold.profile
                            : IconlyLight.profile,
                        color: controller.currentIndex == 4
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
