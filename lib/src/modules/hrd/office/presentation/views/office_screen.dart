import 'package:smatrackz/core.dart';

class OfficeScreen extends StatefulWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  static const routeName = '/office';

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> {
  void getOffice() {
    context
        .read<OfficeBloc>()
        .add(LoadOfficeEvent(officeId: context.userProvider.user!.companyId!));
  }

  @override
  void initState() {
    getOffice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OfficeBloc>()
        ..add(LoadOfficeEvent(officeId: context.userProvider.user!.companyId!)),
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
                child: RoundedContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocConsumer<OfficeBloc, OfficeState>(
                      listener: (_, state) {
                        if (state is OfficeErrorState) {
                          CoreUtils.showSnackBar(context, state.errorMessage);
                        }
                      },
                      builder: (context, state) {
                        if (state is OfficeInitialState) {
                          return const SizedBox(
                            height: 400.0,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is OfficeLoadedState) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(state.officeData.officeName,
                                        maxLines: 2,
                                        style: CustomTextStyle.headingSemiBold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              OfficeInfo(
                                icon: Icons.location_on,
                                info: state.officeData.address,
                              ),
                              const SizedBox(height: 20.0),
                              OfficeInfo(
                                icon: Icons.access_time,
                                info: state.officeData.workingTime,
                              ),
                              const SizedBox(height: 20.0),
                              OfficeInfo(
                                icon: Icons.phone,
                                info: state.officeData.phoneNumber,
                              ),
                              const SizedBox(height: 20.0),
                              const OfficeInfo(
                                icon: Icons.person,
                                info: '581 people',
                              ),
                              LocationPicker(
                                id: 'officeLocation',
                                buttonLabel: 'View Location',
                                latitude: state.officeData.latitude,
                                longitude: state.officeData.longitude,
                                onChanged: (latitude, longitude) {
                                  latitude = latitude;
                                  longitude = longitude;
                                },
                              )
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
