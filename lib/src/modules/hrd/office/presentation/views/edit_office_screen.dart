import 'package:smatrackz/core.dart';

class EditOfficeScreen extends StatefulWidget {
  const EditOfficeScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-office';

  @override
  State<EditOfficeScreen> createState() => _EditOfficeScreenState();
}

class _EditOfficeScreenState extends State<EditOfficeScreen> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final websiteController = TextEditingController();

  bool get nameChanged =>
      context.office?.officeName.trim() != nameController.text.trim();

  bool get addressChanged =>
      context.office?.address.trim() != addressController.text.trim();

  bool get websiteChanged =>
      context.office?.website.trim() != websiteController.text.trim();

  bool get nothingChanged => !nameChanged && !addressChanged && !websiteChanged;

  @override
  void initState() {
    nameController.text = context.office!.officeName.trim();
    addressController.text = context.office!.address.trim();
    websiteController.text = context.office!.website.trim();
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
    return BlocConsumer<OfficeBloc, OfficeState>(
      listener: (context, state) {
        if (state is OfficeUpdatedState) {
          CoreUtils.showSnackBar(context, 'Office updated Successfully');
          Navigator.pop(context);
        } else if (state is OfficeErrorState) {
          CoreUtils.showSnackBar(context, state.errorMessage);
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
              'Edit Office',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (nothingChanged) Navigator.pop(context);
                  final bloc = context.read<OfficeBloc>();
                  if (nameChanged) {
                    bloc.add(
                      UpdateOfficeEvent(
                        action: UpdateOfficeAction.name,
                        officeData: nameController.text.trim(),
                      ),
                    );
                  }
                  if (addressChanged) {
                    bloc.add(
                      UpdateOfficeEvent(
                        action: UpdateOfficeAction.address,
                        officeData: addressController.text.trim(),
                      ),
                    );
                  }
                  if (websiteChanged) {
                    bloc.add(
                      UpdateOfficeEvent(
                        action: UpdateOfficeAction.website,
                        officeData: websiteController.text.trim(),
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
                  child: UpdateOfficeForm(
                    nameController: nameController,
                    addressController: addressController,
                    websiteController: websiteController,
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

class UpdateOfficeForm extends StatelessWidget {
  UpdateOfficeForm({
    required this.nameController,
    required this.addressController,
    required this.websiteController,
    super.key,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController websiteController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          EditOfficeFormField(
            fieldTitle: 'OFFICE NAME',
            controller: nameController,
            hintText: context.office!.officeName,
          ),
          EditOfficeFormField(
            fieldTitle: 'ADDRESS',
            controller: addressController,
            hintText: context.office!.address,
          ),
          EditOfficeFormField(
            fieldTitle: 'WEBSITE',
            controller: websiteController,
            hintText: context.office!.website,
          ),
          LocationPicker(
            id: 'editOfficeLocation',
            latitude: context.office!.latitude,
            longitude: context.office!.longitude,
            onChanged: (latitude, longitude) {
              latitude = latitude;
              longitude = longitude;
            },
            buttonLabel: 'Change Location',
          )
        ],
      ),
    );
  }
}
