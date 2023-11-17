import 'package:smatrackz/core.dart';

class TeamCard extends StatelessWidget {
  const TeamCard({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        radius: 30.0,
        height: context.width * 0.44,
        width: context.width * 0.44,
        containerColor: AppColors.whiteColor,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, top: 24.0, right: 16.0, bottom: 8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 45.0,
                  color: color,
                ),
                const SizedBox(height: 10.0),
                Text(
                  title,
                  style: CustomTextStyle.textLargeSemiBold
                      .copyWith(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
