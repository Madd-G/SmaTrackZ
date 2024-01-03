import 'package:smatrackz/core.dart';

class EmployeesAndAttendanceSection extends StatefulWidget {
  const EmployeesAndAttendanceSection({
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
  State<EmployeesAndAttendanceSection> createState() =>
      _EmployeesAndAttendanceSectionState();
}

class _EmployeesAndAttendanceSectionState
    extends State<EmployeesAndAttendanceSection> {
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
  String selectedRole = 'All Teams';
  static final List<Map<String, String>> roleList = [
    {
      "label": "Project Manager",
      "value": "Project Manager",
    },
    {
      "label": "Accountant",
      "value": "Accountant",
    },
    {
      "label": "Mobile Developer",
      "value": "Mobile Developer",
    },
    {
      "label": "Backend Developer",
      "value": "Backend Developer",
    },
    {
      "label": "Quality Assurance",
      "value": "Quality Assurance",
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    debugPrint('build');
    return RoundedContainer(
      boxConstraints: const BoxConstraints(maxWidth: 1200),
      width: MediaQuery.of(context).size.width,
      borderColor: Colors.white,
      radius: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text(
            //       'Employees & Attendance',
            //       style: CustomTextStyle.textLargeSemiBold,
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         AddEmployeeButton(
            //           nameController: widget.nameController,
            //           emailController: widget.emailController,
            //           addCompanyFormKey: widget.addCompanyFormKey,
            //           company: widget.company,
            //         ),
            //         const SizedBox(width: 10.0),
            //         RoundedContainer(
            //           width: 160.0,
            //           radius: 5.0,
            //           containerColor: AppColors.whiteColor,
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 const Icon(
            //                   Icons.calendar_month_outlined,
            //                   color: AppColors.greyColor,
            //                   size: 15.0,
            //                 ),
            //                 const SizedBox(width: 5.0),
            //                 Text(
            //                   'Holiday Calendar',
            //                   style: CustomTextStyle.textMediumRegular.copyWith(
            //                     color: AppColors.greyColor,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         const SizedBox(width: 10.0),
            //         RoundedContainer(
            //           width: 160.0,
            //           radius: 5.0,
            //           containerColor: AppColors.whiteColor,
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 const Icon(
            //                   Icons.area_chart,
            //                   color: AppColors.greyColor,
            //                   size: 15.0,
            //                 ),
            //                 const SizedBox(width: 5.0),
            //                 Text(
            //                   'Team Reports',
            //                   style: CustomTextStyle.textMediumRegular.copyWith(
            //                     color: AppColors.greyColor,
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //         const SizedBox(width: 10.0),
            //         RoundedContainer(
            //           width: 175.0,
            //           radius: 5.0,
            //           containerColor: AppColors.whiteColor,
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 const Icon(
            //                   Icons.download,
            //                   color: AppColors.greyColor,
            //                   size: 15.0,
            //                 ),
            //                 const SizedBox(width: 5.0),
            //                 Text(
            //                   'Export Reports',
            //                   style: CustomTextStyle.textMediumRegular.copyWith(
            //                     color: AppColors.greyColor,
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            const SizedBox(height: 10.0),
            const Divider(
              color: AppColors.buttonGreyColor,
              height: 10.0,
            ),
            const SizedBox(height: 7.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 15.0,
                    runSpacing: 15.0,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: resume.keys.map((key) {
                      final count = resume[key]!['count'].toString();
                      final title = resume[key]!['title'];
                      return RoundedContainer(
                        height: (size.width > 1245) ? 100.0 : 50.0,
                        width: (size.width > 1320) ? 160 : (size.width > 1300) ? size.width * 0.12 : 200,
                        radius: 5.0,
                        containerColor: AppColors.secondaryColor,
                        borderColor: AppColors.secondaryColor,
                        child: (size.width > 1320)
                            ? Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    count,
                                    style: CustomTextStyle.headingBold,
                                  ),
                                  const SizedBox(height: 2.0),
                                  Text(
                                    title,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: CustomTextStyle.textBigSemiBold
                                        .copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ],
                              )
                            : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        count,
                                        style: CustomTextStyle.headingBold.copyWith(fontSize: 22.0),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: Text(
                                          title,
                                          maxLines: 3,
                                          textAlign: TextAlign.start,
                                          style: CustomTextStyle.textBigSemiBold.copyWith(fontSize: 12.0)
                                              .copyWith(
                                            color: AppColors.greyColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 17.0),
                if (size.width > 825)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedContainer(
                      width: 240.0,
                      radius: 5.0,
                      containerColor: AppColors.whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 250.0,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              padding: EdgeInsets.zero,
                              isDense: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.lightGreyColor,
                              ),
                              items: roleList.map((val) {
                                return DropdownMenuItem<String>(
                                  value: val['value'],
                                  child: Text(val['value']!),
                                );
                              }).toList(),
                              hint: Row(
                                children: <Widget>[
                                  const Icon(
                                    IconlyBold.user_2,
                                    color: AppColors.greyColor,
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(
                                    selectedRole,
                                    style:
                                        CustomTextStyle.textBigRegular.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                              onChanged: (String? val) {
                                setState(
                                  () {
                                    selectedRole = val!;
                                  },
                                );
                                context.read<EmployeeBloc>().add(
                                      GetFilteredEmployeeEvent(
                                        role: selectedRole,
                                      ),
                                    );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    RoundedContainer(
                      width: 240.0,
                      radius: 5.0,
                      containerColor: AppColors.whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  color: AppColors.greyColor,
                                  size: 20.0,
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  '27 Dec 2023',
                                  style:
                                      CustomTextStyle.textBigRegular.copyWith(
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
                ),


              ],
            ),
            if (size.width < 825)
            Column(
              children: [
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedContainer(
                      width: 220.0,
                      radius: 5.0,
                      containerColor: AppColors.whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 250.0,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              padding: EdgeInsets.zero,
                              isDense: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.lightGreyColor,
                              ),
                              items: roleList.map((val) {
                                return DropdownMenuItem<String>(
                                  value: val['value'],
                                  child: Text(val['value']!),
                                );
                              }).toList(),
                              hint: Row(
                                children: <Widget>[
                                  const Icon(
                                    IconlyBold.user_2,
                                    color: AppColors.greyColor,
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(
                                    selectedRole,
                                    style:
                                    CustomTextStyle.textBigRegular.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                              onChanged: (String? val) {
                                setState(
                                      () {
                                    selectedRole = val!;
                                  },
                                );
                                context.read<EmployeeBloc>().add(
                                  GetFilteredEmployeeEvent(
                                    role: selectedRole,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    RoundedContainer(
                      width: 210.0,
                      radius: 5.0,
                      containerColor: AppColors.whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  color: AppColors.greyColor,
                                  size: 20.0,
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  '27 Dec 2023',
                                  style:
                                  CustomTextStyle.textBigRegular.copyWith(
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
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            BlocConsumer<EmployeeBloc, EmployeeState>(
              listener: (context, state) {
                if (state is EmployeeErrorState) {
                  CoreUtils.showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is EmployeeLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is EmployeeErrorState) {
                  return Center(child: Text(state.message));
                } else if (state is EmployeeLoadedState) {
                  final employees = state.employees
                      .where((element) =>
                          element.companyId == widget.company.companyId)
                      .toList()
                    ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

                  if (employees.isEmpty) {
                    return const NotFoundText('No employee found ');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
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
                                SizedBox(
                                  width: (Responsive.isMobile(context)) ? 200.0 : 300.0,
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(360),
                                        child: CircleAvatar(
                                          maxRadius: 30.0,
                                          backgroundColor: Colors.transparent,
                                          child: Image.network(
                                            'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=1800&t=st=1698592779~exp=1698593379~hmac=4026faeb332a0ec88f796565ae4ef0c43cf9d4962e4daa408db33ddff5d7f2e3',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            employee.username,
                                            style:
                                                CustomTextStyle.textBigSemiBold,
                                          ),
                                          Text(
                                            employee.role ?? '',
                                            style: CustomTextStyle
                                                .textMediumRegular
                                                .copyWith(
                                                    color: AppColors.greyColor),
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
                                    Icons.email_outlined,
                                  ),
                                ),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.arrow_down_right,
                                        size: 15.0,
                                        color: AppColors.primaryColor,
                                      ),
                                      Text(
                                        '${employee.workStart}',
                                        style: CustomTextStyle.textBigSemiBold
                                            .copyWith(
                                          color: AppColors.greenColor,
                                        ),
                                      ),
                                      const SizedBox(width: 30.0),
                                      const Icon(
                                        CupertinoIcons.arrow_up_right,
                                        size: 15.0,
                                        color: AppColors.primaryColor,
                                      ),
                                      Text(
                                        '${employee.workEnd}',
                                        style: CustomTextStyle.textBigSemiBold
                                            .copyWith(
                                          color: AppColors.redColor,
                                        ),
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
                } else if (state is FilteredEmployeeLoadedState) {
                  final employees = state.employees
                      .where((element) =>
                          element.companyId == widget.company.companyId)
                      .where((element) => element.role == selectedRole)
                      .toList()
                    ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

                  if (employees.isEmpty) {
                    return const NotFoundText('No employee found ');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
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
                                SizedBox(
                                  width: 300.0,
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(360),
                                        child: CircleAvatar(
                                          maxRadius: 30.0,
                                          backgroundColor: Colors.transparent,
                                          child: Image.network(
                                            'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=1800&t=st=1698592779~exp=1698593379~hmac=4026faeb332a0ec88f796565ae4ef0c43cf9d4962e4daa408db33ddff5d7f2e3',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            employee.username,
                                            style:
                                                CustomTextStyle.textBigSemiBold,
                                          ),
                                          Text(
                                            employee.role ?? '',
                                            style: CustomTextStyle
                                                .textMediumRegular
                                                .copyWith(
                                                    color: AppColors.greyColor),
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
                                    Icons.email_outlined,
                                  ),
                                ),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.arrow_down_right,
                                        size: 15.0,
                                        color: AppColors.primaryColor,
                                      ),
                                      Text(
                                        '${employee.workStart}',
                                        style: CustomTextStyle.textBigSemiBold
                                            .copyWith(
                                          color: AppColors.greenColor,
                                        ),
                                      ),
                                      const SizedBox(width: 30.0),
                                      const Icon(
                                        CupertinoIcons.arrow_up_right,
                                        size: 15.0,
                                        color: AppColors.primaryColor,
                                      ),
                                      Text(
                                        '${employee.workEnd}',
                                        style: CustomTextStyle.textBigSemiBold
                                            .copyWith(
                                          color: AppColors.redColor,
                                        ),
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
    );
  }
}

class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  const CustomPopupMenuItem({
    Key? key,
    required T value,
    required Widget child,
    double height = 50.0,
  }) : super(key: key, value: value, child: child, height: height);
}
