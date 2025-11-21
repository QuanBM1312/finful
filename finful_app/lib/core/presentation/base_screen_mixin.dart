import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'base_router.dart';

mixin BaseScreenMixin<W extends StatefulWidget, R extends BaseRouter>
on State<W> {
  ValueListenable<bool>? _tickerNotifier;
  R? _router;

  R get router {
    _router ??= ModalRoute.of(context)!.settings.arguments as R;
    return _router!;
  }

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    _tickerNotifier = TickerMode.getNotifier(context);
    _tickerNotifier?.addListener(_listenScreenVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      didMountWidget();
    });
  }

  void _listenScreenVisibility() {
    if (_tickerNotifier == null) {
      return;
    }
    if (_tickerNotifier!.value) {
      return didResume();
    }
    return didPause();
  }

  void didMountWidget() {}

  void didPause() {}

  void didResume() {}

  @mustCallSuper
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @mustCallSuper
  @override
  void didUpdateWidget(covariant W oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @mustCallSuper
  @override
  void deactivate() {
    super.deactivate();
  }

  @mustCallSuper
  @override
  void dispose() {
    _tickerNotifier?.removeListener(_listenScreenVisibility);
    _tickerNotifier = null;
    super.dispose();
  }
}
