import 'package:smatrackz/core.dart';

class AbsenceCard extends StatelessWidget {
  const AbsenceCard({super.key});

  static final List<Map<String, String>> absenceList = [
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Johnson Doni',
      'status': 'leave',
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Budi Luis',
      'status': 'sick'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Lionel Cristiano',
      'status': 'sick'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Andi Agustian Gunawan Mulawarman',
      'status': 'no permission'
    },
    {
      'profileImage': 'assets/images/user.png',
      'name': 'Deny Andreas',
      'status': 'no permission'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Absence today',
                  style: CustomTextStyle.textLargeSemiBold
                      .copyWith(fontSize: 18.0),
                ),
                Container(
                    decoration: const BoxDecoration(
                        color: AppColors.redSecondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                      child: Text(
                        '5',
                        style: CustomTextStyle.textBigBold,
                      ),
                    )),
              ],
            ),
            const Divider(
              color: AppColors.blackColor,
              thickness: 0.7,
              height: 30.0,
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: absenceList.map((user) {
                return ListTile(
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                  leading: Consumer<UserProvider>(
                    builder: (_, provider, __) {
                      final user = provider.user!;
                      final image =
                          user.profilePic == null || user.profilePic!.isEmpty
                              ? null
                              : user.profilePic;
                      return CircleAvatar(
                        radius: 20,
                        backgroundImage: image != null
                            ? NetworkImage(image)
                            : const AssetImage(AppMedia.user) as ImageProvider,
                      );
                    },
                  ),
                  title: Text(
                    user['name'].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.textLargeSemiBold,
                  ),
                  trailing: user['status'].toString().toStatusIcon(),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
