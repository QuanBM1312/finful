import 'package:equatable/equatable.dart';

import 'show_message_event.dart';

abstract class ShowMessageState extends Equatable {
  const ShowMessageState();

  @override
  List<Object> get props => [];
}

class ShowMessageInitial extends ShowMessageState {}

class ShowMessageSnackBarStartedInProgress extends ShowMessageState {}

class ShowMessageSnackBarStartedSuccess extends ShowMessageState {
  final ShowMessageSnackBarType type;
  final String? title;
  final String? message;

  const ShowMessageSnackBarStartedSuccess({
    required this.type,
    this.title,
    this.message,
  });
}

class ShowMessageToastStartedInProgress extends ShowMessageState {}

class ShowMessageToastStartedSuccess extends ShowMessageState {
  final String? title;
  final String? message;

  const ShowMessageToastStartedSuccess({
    this.title,
    this.message,
  });
}
