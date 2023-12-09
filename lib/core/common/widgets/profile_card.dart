import 'package:smatrackz/core.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<UserProvider>(
          builder: (_, provider, __) {
            final user = provider.user!;
            print('user: $user');

            final image =
                user.profilePicture == null || user.profilePicture!.isEmpty
                    ? null
                    : user.profilePicture;
            return Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: image != null
                      ? NetworkImage(image)
                      : const AssetImage(AppMedia.user) as ImageProvider,
                ),
                const SizedBox(width: 10.0),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.companyName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 17.0),
                      ),
                      const SizedBox(height: 5.0),
                      const RoundedContainer(
                        containerColor: AppColors.secondaryColor,
                        borderColor: AppColors.secondaryColor,
                        radius: 10.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          child: Text(
                            'Mobile Developer',
                            // 'Head Human Resource Development',
                            // 'Data Analytics',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
