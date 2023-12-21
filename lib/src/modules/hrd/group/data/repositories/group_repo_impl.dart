import 'package:smatrackz/core.dart';

class GroupRepoImpl implements GroupRepo {
  const GroupRepoImpl(this._remoteDataSource);

  final GroupRemoteDataSource _remoteDataSource;

  @override
  ResultStream<List<GroupEntity>> getGroups() {
    return _remoteDataSource.getGroups().transform(
          StreamTransformer<List<GroupModel>,
              Either<Failure, List<GroupEntity>>>.fromHandlers(
            handleError: (error, stackTrace, sink) {
              if (error is ServerException) {
                sink.add(
                  Left(
                    ServerFailure(
                      message: error.message,
                      statusCode: error.statusCode,
                    ),
                  ),
                );
              } else {
                // Handle other types of exceptions as needed
                sink.add(
                  Left(
                    ServerFailure(
                      message: error.toString(),
                      statusCode: 500,
                    ),
                  ),
                );
              }
            },
            handleData: (groups, sink) {
              sink.add(Right(groups));
            },
          ),
        );
  }

  @override
  ResultFuture<void> joinGroup({
    required String groupId,
    required String userId,
  }) async {
    try {
      await _remoteDataSource.joinGroup(groupId: groupId, userId: userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> leaveGroup({
    required String groupId,
    required String userId,
  }) async {
    try {
      await _remoteDataSource.leaveGroup(groupId: groupId, userId: userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserEntity> getUserById(String userId) async {
    try {
      final result = await _remoteDataSource.getUserById(userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
