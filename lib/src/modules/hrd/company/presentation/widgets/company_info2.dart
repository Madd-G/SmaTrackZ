import 'package:smatrackz/core.dart';

class CompanyInfo2 extends StatelessWidget {
  const CompanyInfo2({super.key, required this.company});

  final UserModel company;

  static const List<String> days = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: (size.width > 600)
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        ShowMap(company: company),
        const SizedBox(height: 20.0),
        Text(
          company.website ?? '',
          style: Responsive.isMobile(context)
              ? CustomTextStyle.textRegular.copyWith(
                  color: AppColors.greyColor,
                )
              : CustomTextStyle.textBigRegular.copyWith(
                  color: AppColors.greyColor,
                ),
        ),
        const SizedBox(height: 20.0),
        Text(
          '${company.workStart} - ${company.workEnd}',
          style: Responsive.isMobile(context)
              ? CustomTextStyle.textRegular.copyWith(
                  color: AppColors.greyColor,
                )
              : CustomTextStyle.textBigRegular.copyWith(
                  color: AppColors.greyColor,
                ),
        ),
        const SizedBox(height: 27.0),
        SizedBox(
          height: Responsive.isMobile(context) ? 22.0 : 25.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: days
                .map((day) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 30.0, minHeight: 30.0),
                        decoration: const BoxDecoration(
                            color: AppColors.greenColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Center(
                            child: Text(
                              day,
                              style: CustomTextStyle.textRegular
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
