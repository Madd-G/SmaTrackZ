import 'package:smatrackz/core.dart';

class SendMessage extends FutureUseCaseWithParams<void, MessageEntity> {
  const SendMessage(this._repo);

  final ChatRepo _repo;

  @override
  ResultFuture<void> call(MessageEntity params) async => _repo.sendMessage(params);
}
