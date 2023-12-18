import 'package:smatrackz/core.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble(this.message, {super.key});

  final Message message;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  UserEntity? user;

  @override
  Widget build(BuildContext context) {
    int randomColor = (Random().nextDouble() * 0xFFFFFF).toInt();
    var user = context.currentUser;
    bool isCurrentUser = widget.message.senderId == context.currentUser!.companyId;
    return BlocListener<ChatCubit, ChatState>(
      listener: (_, state) {
        if (state is UserFound && user == null) {
          setState(() {
            user = state.user;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment:
              isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isCurrentUser)
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  user == null || (user.profilePicture == null)
                      ? kDefaultAvatar
                      : user.profilePicture!,
                ),
              ),
            Container(
              margin: EdgeInsets.only(top: 4, left: isCurrentUser ? 0 : 10),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: isCurrentUser
                      ? const Radius.circular(10.0)
                      : const Radius.circular(0.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0),
                  topRight: isCurrentUser
                      ? const Radius.circular(0.0)
                      : const Radius.circular(10.0),
                ),
                color: isCurrentUser
                    ? AppColors.secondaryColor
                    : AppColors.whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isCurrentUser)
                    Text(
                      user == null ? '' : user.companyName,
                      style: CustomTextStyle.textSemiBold.copyWith(
                          color: Color(
                        randomColor,
                      ).withOpacity(1.0)),
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: isCurrentUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.message.message,
                        style: CustomTextStyle.textMediumRegular.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        widget.message.timestamp.clockFormatSimple,
                        style: CustomTextStyle.textSmallRegular
                            .copyWith(color: Colors.black, fontSize: 10.0),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
