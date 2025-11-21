enum ShowMessageSnackBarType {
  info,
  warning,
  error,
}

abstract class ShowMessageEvent {
  const ShowMessageEvent();
}

class ShowMessageSnackBarStarted extends ShowMessageEvent {
  final ShowMessageSnackBarType type;
  final String? title;
  final String? message;

  ShowMessageSnackBarStarted({
    required this.type,
    this.title,
    this.message,
  });
}

class ShowMessageToastStarted extends ShowMessageEvent {
  final String? title;
  final String? message;

  ShowMessageToastStarted({
    this.title,
    this.message,
  });
}
