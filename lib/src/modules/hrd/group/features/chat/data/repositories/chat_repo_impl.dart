import 'package:smatrackz/core.dart';

class ChatRepoImpl implements ChatRepo {
  const ChatRepoImpl(this._remoteDataSource);

  final ChatRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> sendMessage(MessageEntity message) async {
    try {
      await _remoteDataSource.sendMessage(message);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultStream<List<MessageEntity>> getMessages(String groupId) {
    return _remoteDataSource.getMessages(groupId).transform(_handleStream());
  }

  StreamTransformer<List<MessageModel>, Either<Failure, List<MessageEntity>>>
      _handleStream() {
    return StreamTransformer<List<MessageModel>,
        Either<Failure, List<MessageEntity>>>.fromHandlers(
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
      handleData: (messages, sink) {
        sink.add(Right(messages));
      },
    );
  }
}
