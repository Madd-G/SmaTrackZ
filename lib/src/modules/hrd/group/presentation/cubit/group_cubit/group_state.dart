part of 'group_cubit.dart';

@immutable
abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupInitial extends GroupState {
  const GroupInitial();
}

class LoadingGroups extends GroupState {
  const LoadingGroups();
}

class JoiningGroup extends GroupState {
  const JoiningGroup();
}

class LeavingGroup extends GroupState {
  const LeavingGroup();
}

class GroupLoaded extends GroupState {
  const GroupLoaded(this.groups);

  final List<GroupEntity> groups;

  @override
  List<Object> get props => [groups];
}

class GetUser extends GroupState {
  const GetUser();
}

class UserFounded extends GroupState {
  const UserFounded(this.user);

  final UserEntity user;

  @override
  List<Object> get props => [user];
}

class LeftGroup extends GroupState {
  const LeftGroup();
}

class JoinedGroup extends GroupState {
  const JoinedGroup();
}

class GroupError extends GroupState {
  const GroupError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
