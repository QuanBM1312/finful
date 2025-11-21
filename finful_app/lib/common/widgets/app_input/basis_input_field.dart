import 'package:finful_app/core/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/dimensions.dart';

const String _kEmptyString = '';
const int kDefaultErrorMaxLines = 2;
const int kDefaultHelperMaxLines = 2;
const int kDefaultMinLines = 1;
const int kDefaultMaxLines = 1;

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _Prefix extends StatelessWidget {
  final Widget prefixIcon;

  _Prefix({
    Key? key,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.p_12,
        right: Dimens.p_8,
      ),
      child: prefixIcon,
    );
  }
}

class _RenderSuffixClearIcon extends StatelessWidget {
  final VoidCallback onClearText;
  final Widget? icon;

  _RenderSuffixClearIcon({
    Key? key,
    required this.onClearText,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.p_6,
      ),
      child: GestureDetector(
        onTap: onClearText,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: Dimens.p_32,
            minHeight: Dimens.p_32,
          ),
          child: Container(
            color: Colors.transparent,
            child: icon ??
                const Icon(
                  Icons.clear,
                  color: Colors.black,
                ),
          ),
        ),
      ),
    );
  }
}

class BasisInputField extends StatefulWidget {
  /// set auto focus for text input after text input draw on widget tree
  final bool autoFocus;

  /// set focusNode
  final bool enableInteractiveSelection;

  final bool autocorrect;
  final bool obscureText;
  final bool enabled;

  /// if [true] and has initialValue is notEmpty will show clear button
  final bool showClearButton;

  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? clearIcon;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool autoValidate;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? counterStyle;
  final TextStyle? errorStyle;
  final TextStyle? textStyle;
  final TextStyle? helperStyle;
  final List<TextInputFormatter>? inputFormatter;
  final Function(bool hasFocus)? onFocusChange;
  final TextInputAction? textInputAction;
  final Function(String text)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final int? errorMaxLines;
  final int? helperMaxLines;
  final FocusNode? focusNode;
  final VoidCallback? onClearText;
  final ValueKey? textInputKey;
  final ToolbarOptions? toolbarOptions;
  final InputBorder? border;
  final OutlineInputBorder? focusBorder;
  final VoidCallback? onEditingComplete;
  final EdgeInsets? contentPadding;
  final Color? cursorColor;
  final bool isShowLabel;
  final bool isBare;

  /// set padding for counter widget
  final EdgeInsets? counterPadding;

  /// set background color text input
  final Color? backgroundColor;

  const BasisInputField({
    Key? key,
    this.autoFocus = false,
    this.autocorrect = false,
    this.obscureText = false,
    this.enabled = true,
    this.isShowLabel = false,
    this.hintText,
    this.labelText,
    this.errorText,
    this.hintStyle,
    this.labelStyle,
    this.counterStyle,
    this.errorStyle,
    this.helperStyle,
    this.onChanged,
    this.prefixIcon,
    this.helperText,
    this.suffixIcon,
    this.clearIcon,
    this.controller,
    this.keyboardType,
    this.validator,
    this.autoValidate = false,
    this.showClearButton = false,
    this.onTap,
    this.initialValue,
    this.onSaved,
    this.inputFormatter,
    this.onFocusChange,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.errorMaxLines = kDefaultErrorMaxLines,
    this.helperMaxLines = kDefaultHelperMaxLines,
    this.enableInteractiveSelection = true,
    this.focusNode,
    this.textStyle,
    this.onClearText,
    this.textInputKey,
    this.toolbarOptions,
    this.counterPadding,
    this.backgroundColor,
    this.border,
    this.focusBorder,
    this.contentPadding,
    this.cursorColor,
    this.isBare = false,
  }) : super(key: key);

  @override
  _BasisInputFieldState createState() => _BasisInputFieldState();
}

class _BasisInputFieldState extends State<BasisInputField> {
  late FocusNode _focus;
  bool autoFocus = false;
  late int currentLength;
  TextEditingController? _controller;

  TextEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  bool isFocused = false, isClearBtnShowing = false;
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    _enabled = widget.enabled;
    if (widget.focusNode != null) {
      _focus = widget.focusNode!;
    } else {
      _focus = FocusNode();
    }

    _focus.addListener(_onFocusChange);
    autoFocus = widget.autoFocus;
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    }

    currentLength = _effectiveController?.text.length ?? 0;
  }

  @override
  void didUpdateWidget(BasisInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _controller =
          TextEditingController.fromValue(oldWidget.controller?.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      _controller = null;
    }

    if (oldWidget.enabled != widget.enabled) {
      setState(() {
        _enabled = !_enabled;
      });
    }
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _controller?.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focus.hasFocus;
    });
    widget.onFocusChange?.call(_focus.hasFocus);
  }

  void _onTextChanged(String text) {
    setState(() {
      currentLength = text.length;
    });
    final shouldShowClearBtn = widget.showClearButton && text.isNotEmpty;
    if (isClearBtnShowing != shouldShowClearBtn) {
      setState(() {
        isClearBtnShowing = shouldShowClearBtn;
      });
    }
    widget.onChanged?.call(text);
  }

  void _onClearText() {
    _effectiveController?.clear();
    widget.onClearText?.call();
    return _onTextChanged(_kEmptyString);
  }

  void _setFocus(BuildContext context) {
    if (autoFocus) {
      FocusScope.of(context).requestFocus(_focus);
      autoFocus = false;
    }
  }

  Color? get _getBackgroundColor {
    return widget.backgroundColor;
  }

  InputBorder? _getBorder() {
    if (widget.isBare) {
      return Theme.of(context).inputDecorationTheme.border!.copyWith(
        borderSide: const BorderSide(
          width: 0.0,
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
      );
    }

    return widget.border ?? Theme.of(context).inputDecorationTheme.border;
  }

  InputBorder? _getEnabledBorder() {
    if (widget.isBare) {
      return Theme.of(context).inputDecorationTheme.enabledBorder!.copyWith(
        borderSide: const BorderSide(
          width: 0.0,
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
      );
    }

    return widget.border ??
        Theme.of(context).inputDecorationTheme.enabledBorder;
  }

  InputBorder? _getFocusedBorder() {
    if (widget.isBare) {
      return Theme.of(context).inputDecorationTheme.focusedBorder!.copyWith(
        borderSide: const BorderSide(
          width: 0.0,
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
      );
    }

    return widget.focusBorder ??
        Theme.of(context).inputDecorationTheme.focusedBorder;
  }

  InputBorder? _getFocusedErrorBorder() {
    if (widget.isBare) {
      return Theme.of(context)
          .inputDecorationTheme
          .focusedErrorBorder!
          .copyWith(
        borderSide: const BorderSide(
          width: 0.0,
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
      );
    }

    return Theme.of(context).inputDecorationTheme.focusedErrorBorder;
  }

  InputBorder? _getErrorBorder() {
    if (widget.isBare) {
      return Theme.of(context).inputDecorationTheme.errorBorder!.copyWith(
        borderSide: const BorderSide(
          width: 0.0,
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
      );
    }

    return Theme.of(context).inputDecorationTheme.errorBorder;
  }

  InputBorder? _getDisabledBorder() {
    if (widget.isBare) {
      return Theme.of(context).inputDecorationTheme.disabledBorder!.copyWith(
        borderSide: const BorderSide(
          width: 0.0,
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
      );
    }

    return Theme.of(context).inputDecorationTheme.disabledBorder;
  }

  TextInputAction _getTextInputAction() {
    return widget.textInputAction ?? TextInputAction.next;
  }

  InputDecoration _getInputDecoration() {
    final remainingCharLength =
    (widget.maxLength != null) ? widget.maxLength! - currentLength : null;
    return InputDecoration(
      fillColor: _getBackgroundColor,
      filled: true,
      errorMaxLines: widget.errorMaxLines,
      helperMaxLines: widget.helperMaxLines,
      contentPadding: widget.contentPadding ??
          const EdgeInsets.only(
            left: Dimens.p_16,
            top: Dimens.p_10,
            bottom: Dimens.p_10,
          ),
      alignLabelWithHint: true,
      hintText: widget.hintText,
      labelText: widget.labelText,
      labelStyle: widget.labelStyle,
      hintMaxLines: 1,
      helperText: widget.helperText,
      helperStyle: widget.helperStyle,
      prefixIcon: widget.prefixIcon != null
          ? _Prefix(
        prefixIcon: widget.prefixIcon!,
      )
          : null,
      suffixIcon: widget.suffixIcon ??
          (isClearBtnShowing
              ? (isFocused
              ? _RenderSuffixClearIcon(
            onClearText: _onClearText,
            icon: widget.clearIcon,
          )
              : null)
              : null),
      hintStyle: widget.hintStyle,
      errorStyle: widget.errorStyle,
      errorText: widget.errorText,
      counterText: remainingCharLength != null
          ? currentLength.toCountCharactersRemaining(
          maxLength: widget.maxLength)
          : null,
      counterStyle: remainingCharLength != null ? widget.counterStyle : null,
      border: _getBorder(),
      focusedBorder: _getFocusedBorder(),
      enabledBorder: _getEnabledBorder(),
      focusedErrorBorder: _getFocusedErrorBorder(),
      errorBorder: _getErrorBorder(),
      disabledBorder: _getDisabledBorder(),
      prefixIconConstraints: const BoxConstraints(
        minWidth: Dimens.p_24,
        minHeight: Dimens.p_24,
      ),
      suffixIconConstraints: const BoxConstraints(
        minWidth: Dimens.p_24,
        minHeight: Dimens.p_24,
      ),
      isDense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    _setFocus(context);
    return Material(
      color: Colors.transparent,
      child: TextFormField(
        key: widget.textInputKey ?? const ValueKey('basis_text_input_key'),
        enableInteractiveSelection: widget.enableInteractiveSelection,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        cursorColor: widget.cursorColor,
        cursorWidth: Dimens.p_1,
        autocorrect: widget.autocorrect,
        autofocus: widget.autoFocus,
        enabled: _enabled,
        controller: _effectiveController,
        onChanged: _onTextChanged,
        toolbarOptions: widget.toolbarOptions,
        onSaved: widget.onSaved,
        focusNode: widget.enableInteractiveSelection
            ? _focus
            : AlwaysDisabledFocusNode(),
        validator: widget.validator,
        autovalidateMode: widget.autoValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        onTap: widget.onTap,
        style: widget.textStyle,
        decoration: _getInputDecoration(),
        inputFormatters: widget.inputFormatter,
        textInputAction: _getTextInputAction(),
        onFieldSubmitted: widget.onFieldSubmitted,
        onEditingComplete: widget.onEditingComplete,
        maxLength: widget.maxLength,
        minLines: widget.minLines ?? kDefaultMinLines,
        maxLines: widget.maxLines ?? kDefaultMaxLines,
      ),
    );
  }
}
