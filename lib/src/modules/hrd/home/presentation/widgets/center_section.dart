import 'package:smatrackz/core.dart';

class CenterSection extends StatelessWidget {
  const CenterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClockBloc(),
      child: Column(
        children: [
          BlocBuilder<ClockBloc, ClockState>(
            builder: (context, state) {
              String time = state.time.clockFormat;
              return Text(
                time,
                style: CustomTextStyle.textLargeSemiBold
                    .copyWith(fontSize: 28.0, color: AppColors.greyColor),
              );
            },
          ),
          const SizedBox(height: 20.0),
          Container(
            height: 200.0,
            width: 200.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100.0)),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  AppColors.greenColor,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.back_hand_outlined,
                  size: 70.0,
                  color: AppColors.whiteColor,
                ),
                const SizedBox(height: 5.0),
                Text('Check In',
                    style: CustomTextStyle.textLargeSemiBold
                        .copyWith(color: AppColors.whiteColor)),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on),
              Text('Location: Kebumen'),
            ],
          ),
        ],
      ),
    );
  }
}
