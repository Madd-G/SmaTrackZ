import 'package:smatrackz/core.dart';
import 'package:smatrackz/src/modules/hrd/office/presentation/views/edit_office_screen.dart';

class OfficeScreen extends StatelessWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  static const routeName = '/office';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child:
        BlocProvider(
          create: (context) => sl<OfficeBloc>()
            ..add(LoadOfficeEvent(context.officeProvider.office)),
          child: BlocBuilder<OfficeBloc, OfficeState>(
            builder: (context, state) {
              if (state is OfficeInitialState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OfficeLoadedState) {
                final office = OfficeModel(
                  officeId: state.officeData.officeId,
                  officeName: state.officeData.officeName,
                  address: state.officeData.address,
                  latitude: state.officeData.latitude,
                  longitude: state.officeData.longitude,
                  website: state.officeData.website,
                );
                context.officeProvider.initOffice(office);
                return SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        top: 16.0,
                        right: 16.0,
                        bottom: 24.0,
                      ),
                      child: Consumer<OfficeProvider>(
                        builder: (_, provider, __) {
                          final office = provider.office!;
                          print('+++++++++++\n$office\n+++++++++++');
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 25.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      office.officeName,
                                      maxLines: 2,
                                      style: CustomTextStyle.textLargeSemiBold
                                          .copyWith(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              RoundedContainer(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
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
                                        id: 'location',
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
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              } else if (state is OfficeErrorState) {
                return Center(child: Text(state.errorMessage));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<OfficeBloc, OfficeState>(
        builder: (context, state) {
          if (state is OfficeLoadedState) {
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
