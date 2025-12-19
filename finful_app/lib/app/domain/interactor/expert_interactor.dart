abstract interface class ExpertInteractor {
  Future<void> submitRequestChat({
    required String phoneNumber,
  });

  Future<void> submitRequestBooking({
    required String name,
    required String phoneNumber,
  });
}