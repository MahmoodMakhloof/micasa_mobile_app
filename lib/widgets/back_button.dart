import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  final Color? color;
  const MyBackButton({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          CupertinoIcons.arrow_left,
          color: color,
        ));
  }
}
