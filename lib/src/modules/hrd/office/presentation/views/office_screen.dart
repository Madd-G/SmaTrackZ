import 'package:smatrackz/core.dart';
import 'package:smatrackz/src/modules/hrd/office/presentation/views/edit_office_screen.dart';

class OfficeScreen extends StatelessWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  static const routeName = '/office';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                right: 16.0,
                bottom: 24.0,
              ),
              child: BlocBuilder<CompanyBloc, CompanyState>(
                builder: (context, state) {
                  if (state is CompanyInitialState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CompanyLoadedState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25.0),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  '${state.companyData["company_name"]}',
                                  maxLines: 2,
                                  style: CustomTextStyle.textLargeSemiBold
                                      .copyWith(fontSize: 18.0)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        RoundedContainer(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                OfficeInfo(
                                  icon: Icons.location_on,
                                  info: state.companyData["address"],
                                ),
                                const SizedBox(height: 15.0),
                                const OfficeInfo(
                                  icon: Icons.access_time,
                                  info: '09.00 - 18.00',
                                ),
                                const SizedBox(height: 15.0),
                                const OfficeInfo(
                                  icon: Icons.phone,
                                  info: '(0281) 344597',
                                ),
                                const SizedBox(height: 15.0),
                                const OfficeInfo(
                                  icon: Icons.person,
                                  info: '581 people',
                                ),
                                const SizedBox(height: 15.0),
                                LocationPicker(
                                  id: 'location',
                                  latitude: state.companyData["latitude"],
                                  longitude: state.companyData["longitude"],
                                  onChanged: (latitude, longitude) {
                                    latitude = latitude;
                                    longitude = longitude;
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is CompanyErrorState) {
                    return Center(child: Text("Error: ${state.errorMessage}"));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          if (state is CompanyLoadedState) {
            return BottomAppBar(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditOfficeScreen.routeName);
                },
                child: const Text('Edit Office'),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class OfficeInfo extends StatelessWidget {
  const OfficeInfo({super.key, required this.icon, required this.info});

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
