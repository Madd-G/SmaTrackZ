import 'package:smatrackz/core.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({required this.group, super.key});

  final GroupEntity group;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: const NestedBackButton(),
      titleSpacing: 0,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(group.groupImageUrl!),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(width: 7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group.name,
                style: CustomTextStyle.headingSemiBold,
              ),
              Text(
                '${group.members.length} members',
                style: CustomTextStyle.textMedium,
              )
            ],
          ),
        ],
      ),
      foregroundColor: AppColors.backgroundColor,
      flexibleSpace: Container(
        color: AppColors.primaryColor,
      ),
      actions: [
        PopupMenuButton(
          offset: const Offset(0, 50),
          surfaceTintColor: Colors.white,
          icon: const Icon(Icons.more_horiz),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          itemBuilder: (_) => [
            PopupMenuItem<void>(
              child: const PopupItem(
                title: 'Exit Group',
                icon: Icon(
                  Icons.exit_to_app,
                  color: AppColors.redColor,
                ),
              ),
              onTap: () async {
                final groupCubit = context.read<GroupCubit>();
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      title: const Text('Exit Group'),
                      content: const Text(
                        'Are you sure you want to leave the group?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text('Exit group'),
                        ),
                      ],
                    );
                  },
                );
                if (result ?? false) {
                  await groupCubit.leaveGroup(
                    groupId: group.id,
                    userId: sl<FirebaseAuth>().currentUser!.uid,
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
