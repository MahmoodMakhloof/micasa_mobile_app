import 'package:flutter/material.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:utilities/utilities.dart';

const double kCustomOutlinedButtonHeight = 46;

class _CustomOutlinedButtonHeroTag {
  const _CustomOutlinedButtonHeroTag();
  @override
  String toString() => "CustomOutlinedButtonHeroTag()";
}

///Custom elevalted button with loading indicator.
///
///See also:
///- `ElevatedButton()`
///
class CustomOutlinedButton extends StatefulWidget {
  ///Callback triggered when the button is pressed for one time.
  final VoidCallback? onPressed;

  ///Button child.
  final Widget child;

  ///When `true` a loading indicator shows and the button becomes not responding to touch.
  final bool isLoading;

  ///Loading indicator widget, shows when the `isLoading` property is `True`
  final Widget? progressIndicator;

  ///Button's border radius, defaults to `BorderRadius.all(Radius.circular(5))`.
  final BorderRadiusGeometry? borderRadius;

  ///determine if the current button is enabled and the user can press or not,
  ///defaults to `true`
  final bool enabled;

  final Color? backgroundColor;
  final Color? borderColor;

  final Object? heroTag;

  ///Custom elevated button with loading indicator.
  ///
  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.progressIndicator,
    this.borderRadius,
    this.enabled = true,
    this.backgroundColor = Colors.white,
    this.heroTag,
    this.borderColor,
  }) : super(key: key);

  @override
  _CustomOutlinedButtonState createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  bool _isLoading = false;
  bool _isEnabled = true;

  @override
  void initState() {
    _isLoading = widget.isLoading;
    _isEnabled = widget.enabled;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomOutlinedButton oldWidget) {
    if (widget.isLoading != oldWidget.isLoading) {
      setState(() => _isLoading = widget.isLoading);
    }
    if (widget.enabled != oldWidget.enabled) {
      setState(() => _isEnabled = widget.enabled);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.heroTag ?? const _CustomOutlinedButtonHeroTag(),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              borderRadius:
                  (widget.borderRadius ?? KBorders.bc10) as BorderRadius,
              onTap: () {
                if (_isLoading || !_isEnabled) return;
                widget.onPressed?.call();
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                constraints: const BoxConstraints.tightFor(
                  width: double.infinity,
                  height: kCustomOutlinedButtonHeight,
                ),
                decoration: _buildButtonDecoration(),
                child: Center(
                  child: DefaultTextStyle(
                    style: Style.appTextTheme(context).button?.copyWith(
                            color: widget.borderColor ?? CColors.primary,
                            fontWeight: FontWeight.bold) ??
                        const TextStyle(),
                    child: widget.child,
                  ),
                ),
              ),
            ),
            if (_isLoading || !_isEnabled) ...[
              Positioned.fill(
                child: Container(
                  key: const Key("CustomOutlinedButton_overlay"),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: widget.borderRadius ?? KBorders.bc10,
                  ),
                ),
              ),
              if (_isLoading)
                widget.progressIndicator ?? _buildDefaultLoadingIndicator(),
            ]
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildButtonDecoration() {
    return BoxDecoration(
      color: widget.backgroundColor ?? Colors.white,
      borderRadius: widget.borderRadius ?? KBorders.bc10,
      border:
          Border.all(color: widget.borderColor ?? CColors.primary, width: 2),
    );
  }

  Widget _buildDefaultLoadingIndicator() {
    return SizedBox.fromSize(
      size: const Size.square(20),
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: widget.borderColor,
      ),
    );
  }
}
