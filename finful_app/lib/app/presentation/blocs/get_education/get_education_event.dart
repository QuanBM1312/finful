abstract class GetEducationEvent {
  const GetEducationEvent();
}

class GetEducationOnboardingStarted extends GetEducationEvent {
  final String type;
  final String location;

  GetEducationOnboardingStarted({
    required this.type,
    required this.location,
  });
}