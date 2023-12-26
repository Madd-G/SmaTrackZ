import 'package:smatrackz/core.dart';


class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  static const routeName = '/main_navigation';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: UserUtils.userDataStream,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data is UserModel) {
          context.read<UserProvider>().user = snapshot.data;
        }
        return Consumer<NavigationController>(
          builder: (context, controller, __) {
            return Scaffold(
              // drawer: ConstrainedBox(
              //   constraints: const BoxConstraints(maxWidth: 250),
              //   child: const SideMenu(),
              // ),
              body: Responsive(
                mobile: IndexedStack(
                  index: controller.currentIndex,
                  children: controller.screens,
                ),
                tablet: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SideMenu(controller),
                    Expanded(
                      flex: 5,
                      child: IndexedStack(
                        index: controller.currentIndex,
                        children: controller.screens,
                      ),
                    ),
                  ],
                ),
                desktop: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SideMenu(controller),
                    Expanded(
                      flex: 5,
                      child: IndexedStack(
                        index: controller.currentIndex,
                        children: controller.screens,
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Visibility(
                visible: Responsive.isMobile(context) ? true : false,
                child: Container(
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
              ),
            );
          },
        );
      },
    );
  }
}
