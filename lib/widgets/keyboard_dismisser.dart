import 'package:flutter/material.dart';

///Dismiss keyboard.
class KeyboardDismissal extends StatelessWidget {
  ///The child that has a text field and needs to dismiss it when touch outside.
  final Widget child;

  ///Dismiss keyboard.
  const KeyboardDismissal({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
