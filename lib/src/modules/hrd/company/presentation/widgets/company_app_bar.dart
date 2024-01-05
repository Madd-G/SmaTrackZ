import 'package:smatrackz/core.dart';

class CompanyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CompanyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      actions: [
        const Icon(
          Icons.notifications,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 10.0),
        Container(
          height: 20.0,
          width: 1.0,
          color: AppColors.lightGreyColor,
        ),
        const SizedBox(width: 10.0),
        if (! Responsive.isMobile(context))
        Row(
          children: [
            Text(
              context.currentUser!.email,
              style: CustomTextStyle.textMediumRegular
                  .copyWith(color: AppColors.lightGreyColor),
            ),
            const SizedBox(width: 15.0),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            right: Responsive.isDesktop(context) ? 50.0 : 16.0,
          ),
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration: const BoxDecoration(
                color: AppColors.lightGreyColor,
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            child: Center(
                child: Text(
                  'A',
                  style: CustomTextStyle.textLargeSemiBold
                      .copyWith(color: AppColors.whiteColor),
                )),
          ),
        )
        // PopupMenuButton(
        //   offset: const Offset(0, 50),
        //   surfaceTintColor: Colors.white,
        //   icon: const Icon(Icons.more_horiz),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   itemBuilder: (_) => [
        //     PopupMenuItem<void>(
        //       child: const PopupItem(
        //         title: 'Edit Company',
        //         icon: Icon(
        //           Icons.edit_outlined,
        //           color: AppColors.greyColor,
        //         ),
        //       ),
        //       onTap: () async {
        //         await Navigator.of(context)
        //             .pushNamed(EditCompanyScreen.routeName,
        //             arguments: state.companyData)
        //             .then((value) => context.read<CompanyBloc>().add(
        //             LoadCompanyEvent(
        //                 companyId: context
        //                     .userProvider.user!.companyId)));
        //       },
        //     ),
        //     const PopupMenuItem<void>(
        //       child: PopupItem(
        //         title: 'Notification',
        //         icon: Icon(
        //           IconlyLight.notification,
        //           color: AppColors.greyColor,
        //         ),
        //       ),
        //     ),
        //     const PopupMenuItem<void>(
        //       child: PopupItem(
        //         title: 'Help',
        //         icon: Icon(
        //           Icons.help_outline_outlined,
        //           color: AppColors.greyColor,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
