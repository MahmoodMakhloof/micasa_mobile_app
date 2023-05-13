import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shca/widgets/snack_bars.dart';






Future<void> copyToClipboard(String text) async {
  await Clipboard.setData(ClipboardData(text: text.trim()));
  const CSnackBar.custom(
    avoidNavigationBar: false,
    icon: Icon(FontAwesomeIcons.clipboard),
    messageText: "Copied to clip board",
  ).showWithoutContext();
}
