Future<void> forceDelay({
  Duration? duration,
}) async {
  await Future<void>.delayed(duration ?? const Duration(milliseconds: 300));
}