import 'package:equatable/equatable.dart';

abstract class RequestChatState extends Equatable {
  const RequestChatState();

  @override
  List<Object?> get props => [
  ];
}

class RequestChatInitial extends RequestChatState {
  const RequestChatInitial(): super();
}

class RequestChatInProgress extends RequestChatState {
  const RequestChatInProgress(): super();
}

class RequestChatSuccess extends RequestChatState {
  const RequestChatSuccess(): super();
}

class RequestChatFailure extends RequestChatState {
  const RequestChatFailure(): super();
}