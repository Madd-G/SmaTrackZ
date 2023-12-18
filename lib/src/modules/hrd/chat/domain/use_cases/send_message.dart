import 'package:smatrackz/core.dart';

class SendMessage extends FutureUseCaseWithParams<void, Message> {
  const SendMessage(this._repo);

  final ChatRepo _repo;

  @override
  ResultFuture<void> call(Message params) async => _repo.sendMessage(params);
}
