import 'package:smatrackz/core.dart';

class ShowMap extends StatelessWidget {
  const ShowMap({super.key, required this.company});

  final UserModel company;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (mapDialogContext) {
              return AlertDialog(
                content: MapScreen(company),
              );
            });
      },
      child: Text(
        'Show Map',
        style: CustomTextStyle.textBigRegular.copyWith(
          color: AppColors.primaryColor,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryColor,
        ),
      ),
    );
  }
}
