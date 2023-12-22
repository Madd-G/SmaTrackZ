import 'package:smatrackz/core.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit({
    required GetGroups getGroups,
    required GetUserById getUserById,
    required JoinGroup joinGroup,
    required LeaveGroup leaveGroup,
    required AddGroup addGroup,
  })  : _getGroups = getGroups,
        _getUserById = getUserById,
        _joinGroup = joinGroup,
        _leaveGroup = leaveGroup,
        _addGroup = addGroup,
        super(const GroupInitial());

  final GetGroups _getGroups;
  final GetUserById _getUserById;
  final JoinGroup _joinGroup;
  final LeaveGroup _leaveGroup;
  final AddGroup _addGroup;

  Future<void> joinGroup({
    required String groupId,
    required String userId,
  }) async {
    emit(const JoiningGroup());
    final result = await _joinGroup(
      JoinGroupParams(groupId: groupId, userId: userId),
    );
    result.fold(
      (failure) => emit(GroupError(failure.errorMessage)),
      (_) => emit(const JoinedGroup()),
    );
  }

  Future<void> addGroup(GroupEntity group) async {
    emit(const AddingGroup());
    final result = await _addGroup(group);
    result.fold(
      (failure) => emit(GroupError(failure.errorMessage)),
      (_) => emit(const GroupAdded()),
    );
  }

  Future<void> leaveGroup({
    required String groupId,
    required String userId,
  }) async {
    emit(const LeavingGroup());
    final result = await _leaveGroup(
      LeaveGroupParams(groupId: groupId, userId: userId),
    );
    result.fold(
      (failure) => emit(GroupError(failure.errorMessage)),
      (_) => emit(const LeftGroup()),
    );
  }

  Future<void> getUser(String userId) async {
    emit(const GetUser());
    final result = await _getUserById(userId);

    result.fold(
      (failure) => emit(GroupError(failure.errorMessage)),
      (user) => emit(UserFounded(user)),
    );
  }

  void getGroups() {
    emit(const LoadingGroups());

    StreamSubscription<Either<Failure, List<GroupEntity>>>? subscription;

    subscription = _getGroups().listen(
      (result) {
        result.fold(
          (failure) => emit(GroupError(failure.errorMessage)),
          (groups) => emit(GroupLoaded(groups)),
        );
      },
      onError: (dynamic error) {
        emit(GroupError(error.toString()));
        subscription?.cancel();
      },
      onDone: () => subscription?.cancel(),
    );
  }
}
