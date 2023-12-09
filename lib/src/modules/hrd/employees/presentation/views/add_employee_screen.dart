import 'package:smatrackz/core.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  static const routeName = '/add-employee';

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
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  String? position;

  @override
  void dispose() {
    companyNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 16.0, right: 16.0, bottom: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    const Text('Add Employee',
                        style: CustomTextStyle.headingSemiBold),
                    const SizedBox(height: 25.0),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Full Name',
                              style: CustomTextStyle.textRegular),
                          const SizedBox(height: 10.0),
                          CustomTextField(
                            controller: companyNameController,
                            // hintText: 'Full Name',
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 15.0),
                          const Text('Email',
                              style: CustomTextStyle.textRegular),
                          const SizedBox(height: 10.0),
                          CustomTextField(
                            controller: emailController,
                            // hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          QDropdownField(
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
                  ],
                ),
                Consumer<UserProvider>(builder: (_, provider, __) {
                  final company = provider.user!;
                  return GestureDetector(
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (formKey.currentState!.validate()) {
                        // TODO: add office
                        context.read<AddEmployeeBloc>().add(
                              AddEmployeeEvent(
                                email: emailController.text.trim(),
                                password: emailController.text.trim(),
                                name: company.companyName,
                                companyId: company.companyId,
                              ),
                            );
                        Navigator.pushReplacementNamed(
                            context, EmployeeListScreen.routeName);
                      }
                    },
                    child: RoundedContainer(
                      radius: 10.0,
                      containerColor: AppColors.primaryColor,
                      width: context.width,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(child: Text('Save')),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
