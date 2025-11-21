import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_bar_search_field.dart';

const _kDefaultElevation = 0.5;
const _kDefaultTitleHeight = 17.0;
const _kDefaultLeadingIosIcon = Icon(
  Icons.arrow_back_ios_rounded,
);
const _kDefaultLeadingAndroidIcon = Icon(
  Icons.arrow_back_rounded,
);

class FinfulAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final bool? showLeadingIcon;
  final Widget? leadingIcon;
  final String title;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  final void Function()? onLeadingPressed;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Widget? child;
  final double? elevation;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;
  final double? height;
  final bool forceMaterialTransparency;

  const FinfulAppBar({
    super.key,
    this.showLeadingIcon,
    this.title = '',
    this.titleStyle,
    this.actions,
    this.backgroundColor,
    this.onLeadingPressed,
    this.systemOverlayStyle,
    this.elevation,
    this.child,
    this.bottom,
    this.leadingIcon,
    this.centerTitle = true,
    this.forceMaterialTransparency = false,
    this.height,
  });

  factory FinfulAppBar.search({
    List<String> hints = const [],
    Function(String)? onTextChanged,
    Color? backgroundColor,
    Icon? leadingIcon,
    bool? showLeadingIcon,
    bool autofocus = false,
    List<Widget>? actions,
    void Function()? onLeadingPressed,
    TextEditingController? searchController,
    PreferredSizeWidget? bottom,
    double? elevation,
    SystemUiOverlayStyle? systemOverlayStyle,
    Color? searchBackgroundColor,
    Icon? searchClearIcon,
    TextStyle? searchTextStyle,
    TextStyle? searchHintStyle,
    double? searchHeight,
    int searchDebounce = 300,
  }) {
    return FinfulAppBar(
      onLeadingPressed: onLeadingPressed,
      backgroundColor: backgroundColor,
      leadingIcon: leadingIcon,
      showLeadingIcon: showLeadingIcon,
      actions: actions,
      bottom: bottom,
      elevation: elevation,
      systemOverlayStyle: systemOverlayStyle,
      child: AppBarSearchField(
        hints: hints,
        onTextChanged: onTextChanged,
        autofocus: autofocus,
        controller: searchController,
        backgroundColor: searchBackgroundColor,
        debounce: searchDebounce,
        textStyle: searchTextStyle,
        hintStyle: searchHintStyle,
        height: searchHeight,
        clearIcon: searchClearIcon,
      ),
    );
  }

  void _onLeadingPressed(BuildContext context) {
    if (onLeadingPressed != null) {
      onLeadingPressed!();
    } else {
      Navigator.maybePop(context);
    }
  }

  bool _showLeadingIcon(BuildContext context) {
    return showLeadingIcon ?? Navigator.of(context).canPop();
  }

  @override
  Widget build(BuildContext context) {
    final appBarLeadingIcon = leadingIcon ??
        (Platform.isAndroid
            ? _kDefaultLeadingAndroidIcon
            : _kDefaultLeadingIosIcon);
    return AppBar(
      forceMaterialTransparency: forceMaterialTransparency,
      leading: _showLeadingIcon(context)
          ? IconButton(
              icon: appBarLeadingIcon,
              onPressed: () => _onLeadingPressed(context),
            )
          : null,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      title: child ??
          Text(
            title,
            style: titleStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: _kDefaultTitleHeight,
                      height: 20 / _kDefaultTitleHeight,
                      fontWeight: FontWeight.w600,
                    ),
          ),
      bottom: bottom,
      actions: actions,
      elevation: elevation ?? _kDefaultElevation,
      systemOverlayStyle: systemOverlayStyle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        (height ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0),
      );
}
