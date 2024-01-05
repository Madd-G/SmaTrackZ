import 'package:smatrackz/core.dart';

class FilterByDateButton extends StatelessWidget {
  const FilterByDateButton({super.key, this.height, this.width, this.iconSize});

  final double? height, width, iconSize;
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: height,
      width: width,
      radius: 5.0,
      containerColor: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.greyColor,
                  size: 15.0,
                ),
                const SizedBox(width: 5.0),
                Text(
                  '27 Dec 2023',
                  style: Responsive.isDesktop(context)
                      ? CustomTextStyle.textBigRegular.copyWith(
                    color: AppColors.greyColor,
                  )
                      : CustomTextStyle.textRegular.copyWith(
                    color: AppColors.greyColor,
                  ),
                )
              ],
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.lightGreyColor,
              size: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
