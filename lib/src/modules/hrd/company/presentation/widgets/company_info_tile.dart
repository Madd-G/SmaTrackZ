import 'package:smatrackz/core.dart';

class CompanyInfoTile extends StatelessWidget {
  const CompanyInfoTile({
    super.key,
    required this.icon,
    required this.info,
  });

  final IconData icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.greyColor,
          size: 20.0,
        ),
        if (size.width > 600) const SizedBox(width: 10.0),
        if (size.width > 600)
          Expanded(
            child: Text(
              info,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyle.textBigRegular.copyWith(
                color: AppColors.greyColor,
              ),
            ),
          )
      ],
    );
  }
}
