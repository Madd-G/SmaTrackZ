import 'package:smatrackz/core.dart';

class CompanySection extends StatelessWidget {
  const CompanySection({
    super.key,
    required this.company,
    required this.nameController,
    required this.emailController,
    required this.addCompanyFormKey,
  });

  final UserModel company;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final GlobalKey<FormState> addCompanyFormKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                company.companyName,
                maxLines: 2,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyle.headingSemiBold,
              ),
            ),
            const SizedBox(width: 70.0),
            RoundedContainer(
              width: 175.0,
              radius: 5.0,
              containerColor: AppColors.buttonGreyColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit,
                      color: AppColors.greyColor,
                      size: 15.0,
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      'Edit Office',
                      style: CustomTextStyle.textMediumRegular
                          .copyWith(color: AppColors.greyColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.isDesktop(context) ? 25.0 : 12.0),
        RoundedContainer(
          width: context.width,
          borderColor: AppColors.whiteColor,
          radius: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CompanyProfilePhoto(),
                    const SizedBox(width: 40.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CompanyInfoTile(
                          icon: Icons.location_on,
                          info: company.address,
                        ),
                        const SizedBox(height: 20.0),
                        const CompanyInfoTile(
                          icon: Ionicons.earth,
                          info: 'website',
                        ),
                        const SizedBox(height: 20.0),
                        const CompanyInfoTile(
                          icon: Icons.access_time,
                          info: "Office Timing",
                        ),
                        const SizedBox(height: 20.0),
                        const CompanyInfoTile(
                          icon: Icons.calendar_month_outlined,
                          info: 'Working Days',
                        ),
                        // LocationPicker(
                        //   id: 'companyLocation',
                        //   company: CompanyModel(
                        //     companyId: state.companyData.companyId,
                        //     companyName: state.companyData.companyName,
                        //     address: state.companyData.address,
                        //     latitude: state.companyData.latitude,
                        //     longitude: state.companyData.longitude,
                        //     website: state.companyData.website,
                        //     workStart: state.companyData.workStart,
                        //     workEnd: state.companyData.workEnd,
                        //     phoneNumber: state.companyData.phoneNumber,
                        //   ),
                        //   onChanged: (latitude, longitude) {
                        //     latitude = latitude;
                        //     longitude = longitude;
                        //   },
                        // ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Show Map',
                          style: CustomTextStyle.textBigRegular.copyWith(
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(company.website ?? '',
                            style: CustomTextStyle.textBigRegular),
                        const SizedBox(height: 20.0),
                        Text('${company.workStart} - ${company.workEnd}',
                            style: CustomTextStyle.textBigRegular),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                  minWidth: 40.0, minHeight: 35.0),
                              color: AppColors.greenColor,
                              child: const Center(
                                child: Text(
                                  'Mon',
                                  style: TextStyle(color: AppColors.whiteColor),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              constraints: const BoxConstraints(
                                  minWidth: 40.0, minHeight: 35.0),
                              color: AppColors.greenColor,
                              child: const Center(
                                  child: Text(
                                'Tue',
                                style: TextStyle(color: AppColors.whiteColor),
                              )),
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              constraints: const BoxConstraints(
                                  minWidth: 40.0, minHeight: 35.0),
                              color: AppColors.greenColor,
                              child: const Center(
                                child: Text(
                                  'Wed',
                                  style: TextStyle(color: AppColors.whiteColor),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              constraints: const BoxConstraints(
                                  minWidth: 40.0, minHeight: 35.0),
                              color: AppColors.greenColor,
                              child: const Center(
                                  child: Text(
                                'Thu',
                                style: TextStyle(color: AppColors.whiteColor),
                              )),
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              constraints: const BoxConstraints(
                                  minWidth: 40.0, minHeight: 35.0),
                              color: AppColors.greenColor,
                              child: const Center(
                                child: Text(
                                  'Fri',
                                  style: TextStyle(color: AppColors.whiteColor),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              constraints: const BoxConstraints(
                                  minWidth: 40.0, minHeight: 35.0),
                              color: AppColors.lightGreyColor,
                              child: const Center(
                                child: Text(
                                  'Sat',
                                  style: TextStyle(color: AppColors.whiteColor),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              constraints: const BoxConstraints(
                                  minWidth: 40.0, minHeight: 35.0),
                              color: AppColors.lightGreyColor,
                              child: const Center(
                                child: Text(
                                  'Sun',
                                  style: TextStyle(color: AppColors.whiteColor),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(width: 40.0),
                    Column(
                      children: [
                        AddEmployeeButton(
                          nameController: nameController,
                          emailController: emailController,
                          addCompanyFormKey: addCompanyFormKey,
                          company: company,
                        ),
                        const SizedBox(height: 10.0),
                        RoundedContainer(
                          width: 175.0,
                          radius: 5.0,
                          containerColor: AppColors.whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
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
                                  'Holiday Calendar',
                                  style: CustomTextStyle.textMediumRegular
                                      .copyWith(
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        RoundedContainer(
                          width: 175.0,
                          radius: 5.0,
                          containerColor: AppColors.whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.area_chart,
                                  color: AppColors.greyColor,
                                  size: 15.0,
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  'Team Reports',
                                  style: CustomTextStyle.textMediumRegular
                                      .copyWith(
                                    color: AppColors.greyColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
