import 'package:smatrackz/core.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  static const routeName = '/employee-list';

  static final List<Map<String, String>> employeeList = [
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Johnson Doni',
      'role': 'Accountant',
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Budi Luis',
      'role': 'Mobile developer'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Lionel Cristiano',
      'role': 'Project Manager'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Andi Agustian Gunawan Mulawarman Hambali',
      'role': 'Backend Developer'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Deny Andreas',
      'role': 'Quality Assurance'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Johnson Doni',
      'role': 'Accountant',
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Budi Luis',
      'role': 'Mobile developer'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Lionel Cristiano',
      'role': 'Project Manager'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Andi Agustian Gunawan Mulawarman Hambali',
      'role': 'Backend Developer'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Deny Andreas',
      'role': 'Quality Assurance'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Johnson Doni',
      'role': 'Accountant',
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Budi Luis',
      'role': 'Mobile developer'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Lionel Cristiano',
      'role': 'Project Manager'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Andi Agustian Gunawan Mulawarman Hambali',
      'role': 'Backend Developer'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Deny Andreas',
      'role': 'Quality Assurance'
    },
  ];

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
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: employeeList.map((user) {
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 0.0, right: 0.0),
                        leading: Consumer<UserProvider>(
                          builder: (_, provider, __) {
                            final user = provider.user!;
                            final image = user.profilePic == null ||
                                    user.profilePic!.isEmpty
                                ? null
                                : user.profilePic;
                            return CircleAvatar(
                              radius: 20,
                              backgroundImage: image != null
                                  ? NetworkImage(image)
                                  : const AssetImage(AppMedia.user)
                                      as ImageProvider,
                            );
                          },
                        ),
                        title: Text(
                          user['name'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.textLargeSemiBold,
                        ),
                        subtitle: Text(
                          user['role'].toString(),
                          style: CustomTextStyle.textMediumRegular
                              .copyWith(color: AppColors.greyColor),
                        ),
                      );
                    }).toList(),
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
