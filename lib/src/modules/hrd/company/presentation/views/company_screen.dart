import 'package:smatrackz/core.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  static const routeName = '/company';

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  void initState() {
    context
        .read<CompanyBloc>()
        .add(LoadCompanyEvent(companyId: context.userProvider.user!.companyId));
    super.initState();
  }

  Map<String, Map<String, dynamic>> resume = {
    'present-employee': {
      "count": 25,
      "title": "Present Employees",
    },
    'absent-employee': {
      "count": 05,
      "title": "Absent Employees",
    },
    'on-leave': {
      "count": 01,
      "title": "On Leave",
    },
    'active-employee': {
      "count": 31,
      "title": "Active Employees",
    },
  };

  List<EmployeeEntity> employees = [
    const EmployeeEntity(
      uid: '',
      username: 'Ian Reynold',
      email: 'ianreynold@gmail.com',
      role: 'Manager',
      workStart: '08:30',
      workEnd: '16:50',
    ),
    const EmployeeEntity(
        uid: '',
        username: 'Budi Arie',
        email: 'barie@gmail.com',
        role: 'Project Manager',
        workStart: '07:59',
        workEnd: '16:39'),
    const EmployeeEntity(
        uid: '',
        username: 'Kathrine Everdeen',
        email: 'kathrine@gmail.com',
        role: 'Mobile Developer',
        workStart: '08:17',
        workEnd: '17:11'),
    const EmployeeEntity(
        uid: '',
        username: 'Sarah Monica',
        email: 'sarahmon@gmail.com',
        role: 'Backend Developer',
        workStart: '08:25',
        workEnd: '17:10'),
    const EmployeeEntity(
        uid: '',
        username: 'Bastian Michael Calvin',
        email: 'bastianclvn@gmail.com',
        role: 'Scrum Master',
        workStart: '08:35',
        workEnd: '16:47'),
    const EmployeeEntity(
        uid: '',
        username: 'Keith ',
        email: 'user5@gmail.com',
        role: 'Mobile Developer',
        workStart: '07:30',
        workEnd: '16:54'),
    const EmployeeEntity(
        uid: '',
        username: 'Angela Christina',
        email: 'christineang@gmail.com',
        role: 'Frontend Developer',
        workStart: '08:04',
        workEnd: '16:31'),
    const EmployeeEntity(
        uid: '',
        username: 'Molly ',
        email: 'molly@gmail.com',
        role: 'Product Owner',
        workStart: '08:30',
        workEnd: '16:56'),
    const EmployeeEntity(
        uid: '',
        username: 'Olive Abigail',
        email: 'oliveabigail@gmail.com',
        role: 'HRD',
        workStart: '08:20',
        workEnd: '17:00'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CompanyAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: Responsive.isDesktop(context) ? 50.0 : 16.0,
              right: Responsive.isDesktop(context) ? 50.0 : 16.0,
              bottom: Responsive.isDesktop(context) ? 24.0 : 8.0,
            ),
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
                      SizedBox(
                          height: Responsive.isDesktop(context) ? 20.0 : 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              state.companyData.companyName!,
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                      SizedBox(
                          height: Responsive.isDesktop(context) ? 25.0 : 12.0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CompanyInfoTile(
                                        icon: Icons.location_on,
                                        info: state.companyData.address!,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Show Map',
                                        style: CustomTextStyle.textBigRegular
                                            .copyWith(
                                          color: AppColors.primaryColor,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              AppColors.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Text(
                                        state.companyData.website!,
                                        style: CustomTextStyle.textBigRegular,
                                      ),
                                      const SizedBox(height: 20.0),
                                      Text(
                                        '${state.companyData.workStart!} - ${state.companyData.workEnd!}',
                                        style: CustomTextStyle.textBigRegular,
                                      ),
                                      const SizedBox(height: 20.0),
                                      Row(
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(
                                                minWidth: 40.0,
                                                minHeight: 35.0),
                                            color: AppColors.greenColor,
                                            child: const Center(
                                                child: Text(
                                              'Mon',
                                              style: TextStyle(
                                                  color: AppColors.whiteColor),
                                            )),
                                          ),
                                          const SizedBox(width: 4.0),
                                          Container(
                                            constraints: const BoxConstraints(
                                                minWidth: 40.0,
                                                minHeight: 35.0),
                                            color: AppColors.greenColor,
                                            child: const Center(
                                                child: Text(
                                              'Tue',
                                              style: TextStyle(
                                                  color: AppColors.whiteColor),
                                            )),
                                          ),
                                          const SizedBox(width: 4.0),
                                          Container(
                                            constraints: const BoxConstraints(
                                                minWidth: 40.0,
                                                minHeight: 35.0),
                                            color: AppColors.greenColor,
                                            child: const Center(
                                                child: Text(
                                              'Wed',
                                              style: TextStyle(
                                                  color: AppColors.whiteColor),
                                            )),
                                          ),
                                          const SizedBox(width: 4.0),
                                          Container(
                                            constraints: const BoxConstraints(
                                                minWidth: 40.0,
                                                minHeight: 35.0),
                                            color: AppColors.greenColor,
                                            child: const Center(
                                                child: Text(
                                              'Thu',
                                              style: TextStyle(
                                                  color: AppColors.whiteColor),
                                            )),
                                          ),
                                          const SizedBox(width: 4.0),
                                          Container(
                                            constraints: const BoxConstraints(
                                                minWidth: 40.0,
                                                minHeight: 35.0),
                                            color: AppColors.greenColor,
                                            child: const Center(
                                                child: Text(
                                              'Fri',
                                              style: TextStyle(
                                                  color: AppColors.whiteColor),
                                            )),
                                          ),
                                          const SizedBox(width: 4.0),
                                          Container(
                                            constraints: const BoxConstraints(
                                                minWidth: 40.0,
                                                minHeight: 35.0),
                                            color: AppColors.lightGreyColor,
                                            child: const Center(
                                                child: Text(
                                              'Sat',
                                              style: TextStyle(
                                                  color: AppColors.whiteColor),
                                            )),
                                          ),
                                          const SizedBox(width: 4.0),
                                          Container(
                                            constraints: const BoxConstraints(
                                                minWidth: 40.0,
                                                minHeight: 35.0),
                                            color: AppColors.lightGreyColor,
                                            child: const Center(
                                                child: Text(
                                              'Sun',
                                              style: TextStyle(
                                                  color: AppColors.whiteColor),
                                            )),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 40.0),
                                  Column(
                                    children: [
                                      RoundedContainer(
                                        width: 175.0,
                                        radius: 5.0,
                                        containerColor: AppColors.primaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.add,
                                                color: AppColors.whiteColor,
                                                size: 15.0,
                                              ),
                                              const SizedBox(width: 5.0),
                                              Text(
                                                'Add Employee',
                                                style: CustomTextStyle
                                                    .textMediumRegular
                                                    .copyWith(
                                                  color: AppColors.whiteColor,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.calendar_month_outlined,
                                                color: AppColors.greyColor,
                                                size: 15.0,
                                              ),
                                              const SizedBox(width: 5.0),
                                              Text(
                                                'Holiday Calendar',
                                                style: CustomTextStyle
                                                    .textMediumRegular
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.area_chart,
                                                color: AppColors.greyColor,
                                                size: 15.0,
                                              ),
                                              const SizedBox(width: 5.0),
                                              Text(
                                                'Team Reports',
                                                style: CustomTextStyle
                                                    .textMediumRegular
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
                      const SizedBox(height: 20.0),
                      RoundedContainer(
                        width: context.width,
                        borderColor: Colors.white,
                        radius: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Employees & Attendance',
                                    style: CustomTextStyle.textLargeSemiBold,
                                  ),
                                  RoundedContainer(
                                    width: 175.0,
                                    radius: 5.0,
                                    containerColor: AppColors.whiteColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.download,
                                            color: AppColors.greyColor,
                                            size: 15.0,
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            'Export Reports',
                                            style: CustomTextStyle
                                                .textMediumRegular
                                                .copyWith(
                                              color: AppColors.greyColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              const Divider(
                                color: AppColors.buttonGreyColor,
                                height: 10.0,
                              ),
                              const SizedBox(height: 7.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: resume.keys.map((key) {
                                      final count =
                                          resume[key]!['count'].toString();
                                      final title = resume[key]!['title'];

                                      return Row(
                                        children: [
                                          RoundedContainer(
                                            height: 100.0,
                                            width: 200.0,
                                            radius: 5.0,
                                            containerColor:
                                                AppColors.secondaryColor,
                                            borderColor:
                                                AppColors.secondaryColor,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  count,
                                                  style: CustomTextStyle
                                                      .headingBold,
                                                ),
                                                const SizedBox(height: 2.0),
                                                Text(
                                                  title,
                                                  style: CustomTextStyle
                                                      .textBigSemiBold
                                                      .copyWith(
                                                    color: AppColors.greyColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 15.0),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(width: 17.0),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RoundedContainer(
                                        width: 280.0,
                                        radius: 5.0,
                                        containerColor: AppColors.whiteColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    IconlyBold.user_2,
                                                    color: AppColors.greyColor,
                                                    size: 20.0,
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                  Text(
                                                    'All Teams',
                                                    style: CustomTextStyle
                                                        .textBigRegular
                                                        .copyWith(
                                                      color:
                                                          AppColors.greyColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: AppColors.lightGreyColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      RoundedContainer(
                                        width: 280.0,
                                        radius: 5.0,
                                        containerColor: AppColors.whiteColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    color: AppColors.greyColor,
                                                    size: 20.0,
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                  Text(
                                                    'Today - 27 Dec 2023',
                                                    style: CustomTextStyle
                                                        .textBigRegular
                                                        .copyWith(
                                                      color:
                                                          AppColors.greyColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: AppColors.lightGreyColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 30.0),
                              SizedBox(
                                height: 400,
                                child: ListView.builder(
                                  itemCount: employees.length,
                                  itemBuilder: (context, index) {
                                    EmployeeEntity employee = employees[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 300.0,
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              360),
                                                      child: CircleAvatar(
                                                        maxRadius: 30.0,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        child: Image.network(
                                                          'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=1800&t=st=1698592779~exp=1698593379~hmac=4026faeb332a0ec88f796565ae4ef0c43cf9d4962e4daa408db33ddff5d7f2e3',
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20.0),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          employee.username,
                                                          style: CustomTextStyle
                                                              .textBigSemiBold,
                                                        ),
                                                        Text(
                                                          employee.role!,
                                                          style: CustomTextStyle
                                                              .textMediumRegular
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .greyColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                  onLongPress: () {
                                                    debugPrint(employee.email);
                                                  },
                                                  child: const Icon(
                                                      Icons.email_outlined)),
                                              SizedBox(
                                                width: 200.0,
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        CupertinoIcons
                                                            .arrow_down_right,
                                                        size: 15.0,
                                                        color: AppColors
                                                            .primaryColor),
                                                    Text(
                                                      '${employee.workStart}',
                                                      style: CustomTextStyle
                                                          .textBigSemiBold
                                                          .copyWith(
                                                              color: AppColors
                                                                  .greenColor),
                                                    ),
                                                    const SizedBox(width: 30.0),
                                                    const Icon(
                                                      CupertinoIcons
                                                          .arrow_up_right,
                                                      size: 15.0,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    Text(
                                                      '${employee.workEnd}',
                                                      style: CustomTextStyle
                                                          .textBigSemiBold
                                                          .copyWith(
                                                              color: AppColors
                                                                  .redColor),
                                                    ),
                                                  ],
                                                ),
                                              )
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
                                ),
                              )
                            ],
                          ),
                        ),
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
    );
  }
}
