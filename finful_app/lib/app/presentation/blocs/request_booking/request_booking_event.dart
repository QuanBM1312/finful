abstract class RequestBookingEvent {
  const RequestBookingEvent();
}

class RequestBookingStarted extends RequestBookingEvent {
  final String name;
  final String phoneNumber;

  RequestBookingStarted({
    required this.name,
    required this.phoneNumber,
  });
}
