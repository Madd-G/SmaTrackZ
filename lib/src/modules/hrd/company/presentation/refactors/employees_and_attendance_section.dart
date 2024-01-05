import 'package:smatrackz/core.dart';

class EmployeesAndAttendanceSection extends StatefulWidget {
  const EmployeesAndAttendanceSection({super.key, required this.company});

  final UserModel company;

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
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Employees & Attendance',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.textLargeSemiBold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const AddEmployeeButton(),
                    SizedBox(width: Responsive.isMobile(context) ? 5.0 : 10.0),
                    const HolidayButton(),
                    SizedBox(width: Responsive.isMobile(context) ? 5.0 : 10.0),
                    const TeamReportButton(),
                    SizedBox(width: Responsive.isMobile(context) ? 5.0 : 10.0),
                    const ExportReportButton(),
                  ],
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: Responsive.isMobile(context)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: resume.keys.map((key) {
                      final count = resume[key]!['count'].toString();
                      final title = resume[key]!['title'];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: RoundedContainer(
                          height: (Responsive.isDesktop(context)) ? 100.0 : 80,
                          width: Responsive.isMobile(context)
                              ? size.width * 0.19
                              : (size.width > 1300)
                                  ? 160
                                  : (size.width < 1000 && size.width > 850)
                                      ? size.width * 0.12
                                      : (size.width < 850)
                                          ? size.width * 0.181
                                          : size.width * 0.11,
                          radius: 5.0,
                          containerColor: AppColors.secondaryColor,
                          borderColor: AppColors.secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  count,
                                  style: (Responsive.isDesktop(context))
                                      ? CustomTextStyle.headingBold
                                      : CustomTextStyle.textLargeBold
                                          .copyWith(fontSize: 18.0),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  title,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: (Responsive.isDesktop(context))
                                      ? CustomTextStyle.textBigSemiBold
                                          .copyWith(
                                          color: AppColors.greyColor,
                                        )
                                      : CustomTextStyle.textSmallSemiBold
                                          .copyWith(
                                          color: AppColors.greyColor,
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
                // const SizedBox(width: 17.0),
                if (size.width > 850)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundedContainer(
                        height: Responsive.isDesktop(context) ? 50.0 : 40.0,
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
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.lightGreyColor,
                                  size: Responsive.isDesktop(context)
                                      ? 20.0
                                      : 15.0,
                                ),
                                items: roleList.map((val) {
                                  return DropdownMenuItem<String>(
                                    value: val['value'],
                                    child: Text(val['value']!),
                                  );
                                }).toList(),
                                hint: Row(
                                  children: <Widget>[
                                    Icon(
                                      IconlyBold.user_2,
                                      color: AppColors.greyColor,
                                      size: Responsive.isDesktop(context)
                                          ? 20.0
                                          : 15.0,
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      selectedRole,
                                      style: Responsive.isDesktop(context)
                                          ? CustomTextStyle.textBigRegular
                                              .copyWith(
                                              color: AppColors.greyColor,
                                            )
                                          : CustomTextStyle.textRegular
                                              .copyWith(
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
                      SizedBox(
                          height: Responsive.isDesktop(context) ? 10.0 : 5.0),
                      FilterByDateButton(
                        height: Responsive.isDesktop(context) ? 50.0 : 40.0,
                        width: 240.0,
                        iconSize: Responsive.isDesktop(context) ? 20.0 : 15.0,
                      ),
                    ],
                  ),
              ],
            ),
            if (size.width < 850)
              Column(
                children: [
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RoundedContainer(
                          height: 45.0,
                          radius: 5.0,
                          containerColor: AppColors.whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                padding: EdgeInsets.zero,
                                isDense: true,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.lightGreyColor,
                                  size: 15.0,
                                ),
                                items: roleList.map((val) {
                                  return DropdownMenuItem<String>(
                                    value: val['value'],
                                    child: Text(val['value']!,
                                        style: (Responsive.isMobile(context))
                                            ? CustomTextStyle.textRegular
                                            : CustomTextStyle.textBigRegular),
                                  );
                                }).toList(),
                                hint: Row(
                                  children: <Widget>[
                                    const Icon(
                                      IconlyBold.user_2,
                                      color: AppColors.greyColor,
                                      size: 15.0,
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      selectedRole,
                                      style: Responsive.isDesktop(context)
                                          ? CustomTextStyle.textBigRegular
                                              .copyWith(
                                              color: AppColors.greyColor,
                                            )
                                          : CustomTextStyle.textRegular
                                              .copyWith(
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
                      SizedBox(
                          width: Responsive.isMobile(context) ? 5.0 : 40.0),
                      const Expanded(
                          child: FilterByDateButton(
                        height: 45.0,
                        iconSize: 15.0,
                      )),
                    ],
                  ),
                ],
              ),
            SizedBox(height: Responsive.isMobile(context) ? 10.0 : 20.0),
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
                  return EmployeeAttendanceList(employees: employees);
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
                  return EmployeeAttendanceList(employees: employees);
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
