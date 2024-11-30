import 'package:smatrackz/core.dart';

class EmployeeAttendanceList extends StatelessWidget {
  const EmployeeAttendanceList({
    super.key,
    required this.employees,
  });

  final List<EmployeeEntity> employees;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: employees.length,
      itemBuilder: (context, index) {
        EmployeeEntity employee = employees[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(360),
                        child: CircleAvatar(
                          maxRadius: Responsive.isDesktop(context)
                              ? 25.0
                              : Responsive.isMobile(context)
                                  ? 15.0
                                  : 20.0,
                          backgroundColor: Colors.transparent,
                          child: Image.network(
                            'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=1800&t=st=1698592779~exp=1698593379~hmac=4026faeb332a0ec88f796565ae4ef0c43cf9d4962e4daa408db33ddff5d7f2e3',
                          ),
                        ),
                      ),
                      SizedBox(
                          width: Responsive.isMobile(context) ? 10.0 : 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(employee.username,
                              overflow: TextOverflow.ellipsis,
                              style: Responsive.isDesktop(context)
                                  ? CustomTextStyle.textBigSemiBold
                                  : CustomTextStyle.textSemiBold),
                          Text(
                            employee.role ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Responsive.isDesktop(context)
                                ? CustomTextStyle.textMediumRegular
                                    .copyWith(color: AppColors.greyColor)
                                : CustomTextStyle.textSmallRegular
                                    .copyWith(color: AppColors.greyColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     const Icon(
                  //       CupertinoIcons.arrow_down_right,
                  //       size: 15.0,
                  //       color: AppColors.primaryColor,
                  //     ),
                  //     Text(
                  //       // '${employee.workStart}',
                  //       '08:30',
                  //       style: Responsive.isDesktop(context)
                  //           ? CustomTextStyle.textBigSemiBold.copyWith(
                  //         color: AppColors.redColor,
                  //       )
                  //           : CustomTextStyle.textSemiBold.copyWith(
                  //         color: AppColors.redColor,
                  //       ),
                  //     ),
                  //     SizedBox(width: Responsive.isMobile(context) ? 10.0 : 30.0),
                  //     const Icon(
                  //       CupertinoIcons.arrow_up_right,
                  //       size: 15.0,
                  //       color: AppColors.primaryColor,
                  //     ),
                  //     Text(
                  //       // '${employee.workEnd}',
                  //       '16:43',
                  //       style: Responsive.isDesktop(context)
                  //           ? CustomTextStyle.textBigSemiBold.copyWith(
                  //               color: AppColors.redColor,
                  //             )
                  //           : CustomTextStyle.textSemiBold.copyWith(
                  //               color: AppColors.redColor,
                  //             ),
                  //     ),
                  //   ],
                  // )
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          // '${employee.workEnd}',
                          'Active',
                          style: Responsive.isDesktop(context)
                              ? CustomTextStyle.textBigSemiBold.copyWith(
                                  color: AppColors.greenColor,
                                )
                              : CustomTextStyle.textSemiBold.copyWith(
                                  color: AppColors.greenColor,
                                ),
                        ),
                      ),
                ],
              ),
              const SizedBox(height: 15.0),
              const Divider(
                height: 10.0,
                color: AppColors.buttonGreyColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
