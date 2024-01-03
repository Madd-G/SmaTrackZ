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
        Text(company.website ?? '', style: CustomTextStyle.textBigRegular),
        const SizedBox(height: 20.0),
        Text('${company.workStart} - ${company.workEnd}',
            style: CustomTextStyle.textBigRegular),
        const SizedBox(height: 20.0),
        SizedBox(
          height: 30.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: days
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 40.0, minHeight: 35.0),
                          color: AppColors.greenColor,
                          child: Center(
                              child: Text(
                            e,
                            style: const TextStyle(color: AppColors.whiteColor),
                          ))),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
