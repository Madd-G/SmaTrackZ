import 'package:smatrackz/core.dart';

class YourGroupTile extends StatelessWidget {
  const YourGroupTile(this.group, {super.key});

  final GroupEntity group;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(group.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(group.groupImageUrl!),
        backgroundColor: Colors.transparent,
      ),
      subtitle: group.lastMessage != null
          ? RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: '~ ${group.lastMessageSenderName}: ',
                style: const TextStyle(
                  color: AppColors.greyColor,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(
                    text: '${group.lastMessage}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : null,
      trailing: group.lastMessage != null
          ? TimeText(
              group.lastMessageTimestamp!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyle.textSmallRegular
                  .copyWith(color: AppColors.greyColor),
            )
          : null,
      onTap: () {
        // context.push(
        //   BlocProvider(
        //     create: (_) => sl<ChatCubit>(),
        //     child: ChatView(group: group),
        //   ),
        // );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (_) => sl<ChatCubit>(),
                child: ChatView(group: group),
              ),
            ));
      },
    );
  }
}
