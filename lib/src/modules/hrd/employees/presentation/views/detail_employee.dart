import 'package:smatrackz/core.dart';

class DetailEmployeeScreen extends StatefulWidget {
  const DetailEmployeeScreen(this.employee, {super.key});

  static const routeName = '/employee-detail';

  final EmployeeModel employee;

  @override
  State<DetailEmployeeScreen> createState() => _DetailEmployeeScreenState();
}

class _DetailEmployeeScreenState extends State<DetailEmployeeScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final roleController = TextEditingController();

  bool get usernameChanged =>
      widget.employee.username.trim() != usernameController.text.trim();

  bool get emailChanged =>
      widget.employee.email.trim() != emailController.text.trim();

  bool get roleChanged =>
      widget.employee.role!.trim() != roleController.text.trim();

  bool get nothingChanged => !usernameChanged && !emailChanged && !roleChanged;

  @override
  void initState() {
    usernameController.text = widget.employee.username.trim();
    emailController.text = widget.employee.email.trim();
    roleController.text = widget.employee.role!.trim();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeUpdatedState) {
          CoreUtils.showSnackBar(context, 'Employee data updated Successfully');
          Navigator.pop(context);
        } else if (state is EmployeeErrorState) {
          debugPrint("error: ${state.toString()}");
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  if (nothingChanged) Navigator.pop(context);
                  final bloc = context.read<EmployeeBloc>();
                  if (usernameChanged) {
                    bloc.add(
                      UpdateEmployeeEvent(
                        action: UpdateEmployeeAction.username,
                        uid: widget.employee.uid!,
                        employeeData: usernameController.text.trim(),
                      ),
                    );
                  }
                  if (emailChanged) {
                    bloc.add(
                      UpdateEmployeeEvent(
                        action: UpdateEmployeeAction.email,
                        uid: widget.employee.uid!,
                        employeeData: emailController.text.trim(),
                      ),
                    );
                  }
                  if (roleChanged) {
                    bloc.add(
                      UpdateEmployeeEvent(
                        action: UpdateEmployeeAction.role,
                        uid: widget.employee.uid!,
                        employeeData: roleController.text.trim(),
                      ),
                    );
                  }
                  bloc.add(
                    UpdateEmployeeEvent(
                      action: UpdateEmployeeAction.uid,
                      uid: widget.employee.uid!,
                      employeeData: widget.employee.uid,
                    ),
                  );
                },
                child: state is AuthLoading
                    ? const Center(child: CircularProgressIndicator())
                    : StatefulBuilder(
                        builder: (_, refresh) {
                          usernameController.addListener(() => refresh(() {}));
                          emailController.addListener(() => refresh(() {}));
                          roleController.addListener(() => refresh(() {}));
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: nothingChanged
                                    ? Colors.grey
                                    : Colors.blueAccent,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          body: BackgroundImage(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: widget.employee.profilePicture !=
                                  null
                              ? NetworkImage(widget.employee.profilePicture!)
                              : const AssetImage(AppMedia.user)
                                  as ImageProvider,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      CustomTextField(
                        controller: usernameController,
                        // hintText: widget.employee.username,
                        inputBorder: InputBorder.none,
                      ),
                      CustomTextField(
                        controller: emailController,
                        // hintText: widget.employee.email,
                        inputBorder: InputBorder.none,
                      ),
                      CustomTextField(
                        controller: roleController,
                        // hintText: widget.employee.role,
                        inputBorder: InputBorder.none,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Wrap(
                          direction: Axis.horizontal,
                          runSpacing: 10.0,
                          spacing: 10.0,
                          children: [
                            ...widget.employee.groups!.map(
                              (e) => Container(
                                decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      CustomTextField(
                        hintText: widget.employee.createdAt,
                        inputBorder: InputBorder.none,
                        readOnly: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
