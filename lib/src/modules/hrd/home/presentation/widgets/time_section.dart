import 'package:smatrackz/core.dart';

class TimeSection extends StatelessWidget {
  const TimeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          WorkWidget(
            icon: Icons.access_time,
            time: '08:30',
            title: '  Check In  ',
          ),
          WorkWidget(
            icon: Ionicons.stop_circle_outline,
            time: '17:00',
            title: '  Check Out ',
          ),
          WorkWidget(
            icon: IconlyLight.work,
            time: '8.30',
            title: 'Working hr\'s',
          ),
        ],
      ),
    );
  }
}

class WorkWidget extends StatelessWidget {
  const WorkWidget({
    super.key,
    required this.icon,
    required this.time,
    required this.title,
  });

  final String time;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) => const RadialGradient(
            center: Alignment.topCenter,
            stops: [.5, 1],
            colors: [
              AppColors.primaryColor,
              AppColors.greenColor,
            ],
          ).createShader(bounds),
          child: Icon(
            icon,
            size: 35,
          ),
        ),
        const SizedBox(height: 15.0),
        Text(
          time,
          style: CustomTextStyle.textLargeBold.copyWith(fontSize: 20.0),
        ),
        Text(title,
            style: CustomTextStyle.textMediumMedium
                .copyWith(color: AppColors.greyColor))
      ],
    );
  }
}
