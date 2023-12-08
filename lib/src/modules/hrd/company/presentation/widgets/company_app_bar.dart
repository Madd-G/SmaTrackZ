import 'package:smatrackz/core.dart';

class CompanyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CompanyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        if (state is CompanyLoadedState) {
          return Builder(builder: (context) {
            return AppBar(
              title: const Text(
                'Company',
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
                    PopupMenuItem<void>(
                      child: const PopupItem(
                        title: 'Edit Company',
                        icon: Icon(
                          Icons.edit_outlined,
                          color: AppColors.greyColor,
                        ),
                      ),
                      // onTap: () => Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EditCompanyScreen(state.companyData),
                      //   ),
                      // ),
                      onTap: () async {
                        await Navigator.of(context)
                            .pushNamed(EditCompanyScreen.routeName,
                            arguments: state.companyData)
                            .then((value) => context.read<CompanyBloc>().add(
                            LoadCompanyEvent(
                                companyId: context
                                    .userProvider.user!.companyId)));
                      },
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
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
