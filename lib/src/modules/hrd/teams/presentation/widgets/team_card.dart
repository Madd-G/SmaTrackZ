import 'package:smatrackz/core.dart';

class TeamCard extends StatelessWidget {
  const TeamCard(
      {super.key,
      required this.title,
      required this.color,
      required this.icon});

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      radius: 30.0,
      height: context.width * 0.44,
      width: context.width * 0.44,
      containerColor: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, top: 32.0, right: 16.0, bottom: 8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50.0,
                color: color,
              ),
              const SizedBox(height: 20.0),
              Text(
                title,
                style:
                    CustomTextStyle.textLargeSemiBold.copyWith(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
