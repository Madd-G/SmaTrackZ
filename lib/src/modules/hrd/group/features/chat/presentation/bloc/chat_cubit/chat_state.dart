part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class LoadingMessages extends ChatState {
  const LoadingMessages();
}

class SendingMessage extends ChatState {
  const SendingMessage();
}

class GettingUser extends ChatState {
  const GettingUser();
}

class MessageSent extends ChatState {
  const MessageSent();
}

class UserFound extends ChatState {
  const UserFound(this.user);

  final UserEntity user;

  @override
  List<Object> get props => [user];
}

class MessagesLoaded extends ChatState {
  const MessagesLoaded(this.messages);

  final List<MessageEntity> messages;

  @override
  List<Object> get props => [messages];
}

class ChatError extends ChatState {
  const ChatError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
