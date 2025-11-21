import 'package:flutter/material.dart';

class GridItemPlaceHolder extends StatefulWidget {
  GridItemPlaceHolder({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<GridItemPlaceHolder> createState() => _GridItemPlaceHolderState();
}

class _GridItemPlaceHolderState extends State<GridItemPlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}

class GridItemLayout extends StatelessWidget {
  GridItemLayout({
    this.placeHolder,
    required this.child,
  });

  final Widget child;
  final Widget? placeHolder;

  @override
  Widget build(BuildContext context) {
    if (placeHolder != null) {
      return GridItemPlaceHolder(
        child: child,
      );
    }

    return child;
  }
}
