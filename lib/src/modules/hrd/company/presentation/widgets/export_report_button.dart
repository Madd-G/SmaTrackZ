import 'package:smatrackz/core.dart';

class ExportReportButton extends StatelessWidget {
  const ExportReportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      radius: 5.0,
      containerColor: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.download,
              color: AppColors.greyColor,
              size: 15.0,
            ),
            if (context.width > 1300)
              Row(
                children: [
                  const SizedBox(width: 5.0),
                  Text(
                    'Export Reports',
                    style: CustomTextStyle.textMediumRegular.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
