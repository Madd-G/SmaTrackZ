import 'package:smatrackz/core.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(IconlyBold.user_2, color: Colors.white),
                  Text(
                    'Friday, 10 February 2023',
                    style: CustomTextStyle.textLargeMedium
                        .copyWith(color: AppColors.whiteColor),
                  ),
                  const Icon(IconlyBold.notification, color: Colors.white),
                ],
              ),
              const SizedBox(height: 30.0),
              const ProfileCard(),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
