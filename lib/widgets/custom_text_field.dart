import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:utilities/utilities.dart';

///Creates a [FormField] that contains a custom feel.
///
class CTextField extends StatefulWidget {
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController? controller;

  final FocusNode? focusNode;

  /// Text that suggests what sort of input the field accepts.
  ///
  final String? hint;

  final TextInputType? keyboardType;

  ///Whether the form is able to receive user input.
  ///
  ///If false the text field is "disabled": it ignores taps and its decoration is rendered in grey.
  final bool enabled;

  ///The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  ///An optional method that validates an input. Returns an error string
  ///to display if the input is invalid, or null otherwise.
  ///
  ///if the field is required and no validation is givin
  ///the default validation will be applied.
  final FormFieldValidator<String>? validator;

  ///An optional value to initialize the form field to, or null otherwise.
  ///
  ///if a controller is givin the initial value will be omitted.
  final String? initialValue;

  //The padding for the input decoration's container.
  final EdgeInsetsGeometry? contentPadding;

  ///The max characters length which the user can enter.
  ///
  final int? maxLength;

  ///Defaults to `appTextTheme(context).caption` with [Colors.redAccent].
  ///
  final TextStyle? errorTextStyle;

  final List<TextInputFormatter>? inputFormatters;

  final bool automaticallyImplyDigitsOnlyFilter;

  final TextCapitalization textCapitalization;

  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final Function(String)? onChanged;

  final TextDirection? textDirection;
  final int? maxLines;
  final Color? fillColor;

  ///Creates a [FormField] that contains a custom feel.
  ///
  const CTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.hint,
    this.keyboardType,
    this.enabled = true,
    this.textInputAction,
    this.validator,
    this.initialValue,
    this.maxLength,
    this.contentPadding,
    this.errorTextStyle,
    this.inputFormatters,
    this.automaticallyImplyDigitsOnlyFilter = true,
    this.textCapitalization = TextCapitalization.none,
    this.suffixIcon,
    this.prefixIcon,
    this.textDirection,
    this.onChanged,
    this.maxLines,
    this.fillColor,
  }) : super(key: key);

  @override
  _CTextFieldState createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {
  late final TextEditingController _textEditingController;
  bool _showPassword = false;

  bool get _isNumberBased =>
      widget.keyboardType == TextInputType.phone ||
      widget.keyboardType == TextInputType.number;

  @override
  void initState() {
    _showPassword = widget.keyboardType == TextInputType.visiblePassword;
    if (widget.controller != null) {
      _textEditingController = widget.controller!;
    } else {
      _textEditingController = TextEditingController(text: widget.initialValue);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) _textEditingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CTextField oldWidget) {
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != null) {
      _textEditingController.text = widget.initialValue!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _buildTextFieldBody();
  }

  Widget _buildTextFieldBody() {
    return TextFormField(
      maxLines: widget.maxLines ?? 1,
      enabled: widget.enabled,
      controller: _textEditingController,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      validator: widget.validator,
      autocorrect: false,
      enableSuggestions: false,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: _showPassword,
      textDirection: widget.textDirection,
      cursorColor: CColors.primary,
      textCapitalization: widget.textCapitalization,
      style:
          context.theme.textTheme.bodyLarge!.copyWith(color: CColors.black70),
      inputFormatters: [
        if (widget.inputFormatters != null) ...widget.inputFormatters!,
        if (widget.automaticallyImplyDigitsOnlyFilter && _isNumberBased)
          FilteringTextInputFormatter.digitsOnly,
      ],
      maxLength: widget.maxLength,
      decoration: _buildDecoration(),
      autofocus: false,
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      hintText: widget.hint,
      // hintStyle: const TextStyle(color: Colors.black26),
      // errorStyle: widget.errorTextStyle ??
      //     Style.appTextTheme(context).caption?.copyWith(
      //           color: Colors.redAccent,
      // ),
      filled: true,
      fillColor: widget.fillColor ?? Colors.grey.shade100,
      border: _buildInputBorder(),
      focusedBorder: _buildInputBorder(),
      enabledBorder: _buildInputBorder(),
      disabledBorder: _buildInputBorder(),
      suffixIcon: _buildSuffixIcon(),
      prefixIcon: widget.prefixIcon == null
          ? null
          : IconTheme.merge(
              data: IconThemeData(color: CColors.primary, size: 20),
              child: widget.prefixIcon ?? const SizedBox.shrink(),
            ),
    );
  }

  InputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: Colors.grey.shade200,
        width: 0,
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIcon != null) return widget.suffixIcon!;
    return _buildShowPasswordButton();
  }

  Widget? _buildShowPasswordButton() {
    if (widget.keyboardType != TextInputType.visiblePassword) return null;
    final iconTheme = Style.appTheme.iconTheme;
    return IconButton(
      onPressed: () {
        if (mounted) setState(() => _showPassword = !_showPassword);
      },
      iconSize: iconTheme.size ?? 16,
      icon: Icon(
        _showPassword ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
        color: CColors.primary,
      ),
    );
  }
}
