import 'package:smatrackz/core.dart';

class GroupTile extends StatelessWidget {
  const GroupTile(this.group, {super.key});

  final GroupEntity group;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(group.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(group.groupImageUrl!),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
