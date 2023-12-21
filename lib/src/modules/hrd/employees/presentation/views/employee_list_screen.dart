import 'package:smatrackz/core.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  static const routeName = '/employee-list';

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  void getEmployee() {
    context.read<EmployeeBloc>().add(GetEmployeeEvent());
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    getEmployee();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Employees',
          style: CustomTextStyle.headingSemiBold,
        ),
      ),
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 16.0, right: 16.0, bottom: 24.0),
              child: BlocConsumer<EmployeeBloc, EmployeeState>(
                listener: (context, state) {
                  if (state is EmployeeErrorState) {
                    CoreUtils.showSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is EmployeeLoadingState) {
                    return const Center(child: CircularProgressIndicator());
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
                          onTap: () async {
                            await Navigator.of(context)
                                .pushNamed(DetailEmployeeScreen.routeName,
                                    arguments: employee)
                                .then((value) => context
                                    .read<EmployeeBloc>()
                                    .add(GetEmployeeEvent()));
                          },
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
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context)
              .pushNamed(AddEmployeeScreen.routeName)
              .then((value) =>
                  context.read<EmployeeBloc>().add(GetEmployeeEvent()));
        },
      ),
    );
  }
}
