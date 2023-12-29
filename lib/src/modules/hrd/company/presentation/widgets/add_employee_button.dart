import 'package:smatrackz/core.dart';

class AddEmployeeButton extends StatefulWidget {
  const AddEmployeeButton({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.addCompanyFormKey,
    required this.company,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final GlobalKey<FormState> addCompanyFormKey;
  final UserModel company;

  @override
  State<AddEmployeeButton> createState() => _AddEmployeeButtonState();
}

class _AddEmployeeButtonState extends State<AddEmployeeButton> {
  String? position;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              backgroundColor: AppColors.whiteColor,
              surfaceTintColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    5.0,
                  ),
                ),
              ),
              title: const Text(
                'Add Employee',
                style: CustomTextStyle.textLargeSemiBold,
              ),
              content: SizedBox(
                height: 500.0,
                child: Form(
                  key: widget.addCompanyFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      Text(
                        'Name',
                        style: CustomTextStyle.textBigRegular
                            .copyWith(color: AppColors.greyColor),
                      ),
                      const SizedBox(height: 5.0),
                      SizedBox(
                        width: 700,
                        child: CustomTextField(
                          controller: widget.nameController,
                          hintText: 'Enter Your Username',
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        'Email',
                        style: CustomTextStyle.textBigRegular
                            .copyWith(color: AppColors.greyColor),
                      ),
                      const SizedBox(height: 5.0),
                      SizedBox(
                        width: 700,
                        child: CustomTextField(
                          controller: widget.emailController,
                          hintText: 'Enter Your Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Dropdown(
                        label: "Position",
                        validator: Validator.required,
                        items: AddEmployeeScreen.roleList,
                        onChanged: (value, label) {
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
                    Navigator.of(dialogContext).pop();
                  },
                ),
                GestureDetector(
                  onTap: () async {},
                  child: RoundedContainer(
                    radius: 10.0,
                    containerColor: AppColors.primaryColor,
                    child: TextButton(
                      child: Text(
                        'Add',
                        style: CustomTextStyle.textRegular
                            .copyWith(color: AppColors.whiteColor),
                      ),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (widget.addCompanyFormKey.currentState!.validate()) {
                          context.read<EmployeeBloc>().add(
                                AddEmployeeEvent(
                                  email: widget.emailController.text.trim(),
                                  password: widget.emailController.text.trim(),
                                  employee: EmployeeModel(
                                    // uid: 'uid',
                                    email: widget.emailController.text.trim(),
                                    username: widget.nameController.text.trim(),
                                    role: position,
                                    // role: 'Ada',
                                    createdAt: DateTime.now().toString(),
                                  ),
                                  companyId: widget.company.companyId,
                                ),
                              );
                        }
                        Navigator.of(dialogContext).pop();
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: AppColors.whiteColor,
                size: 15.0,
              ),
              const SizedBox(width: 5.0),
              Text(
                'Add Employee',
                style: CustomTextStyle.textMediumRegular.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
