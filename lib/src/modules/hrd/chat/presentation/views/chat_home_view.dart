import 'package:smatrackz/core.dart';

class ChatHomeView extends StatefulWidget {
  const ChatHomeView({super.key});

  static const routeName = '/chat-home';

  @override
  State<ChatHomeView> createState() => _ChatHomeViewState();
}

class _ChatHomeViewState extends State<ChatHomeView> {
  List<GroupEntity> yourGroups = [];
  List<GroupEntity> otherGroups = [];

  bool showingDialog = false;

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (_, state) {
          if (showingDialog) {
            Navigator.of(context).pop();
            showingDialog = false;
          }
          if (state is ChatError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is JoiningGroup) {
            showingDialog = true;
            CoreUtils.showLoadingDialog(context);
          } else if (state is JoinedGroup) {
            CoreUtils.showSnackBar(context, 'Joined group successfully');
          } else if (state is GroupLoaded) {
            yourGroups = state.groups
                .where(
                  (group) => group.members
                      .contains(context.userProvider.user?.companyId),
                )
                .toList();
          }
        },
        builder: (context, state) {
          if (state is LoadingGroups) {
            return const LoadingView();
          } else if (state is GroupLoaded && state.groups.isEmpty) {
            return const NotFoundText(
              'No group found\nPlease contact admin or if you are admin, '
              'add group',
            );
          } else if ((state is GroupLoaded) ||
              (yourGroups.isNotEmpty) ||
              (otherGroups.isNotEmpty)) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                if (yourGroups.isNotEmpty) ...[
                  Text(
                    'Your Group',
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Divider(color: Colors.grey.shade300),
                  ...yourGroups.map(YourGroupTile.new),
                ],
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
