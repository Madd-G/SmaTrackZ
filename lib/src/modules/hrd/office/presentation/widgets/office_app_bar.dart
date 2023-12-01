import 'package:smatrackz/core.dart';

class OfficeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OfficeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return AppBar(
        title: const Text(
          'Office',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.back),
        ),
        actions: [
          PopupMenuButton(
            offset: const Offset(0, 50),
            surfaceTintColor: Colors.white,
            icon: const Icon(Icons.more_horiz),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            itemBuilder: (_) => [
              const PopupMenuItem<void>(
                child: PopupItem(
                  title: 'Edit Office',
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.greyColor,
                  ),
                ),
                // onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => BlocProvider(
                //       create: (_) => sl<OfficeBloc>(),
                //       child: const EditOfficeScreen(),
                //     ),
                //   ),
                // ),
              ),
              const PopupMenuItem<void>(
                child: PopupItem(
                  title: 'Notification',
                  icon: Icon(
                    IconlyLight.notification,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              const PopupMenuItem<void>(
                child: PopupItem(
                  title: 'Help',
                  icon: Icon(
                    Icons.help_outline_outlined,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
