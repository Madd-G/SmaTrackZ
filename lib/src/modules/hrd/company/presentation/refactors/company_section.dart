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
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  company.companyName,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: Responsive.isMobile(context) ? CustomTextStyle.textLargeSemiBold.copyWith(fontSize: 18.0) : CustomTextStyle.headingSemiBold,
                ),
              ),
              const SizedBox(width: 70.0),
              (Responsive.isMobile(context))
                  ? const Icon(
                      Icons.edit,
                      color: AppColors.greyColor,
                      size: 15.0,
                    )
                  : RoundedContainer(
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
        ),
        SizedBox(height: Responsive.isDesktop(context) ? 25.0 : 12.0),
        RoundedContainer(
          boxConstraints: const BoxConstraints(maxWidth: 1200),
          width: MediaQuery.of(context).size.width,
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
                    if (size.width > 1300) const CompanyProfilePhoto(),
                    if (size.width > 600) const SizedBox(width: 10.0),
                    CompanyInfo(company: company),
                    if (size.width > 600) const SizedBox(width: 20.0),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CompanyInfo2(company: company),
                    if (size.width > 600) const SizedBox(width: 20.0),
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
