import 'dart:async';

import 'package:flutter/material.dart';

import '../animated_text/animated_hints_text.dart';

const _textfieldHeight = 40.0;
const _kContentHorinzontalPadding = 8.0;
const _kDefaultBackgroundColor = Color(0xFFF7F7F7);
const _kDefaultClearIcon = Icon(
  Icons.close,
  color: Colors.black,
);

class AppBarSearchField extends StatefulWidget {
  final int debounce;
  final List<String> hints;
  final void Function(String text)? onTextChanged;
  final double? height;
  final bool autofocus;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final Icon? clearIcon;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  const AppBarSearchField({
    Key? key,
    this.hints = const [],
    this.onTextChanged,
    this.debounce = 300,
    this.height,
    this.autofocus = false,
    this.controller,
    this.backgroundColor = _kDefaultBackgroundColor,
    this.clearIcon,
    this.textStyle,
    this.hintStyle,
  }) : super(key: key);

  @override
  _AppBarSearchFieldState createState() => _AppBarSearchFieldState();
}

class _AppBarSearchFieldState extends State<AppBarSearchField> {
  Timer? _debounceTimer;
  late TextEditingController _controller;
  final _isTextEmptyNotifier = ValueNotifier<bool>(true);
  String? _currentText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onTextChanged() {
    _isTextEmptyNotifier.value = !_controller.text.isNotEmpty;
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }
    _debounceTimer = Timer(
      Duration(milliseconds: widget.debounce),
      () {
        if (_currentText != _controller.text) {
          widget.onTextChanged?.call(_controller.text);
          _currentText = _controller.text;
        }
      },
    );
  }

  InputBorder get textfieldBorder => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? _textfieldHeight,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextField(
            autofocus: widget.autofocus,
            controller: _controller,
            onSubmitted: widget.onTextChanged,
            style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: _kContentHorinzontalPadding,
              ),
              filled: true,
              fillColor: widget.backgroundColor,
              focusColor: widget.backgroundColor,
              enabledBorder: textfieldBorder,
              focusedBorder: textfieldBorder,
              suffixIcon: ValueListenableBuilder<bool>(
                  valueListenable: _isTextEmptyNotifier,
                  builder: (context, _isTextEmpty, _) {
                    if (!_isTextEmpty) {
                      return GestureDetector(
                        onTap: _controller.clear,
                        child: widget.clearIcon ?? _kDefaultClearIcon,
                      );
                    }
                    return const SizedBox.shrink();
                  }),
              border: InputBorder.none,
            ),
          ),
          IgnorePointer(
            child: ValueListenableBuilder<bool>(
              valueListenable: _isTextEmptyNotifier,
              builder: (context, _isTextEmpty, _) {
                if (_isTextEmpty && widget.hints.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: _kContentHorinzontalPadding,
                    ),
                    child: AnimatedHintsText(
                      hints: widget.hints,
                      style: widget.hintStyle ??
                          const TextStyle(
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            height: 20 / 16,
                          ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
