import 'package:smatrackz/core.dart';

class OtherGroupTile extends StatelessWidget {
  const OtherGroupTile(this.group, {super.key});

  final GroupEntity group;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(group.name),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(360),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.network(group.groupImageUrl!),
        ),
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
        ),
        onPressed: () {
          context.read<GroupCubit>().joinGroup(
                groupId: group.id,
                userId: context.currentUser!.companyName,
              );
        },
        child: const Text('Join'),
      ),
    );
  }
}
