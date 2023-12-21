import 'package:smatrackz/core.dart';

class LeaveGroup extends FutureUseCaseWithParams<void, LeaveGroupParams> {
  const LeaveGroup(this._repo);

  final GroupRepo _repo;

  @override
  ResultFuture<void> call(LeaveGroupParams params) => _repo.leaveGroup(
        groupId: params.groupId,
        userId: params.userId,
      );
}

class LeaveGroupParams extends Equatable {
  const LeaveGroupParams({required this.groupId, required this.userId});

  const LeaveGroupParams.empty()
      : groupId = '',
        userId = '';

  final String groupId;
  final String userId;

  @override
  List<String> get props => [groupId, userId];
}
