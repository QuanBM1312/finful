import 'package:equatable/equatable.dart';

abstract class RequestBookingState extends Equatable {
  const RequestBookingState();

  @override
  List<Object?> get props => [
  ];
}

class RequestBookingInitial extends RequestBookingState {
  const RequestBookingInitial(): super();
}

class RequestBookingInProgress extends RequestBookingState {
  const RequestBookingInProgress(): super();
}

class RequestBookingSuccess extends RequestBookingState {
  const RequestBookingSuccess(): super();
}

class RequestBookingFailure extends RequestBookingState {
  const RequestBookingFailure(): super();
}