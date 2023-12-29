import 'package:smatrackz/core.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  static const routeName = '/company';

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  final Map<String, Map<String, dynamic>> resume = {
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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  String? position;

  @override
  void initState() {
    context.read<EmployeeBloc>().add(GetEmployeeEvent());
    super.initState();
  }

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
            child: Consumer<UserProvider>(
              builder: (_, provider, __) {
                final company = provider.user!;
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                        decorationColor: AppColors.primaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      company.website ?? '',
                                      style: CustomTextStyle.textBigRegular,
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      '${company.workStart} - ${company.workEnd}',
                                      style: CustomTextStyle.textBigRegular,
                                    ),
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
                                            style: TextStyle(
                                                color: AppColors.whiteColor),
                                          )),
                                        ),
                                        const SizedBox(width: 4.0),
                                        Container(
                                          constraints: const BoxConstraints(
                                              minWidth: 40.0, minHeight: 35.0),
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
                                              minWidth: 40.0, minHeight: 35.0),
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
                                              minWidth: 40.0, minHeight: 35.0),
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
                                              minWidth: 40.0, minHeight: 35.0),
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
                                              minWidth: 40.0, minHeight: 35.0),
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
                                              minWidth: 40.0, minHeight: 35.0),
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
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext _) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  AppColors.whiteColor,
                                              surfaceTintColor:
                                                  Colors.transparent,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0))),
                                              title: const Text(
                                                'Add Employee',
                                                style: CustomTextStyle
                                                    .textLargeSemiBold,
                                              ),
                                              content: SizedBox(
                                                height: 500.0,
                                                child: Form(
                                                  key: formKey,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                          height: 10.0),
                                                      Text(
                                                        'Name',
                                                        style: CustomTextStyle
                                                            .textBigRegular
                                                            .copyWith(
                                                                color: AppColors
                                                                    .greyColor),
                                                      ),
                                                      const SizedBox(
                                                          height: 5.0),
                                                      SizedBox(
                                                        width: 700,
                                                        child: CustomTextField(
                                                          controller:
                                                              nameController,
                                                          hintText:
                                                              'Enter Your Username',
                                                          keyboardType:
                                                              TextInputType
                                                                  .name,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 15.0),
                                                      Text(
                                                        'Email',
                                                        style: CustomTextStyle
                                                            .textBigRegular
                                                            .copyWith(
                                                                color: AppColors
                                                                    .greyColor),
                                                      ),
                                                      const SizedBox(
                                                          height: 5.0),
                                                      SizedBox(
                                                        width: 700,
                                                        child: CustomTextField(
                                                          controller:
                                                              emailController,
                                                          hintText:
                                                              'Enter Your Email',
                                                          keyboardType:
                                                              TextInputType
                                                                  .emailAddress,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 15.0),
                                                      Dropdown(
                                                        label: "Position",
                                                        validator:
                                                            Validator.required,
                                                        items: AddEmployeeScreen
                                                            .roleList,
                                                        onChanged:
                                                            (value, label) {
                                                          position = value;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                GestureDetector(
                                                  onTap: () async {},
                                                  child: RoundedContainer(
                                                    radius: 10.0,
                                                    containerColor:
                                                        AppColors.primaryColor,
                                                    child: TextButton(
                                                      child: Text(
                                                        'Add',
                                                        style: CustomTextStyle
                                                            .textRegular
                                                            .copyWith(
                                                                color: AppColors
                                                                    .whiteColor),
                                                      ),
                                                      onPressed: () {
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          context
                                                              .read<
                                                                  EmployeeBloc>()
                                                              .add(
                                                                AddEmployeeEvent(
                                                                  email:
                                                                      emailController
                                                                          .text
                                                                          .trim(),
                                                                  password:
                                                                      emailController
                                                                          .text
                                                                          .trim(),
                                                                  employee:
                                                                      EmployeeModel(
                                                                    // uid: 'uid',
                                                                    email: emailController
                                                                        .text
                                                                        .trim(),
                                                                    username:
                                                                        nameController
                                                                            .text
                                                                            .trim(),
                                                                    role:
                                                                        position!,
                                                                    createdAt: DateTime
                                                                            .now()
                                                                        .toString(),
                                                                  ),
                                                                  companyId: company
                                                                      .companyId,
                                                                ),
                                                              );
                                                        }
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: RoundedContainer(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          borderColor: AppColors.secondaryColor,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                count,
                                                style:
                                                    CustomTextStyle.headingBold,
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
                                                    color: AppColors.greyColor,
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
                                                  Icons.calendar_month_outlined,
                                                  color: AppColors.greyColor,
                                                  size: 20.0,
                                                ),
                                                const SizedBox(width: 5.0),
                                                Text(
                                                  'Today - 27 Dec 2023',
                                                  style: CustomTextStyle
                                                      .textBigRegular
                                                      .copyWith(
                                                    color: AppColors.greyColor,
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
                            BlocConsumer<EmployeeBloc, EmployeeState>(
                              listener: (context, state) {
                                if (state is EmployeeErrorState) {
                                  CoreUtils.showSnackBar(
                                      context, state.message);
                                }
                              },
                              builder: (context, state) {
                                print('employee state: $state');
                                if (state is EmployeeLoadingState) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is EmployeeErrorState) {
                                  return Center(child: Text(state.message));
                                } else if (state is EmployeeLoadedState) {
                                  final employees = state.employees
                                      .where((element) =>
                                          element.companyId ==
                                          company.companyId)
                                      .toList()
                                    ..sort((a, b) =>
                                        b.createdAt!.compareTo(a.createdAt!));

                                  if (employees.isEmpty) {
                                    return const NotFoundText(
                                        'No employee found ');
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    reverse: true,
                                    itemCount: employees.length,
                                    itemBuilder: (context, index) {
                                      EmployeeEntity employee =
                                          employees[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 300.0,
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(360),
                                                        child: CircleAvatar(
                                                          maxRadius: 30.0,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          child: Image.network(
                                                            'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=1800&t=st=1698592779~exp=1698593379~hmac=4026faeb332a0ec88f796565ae4ef0c43cf9d4962e4daa408db33ddff5d7f2e3',
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 20.0),
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
                                                            employee.role ?? '',
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
                                                      debugPrint(
                                                          employee.email);
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
                                                      const SizedBox(
                                                          width: 30.0),
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
                                  );
                                }
                                return const SizedBox.shrink();
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
      ),
    );
  }
}
