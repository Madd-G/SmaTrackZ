import 'package:smatrackz/core.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required GetMessages getMessages,
    required GetUserById getUserById,
    required SendMessage sendMessage,
  })  : _getMessages = getMessages,
        _getUserById = getUserById,
        _sendMessage = sendMessage,
        super(const ChatInitial());

  final GetMessages _getMessages;
  final GetUserById _getUserById;
  final SendMessage _sendMessage;

  Future<void> sendMessage(MessageEntity message) async {
    emit(const SendingMessage());
    final result = await _sendMessage(message);
    result.fold(
      (failure) => emit(ChatError(failure.errorMessage)),
      (_) => emit(const MessageSent()),
    );
  }

  Future<void> getUser(String userId) async {
    emit(const GettingUser());
    final result = await _getUserById(userId);

    result.fold(
      (failure) => emit(ChatError(failure.errorMessage)),
      (user) => emit(UserFound(user)),
    );
  }

  void getMessages(String groupId) {
    emit(const LoadingMessages());

    StreamSubscription<Either<Failure, List<MessageEntity>>>? subscription;

    subscription = _getMessages(groupId).listen(
      (result) {
        result.fold(
          (failure) => emit(ChatError(failure.errorMessage)),
          (messages) => emit(MessagesLoaded(messages)),
        );
      },
      onError: (dynamic error) {
        emit(ChatError(error.toString()));
        subscription?.cancel();
      },
      onDone: () => subscription?.cancel(),
    );
  }
}
