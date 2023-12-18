import 'package:smatrackz/core.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({required this.groupId, super.key});

  final String groupId;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.multiline,
              showCursor: true,
              minLines: 1,
              maxLines: 7,
              style: const TextStyle(
                fontSize: 14.0,
              ),
              decoration: InputDecoration(
                hintText: 'message',
                hintStyle: const TextStyle(
                  color: Color(0xFF9FA5BB),
                ),
                contentPadding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.greyColor),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.greyColor),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                filled: true,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Ink(
            decoration: const ShapeDecoration(
              shape: CircleBorder(),
              color: AppColors.primaryColor,
            ),
            child: IconButton(
              onPressed: () {
                final message = controller.text.trim();
                if (message.isEmpty) return;
                controller.clear();
                focusNode.unfocus();
                context.read<ChatCubit>().sendMessage(
                      MessageModel.empty().copyWith(
                        message: message,
                        senderId: context.currentUser!.companyId,
                        groupId: widget.groupId,
                      ),
                    );
              },
              icon: const Icon(
                IconlyLight.send,
                color: AppColors.whiteColor,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
