import 'package:smatrackz/core.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  static const routeName = '/company';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CompanyAppBar(),
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 24.0,
              ),
              child: RoundedContainer(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocConsumer<CompanyBloc, CompanyState>(
                    listener: (_, state) {
                      if (state is CompanyErrorState) {
                        CoreUtils.showSnackBar(context, state.errorMessage);
                      }
                    },
                    builder: (_, state) {
                      if (state is CompanyInitialState) {
                        return const SizedBox(
                          height: 400.0,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is CompanyLoadedState) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(state.companyData.companyName!,
                                      maxLines: 2,
                                      style: CustomTextStyle.headingSemiBold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            CompanyInfo(
                              icon: Ionicons.earth,
                              info: state.companyData.website!,
                            ),
                            const SizedBox(height: 20.0),
                            CompanyInfo(
                              icon: Icons.access_time,
                              info: "${state.companyData.workStart!} - ${state.companyData.workEnd!}",
                            ),
                            const SizedBox(height: 20.0),
                            CompanyInfo(
                              icon: Icons.phone,
                              info: state.companyData.phoneNumber!,
                            ),
                            const SizedBox(height: 20.0),
                            const CompanyInfo(
                              icon: Icons.person,
                              info: '581 people',
                            ),
                            const SizedBox(height: 20.0),
                            CompanyInfo(
                              icon: Icons.location_on,
                              info: state.companyData.address!,
                            ),
                            LocationPicker(
                              id: 'companyLocation',
                              company: CompanyModel(
                                companyId: state.companyData.companyId,
                                companyName: state.companyData.companyName,
                                address: state.companyData.address,
                                latitude: state.companyData.latitude,
                                longitude: state.companyData.longitude,
                                website: state.companyData.website,
                                workStart: state.companyData.workStart,
                                workEnd: state.companyData.workEnd,
                                phoneNumber: state.companyData.phoneNumber,
                              ),
                              onChanged: (latitude, longitude) {
                                latitude = latitude;
                                longitude = longitude;
                              },
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompanyInfo extends StatelessWidget {
  const CompanyInfo({
    super.key,
    required this.icon,
    required this.info,
  });

  final IconData icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.greyColor,
          size: 20.0,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            info,
            maxLines: 2,
            style: CustomTextStyle.textBigRegular.copyWith(
              color: AppColors.greyColor,
            ),
          ),
        )
      ],
    );
  }
}
