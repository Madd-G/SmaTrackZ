import 'package:smatrackz/core.dart';

class GetMessages extends StreamUseCaseWithParams<List<MessageEntity>, String> {
  const GetMessages(this._repo);

  final ChatRepo _repo;

  @override
  ResultStream<List<MessageEntity>> call(String params) => _repo.getMessages(params);
}
