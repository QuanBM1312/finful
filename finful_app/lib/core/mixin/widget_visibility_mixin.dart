import 'package:flutter/widgets.dart';

mixin WidgetVisibilityMixin<W extends StatefulWidget> on State<W> {
  ValueNotifier<bool>? _tickerNotifier;

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    _tickerNotifier = TickerMode.getNotifier(context) as ValueNotifier<bool>?;
    _tickerNotifier?.addListener(_listenScreenVisibility);
  }

  void _listenScreenVisibility() {
    if (_tickerNotifier == null) {
      return;
    }
    if (_tickerNotifier!.value) {
      return didResumeWidget();
    }
    return didPauseWidget();
  }

  void didPauseWidget() {}

  void didResumeWidget() {}

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    _tickerNotifier?.removeListener(_listenScreenVisibility);
    _tickerNotifier = null;
  }
}
