import 'package:flutter/material.dart';

typedef LayoutWidgetBuilder = Widget Function(
  BuildContext context,
  Orientation orientation,
  BoxConstraints constraints,
);

class CLayoutBuilder extends StatelessWidget {
  //The [builder] argument must not be null.
  final LayoutWidgetBuilder builder;

  const CLayoutBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Orientation orientation =
            constraints.maxWidth > constraints.maxHeight ? Orientation.landscape : Orientation.portrait;
        return builder(context, orientation, constraints);
      },
    );
  }
}
