import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

import '../core/helpers/style_config.dart';

const double kCustomButtonHeight = 46;

class _CustomButtonHeroTag {
  const _CustomButtonHeroTag();
  @override
  String toString() => "CustomButtonHeroTag()";
}

///Custom elevalted button with loading indicator.
///
///See also:
///- `ElevatedButton()`
///
class CustomButton extends StatefulWidget {
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

  final Gradient? bgGradient;

  final Object? heroTag;

  ///Custom elevated button with loading indicator.
  ///
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.progressIndicator,
    this.borderRadius,
    this.enabled = true,
    this.backgroundColor,
    this.bgGradient,
    this.heroTag,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isLoading = false;
  bool _isEnabled = true;

  @override
  void initState() {
    _isLoading = widget.isLoading;
    _isEnabled = widget.enabled;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomButton oldWidget) {
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
      tag: widget.heroTag ?? const _CustomButtonHeroTag(),
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
                  height: kCustomButtonHeight,
                ),
                decoration: _buildButtonDecoration(),
                child: Center(
                  child: DefaultTextStyle(
                    style: Style.appTextTheme(context).button?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold) ??
                        const TextStyle(),
                    child: widget.child,
                  ),
                ),
              ),
            ),
            if (_isLoading || !_isEnabled) ...[
              Positioned.fill(
                child: Container(
                  key: const Key("CustomButton_overlay"),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: widget.borderRadius ?? KBorders.bc5,
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
      color: widget.backgroundColor ?? CColors.primary,
      borderRadius: widget.borderRadius ?? KBorders.bc5,
      gradient: widget.bgGradient,
    );
  }

  Widget _buildDefaultLoadingIndicator() {
    return SizedBox.fromSize(
      size: const Size.square(20),
      child: const CircularProgressIndicator(
        strokeWidth: 2,
      ),
    );
  }
}
