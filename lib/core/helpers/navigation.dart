import 'package:flutter/material.dart';

extension NavigateTo on BuildContext {
  Future<T?> navigateTo<T>(
    Widget page, {
    bool rootNavigator = false,
  }) {
    return Navigator.of(this, rootNavigator: rootNavigator).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  Future<T?> goTo<T>(
    Widget page, {
    bool rootNavigator = false,
  }) {
    return Navigator.of(
      this,
      rootNavigator: rootNavigator,
    ).pushAndRemoveUntil<T>(
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (_) => false,
    );
  }

  void popUntil<T>({bool rootNavigator = false}) {
    return Navigator.of(
      this,
      rootNavigator: rootNavigator,
    ).popUntil(
      (_) => false,
    );
  }

  Future<T?> navigateForward<T>(
    Widget page, {
    bool rootNavigator = false,
  }) {
    return Navigator.of(
      this,
      rootNavigator: rootNavigator,
    ).pushReplacement(MaterialPageRoute(builder: (context) => page));
  }
}
