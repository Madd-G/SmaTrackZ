import 'package:smatrackz/core.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  static const routeName = '/groups-screen';

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  List<GroupEntity> yourGroups = [];
  List<GroupEntity> otherGroups = [];

  bool showingDialog = false;

  @override
  void initState() {
    super.initState();
    context.read<GroupCubit>().getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Groups',
          style: CustomTextStyle.headingSemiBold,
        ),
      ),
      body: BlocConsumer<GroupCubit, GroupState>(
        listener: (_, state) {
          if (showingDialog) {
            Navigator.of(context).pop();
            showingDialog = false;
          }
          if (state is GroupError) {
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
                  ...yourGroups.map(GroupTile.new),
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
