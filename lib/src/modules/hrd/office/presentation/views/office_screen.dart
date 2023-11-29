import 'package:smatrackz/core.dart';

class OfficeScreen extends StatelessWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  static const routeName = '/office';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OfficeBloc>()..add(LoadOfficeEvent()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const OfficeAppBar(),
        body: BackgroundImage(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 24.0,
                ),
                child: Consumer<OfficeProvider>(
                  builder: (_, provider, __) {
                    final office = provider.office!;
                    return RoundedContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(office.officeName,
                                      maxLines: 2,
                                      style: CustomTextStyle
                                          .headingSemiBold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            OfficeInfo(
                              icon: Icons.location_on,
                              info: office.address,
                            ),
                            const SizedBox(height: 20.0),
                            const OfficeInfo(
                              icon: Icons.access_time,
                              info: '09.00 - 18.00',
                            ),
                            const SizedBox(height: 20.0),
                            const OfficeInfo(
                              icon: Icons.phone,
                              info: '(0281) 344597',
                            ),
                            const SizedBox(height: 20.0),
                            const OfficeInfo(
                              icon: Icons.person,
                              info: '581 people',
                            ),
                            LocationPicker(
                              id: 'officeLocation',
                              buttonLabel: 'View Location',
                              latitude: office.latitude,
                              longitude: office.longitude,
                              onChanged: (latitude, longitude) {
                                latitude = latitude;
                                longitude = longitude;
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ),
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
