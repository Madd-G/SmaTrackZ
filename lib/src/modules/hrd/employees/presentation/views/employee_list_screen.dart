import 'package:smatrackz/core.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  static const routeName = '/employee-list';

  // static final List<Map<String, String>> employeeList = [
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Johnson Doni',
  //     'role': 'Accountant',
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Budi Luis',
  //     'role': 'Mobile developer'
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Lionel Cristiano',
  //     'role': 'Project Manager'
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Andi Agustian Gunawan Mulawarman Hambali',
  //     'role': 'Backend Developer'
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Deny Andreas',
  //     'role': 'Quality Assurance'
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Johnson Doni',
  //     'role': 'Accountant',
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Budi Luis',
  //     'role': 'Mobile developer'
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Lionel Cristiano',
  //     'role': 'Project Manager'
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Andi Agustian Gunawan Mulawarman Hambali',
  //     'role': 'Backend Developer'
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Deny Andreas',
  //     'role': 'Quality Assurance'
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Johnson Doni',
  //     'role': 'Accountant',
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Budi Luis',
  //     'role': 'Mobile developer'
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Lionel Cristiano',
  //     'role': 'Project Manager'
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Andi Agustian Gunawan Mulawarman Hambali',
  //     'role': 'Backend Developer'
  //   },
  //   {
  //     'profileImage': 'assets/images/user.png',
  //     'name': 'Deny Andreas',
  //     'role': 'Quality Assurance'
  //   },
  // ];

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  void getEmployee() {
    context.read<EmployeeBloc>().add(GetEmployeeEvent());
  }

  @override
  void initState() {
    getEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 16.0, right: 16.0, bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  const Text('List Employee',
                      style: CustomTextStyle.headingSemiBold),
                  const SizedBox(height: 25.0),
                  BlocConsumer<EmployeeBloc, EmployeeState>(
                    listener: (context, state) {
                      if (state is EmployeeErrorState) {
                        CoreUtils.showSnackBar(context, state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is EmployeeLoadingState) {
                        return const LoadingView();
                      } else if ((state is EmployeeLoadedState &&
                              state.employees.isEmpty) ||
                          state is EmployeeErrorState) {
                        return const NotFoundText('No employee found ');
                      } else if (state is EmployeeLoadedState) {
                        final employees = state.employees
                          ..sort(
                            (a, b) => b.createdAt!.compareTo(a.createdAt!),
                          );
                        return ListView(
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: employees.map((employee) {
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: employee.profilePicture != ''
                                    ? NetworkImage(employee.profilePicture!)
                                    : const AssetImage(AppMedia.user)
                                        as ImageProvider,
                              ),
                              title: Text(
                                employee.username.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyle.textLargeSemiBold,
                              ),
                              subtitle: Text(
                                employee.role.toString(),
                                style: CustomTextStyle.textMediumRegular
                                    .copyWith(color: AppColors.greyColor),
                              ),
                            );
                          }).toList(),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddEmployeeScreen.routeName);
        },
      ),
    );
  }
}
