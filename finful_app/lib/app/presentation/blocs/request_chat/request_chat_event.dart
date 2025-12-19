abstract class RequestChatEvent {
  const RequestChatEvent();
}

class RequestChatStarted extends RequestChatEvent {
  final String phoneNumber;

  RequestChatStarted({
    required this.phoneNumber,
  });
}
