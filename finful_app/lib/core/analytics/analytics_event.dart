abstract class AnalyticsEvent {
  final String name;
  final Map<String, dynamic>? parameters;

  AnalyticsEvent({
    required this.name,
    this.parameters,
  });
}

extension AnalyticsEventExt on AnalyticsEvent {
  Map<String, dynamic>? formatParameters(
      {int? maxEventKeyLength, int? maxEventValueLength}) {
    if (parameters == null) {
      return null;
    }
    final result = <String, dynamic>{};
    for (final key in parameters!.keys) {
      final value = parameters![key];
      result[_cutStringIfNeeded(key, maxEventKeyLength)] = value is String
          ? _cutStringIfNeeded(value, maxEventValueLength)
          : value;
    }

    return result;
  }

  String _cutStringIfNeeded(String value, int? maxLength) {
    if (maxLength == null) {
      return value;
    }
    return value.length <= maxLength ? name : name.substring(0, maxLength);
  }
}
