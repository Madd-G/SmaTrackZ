import 'package:smatrackz/core.dart';

class GetMessages extends StreamUseCaseWithParams<List<Message>, String> {
  const GetMessages(this._repo);

  final ChatRepo _repo;

  @override
  ResultStream<List<Message>> call(String params) => _repo.getMessages(params);
}
