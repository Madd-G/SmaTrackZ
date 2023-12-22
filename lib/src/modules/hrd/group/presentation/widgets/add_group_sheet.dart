import 'package:smatrackz/core.dart';

class AddGroupSheet extends StatefulWidget {
  const AddGroupSheet({super.key});

  @override
  State<AddGroupSheet> createState() => _AddGroupSheetState();
}

class _AddGroupSheetState extends State<AddGroupSheet> {
  final titleController = TextEditingController();
  final imageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;
  bool isFile = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    imageController.addListener(() {
      if (isFile && imageController.text.trim().isEmpty) {
        image = null;
        isFile = false;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupCubit, GroupState>(
      listener: (_, state) {
        if (state is GroupError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is AddingGroup) {
          loading = true;
          CoreUtils.showLoadingDialog(context);
        } else if (state is GroupAdded) {
          if (loading) {
            loading = false;
            Navigator.pop(context);
          }
          CoreUtils.showSnackBar(context, 'Group added successfully');
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text('Add Group', style: CustomTextStyle.headingSemiBold),
                const SizedBox(height: 15),
                TitledInputField(
                  controller: titleController,
                  title: 'Group Title',
                  hintText: 'Enter Group Title',
                  hintStyle: CustomTextStyle.textBigRegular
                      .copyWith(color: AppColors.greyColor),
                ),
                const SizedBox(height: 15),
                TitledInputField(
                  controller: imageController,
                  title: 'Group Image',
                  required: false,
                  hintText: 'Enter image URL or pick from gallery',
                  hintStyle: CustomTextStyle.textBigRegular
                      .copyWith(color: AppColors.greyColor),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final image = await CoreUtils.pickImage();
                      if (image != null) {
                        isFile = true;
                        this.image = image;
                        final imageName = image.path.split('/').last;
                        imageController.text = imageName;
                      }
                    },
                    icon: const Icon(Icons.add_photo_alternate_outlined),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            final group = GroupModel.empty().copyWith(
                              companyId: context.currentUser!.companyId,
                              name: titleController.text.trim(),
                              groupImageUrl: imageController.text.trim().isEmpty
                                  ? kDefaultAvatar
                                  : isFile
                                      ? image!.path
                                      : imageController.text.trim(),
                              members: [context.currentUser!.companyId],
                              imageIsFile: isFile,
                            );
                            context.read<GroupCubit>().addGroup(group);
                          }
                        },
                        child: RoundedContainer(
                          containerColor: AppColors.secondaryColor,
                          radius: 10.0,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Add',
                                style: CustomTextStyle.textBigSemiBold
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: RoundedContainer(
                          containerColor: AppColors.secondaryColor,
                          radius: 10.0,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Cancel',
                                style: CustomTextStyle.textBigSemiBold
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
