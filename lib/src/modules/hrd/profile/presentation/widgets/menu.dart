import 'package:smatrackz/core.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          Text('Main Menu',
              style: CustomTextStyle.textLargeBold.copyWith(fontSize: 20.0)),
          const SizedBox(height: 5.0),
          RoundedContainer(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  MenuItem(
                    icon: Icons.person,
                    title: 'Personal Information',
                    onPressed: () {},
                  ),
                  MenuItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    onPressed: () {},
                  ),
                  MenuItem(
                    icon: Icons.help_rounded,
                    title: 'help Center',
                    onPressed: () {},
                  ),
                  MenuItem(
                    icon: Icons.logout,
                    title: 'Log Out',
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      await FirebaseAuth.instance.signOut();
                      unawaited(
                        navigator.pushNamedAndRemoveUntil(
                          '/',
                          (route) => false,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.greyColor),
          const SizedBox(width: 15.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onPressed,
                  child: Text(
                    title,
                    style: CustomTextStyle.textLargeBold
                        .copyWith(color: AppColors.greyColor),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Color(0xFFF8F8F8),
                  thickness: 3,
                  height: 15.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
