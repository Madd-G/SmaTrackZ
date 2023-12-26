import 'package:smatrackz/core.dart';

class SideMenu extends StatefulWidget {
  const SideMenu(this.controller, {super.key});

  final NavigationController controller;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(top: kIsWeb ? 20.0 : 0),
      color: AppColors.whiteColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SideMenuItem(
                press: () {
                  pressExpand(isExpanded);
                  setState(() {});
                },
                title: "",
                icon: isExpanded
                    ? Icons.keyboard_double_arrow_left_rounded
                    : Icons.keyboard_double_arrow_right_rounded,
                isActive: true,
                isExpanded: isExpanded,
                // itemCount: 3,
              ),
              SideMenuItem(
                press: () {
                  widget.controller.changeIndex(0);
                },
                title: "Overview",
                icon: IconlyBold.home,
                isActive: widget.controller.currentIndex == 0 ? true : false,
                isExpanded: isExpanded,
              ),
              SideMenuItem(
                press: () {
                  widget.controller.changeIndex(1);
                },
                title: "Team",
                icon: IconlyBold.user_3,
                isActive: widget.controller.currentIndex == 1 ? true : false,
                isExpanded: isExpanded,
              ),
              SideMenuItem(
                press: () {
                  widget.controller.changeIndex(2);
                },
                title: "Chart",
                icon: IconlyBold.chart,
                isActive: widget.controller.currentIndex == 2 ? true : false,
                isExpanded: isExpanded,
              ),
              SideMenuItem(
                press: () {
                  widget.controller.changeIndex(3);
                },
                title: "Chat",
                icon: IconlyBold.chat,
                isActive: widget.controller.currentIndex == 3 ? true : false,
                isExpanded: isExpanded,
              ),
              SideMenuItem(
                press: () {
                  widget.controller.changeIndex(4);
                },
                title: "Profile",
                icon: IconlyBold.profile,
                isActive: widget.controller.currentIndex == 4 ? true : false,
                isExpanded: isExpanded,
              ),
              const SizedBox(height: 20.0 * 2),
              // Tags
              // Tags(),
            ],
          ),
        ),
      ),
    );
  }

  void pressExpand(bool isExpanded) {
    this.isExpanded = !isExpanded;
  }
}
