import 'package:smatrackz/core.dart';

class EditCompanyScreen extends StatefulWidget {
  const EditCompanyScreen(this.company, {Key? key}) : super(key: key);

  static const routeName = '/edit-company';

  final UserModel company;

  @override
  State<EditCompanyScreen> createState() => _EditCompanyScreenState();
}

class _EditCompanyScreenState extends State<EditCompanyScreen> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final websiteController = TextEditingController();

  bool get nameChanged =>
      widget.company.companyName.trim() != nameController.text.trim();

  bool get addressChanged =>
      widget.company.address.trim() != addressController.text.trim();

  bool get websiteChanged =>
      widget.company.website!.trim() != websiteController.text.trim();

  bool get nothingChanged => !nameChanged && !addressChanged && !websiteChanged;

  @override
  void initState() {
    nameController.text = widget.company.companyName.trim();
    addressController.text = widget.company.address.trim();
    websiteController.text = widget.company.website!.trim();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserUpdated) {
          CoreUtils.showSnackBar(context, 'Company updated Successfully');
          Navigator.pop(context);
        } else if (state is AuthError) {
          debugPrint("error: ${state.toString()}");
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(CupertinoIcons.back),
            ),
            title: const Text(
              'Edit Company',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (nothingChanged) Navigator.pop(context);
                  final bloc = context.read<AuthBloc>();
                  if (nameChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.companyName,
                        userData: nameController.text.trim(),
                      ),
                    );
                  }
                  if (addressChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.address,
                        userData: addressController.text.trim(),
                      ),
                    );
                  }
                  if (websiteChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.website,
                        userData: websiteController.text.trim(),
                      ),
                    );
                  }
                },
                child: state is AuthLoading
                    ? const Center(child: CircularProgressIndicator())
                    : StatefulBuilder(
                        builder: (_, refresh) {
                          nameController.addListener(() => refresh(() {}));
                          addressController.addListener(() => refresh(() {}));
                          websiteController.addListener(() => refresh(() {}));
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
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 24.0,
                  ),
                  child: UpdateCompanyForm(
                    nameController: nameController,
                    addressController: addressController,
                    websiteController: websiteController,
                    company: widget.company,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class UpdateCompanyForm extends StatelessWidget {
  UpdateCompanyForm({
    required this.nameController,
    required this.addressController,
    required this.websiteController,
    required this.company,
    super.key,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController websiteController;
  final UserModel company;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          EditCompanyFormField(
            fieldTitle: 'COMPANY NAME',
            controller: nameController,
            hintText: company.companyName.trim(),
          ),
          EditCompanyFormField(
            fieldTitle: 'ADDRESS',
            controller: addressController,
            hintText: company.address.trim(),
          ),
          EditCompanyFormField(
            fieldTitle: 'WEBSITE',
            controller: websiteController,
            hintText: company.website!.trim(),
          ),
        ],
      ),
    );
  }
}
