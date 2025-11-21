import 'package:flutter/material.dart';

mixin WidgetDidMount<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widgetDidMount(context));
  }

  void widgetDidMount(BuildContext context);
}
