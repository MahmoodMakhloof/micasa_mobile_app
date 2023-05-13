import 'package:flutter/material.dart';

export 'layout_builder.dart';

const kCustomButtonTextStyle = TextStyle(color: Colors.black);

const double kFloatingButtonBottomClearance = 60;

extension GetAppTheme on BuildContext {
  ///Returns the current app context using [BuildContext].
  ThemeData get theme => Theme.of(this);
}

///[BorderRadius] Wrapper, which contains all borderRadiuses used as a const.
///
class KBorders {
  const KBorders._();
  static const bc30 = BorderRadius.all(Radius.circular(30));
  static const bc20 = BorderRadius.all(Radius.circular(20));
  static const bc15 = BorderRadius.all(Radius.circular(15));
  static const bc10 = BorderRadius.all(Radius.circular(10));
  static const bc5 = BorderRadius.all(Radius.circular(5));
  static const bcb15 = BorderRadius.vertical(bottom: Radius.circular(15.0));
}

///[EdgeInsets] Wrapper, which contains all EdgeInsets used as a const.
///
class KEdgeInsets {
  const KEdgeInsets._();
  static const h20 = EdgeInsets.symmetric(horizontal: 20);
  static const v20 = EdgeInsets.symmetric(vertical: 20);
  static const h15 = EdgeInsets.symmetric(horizontal: 15);
  static const v15 = EdgeInsets.symmetric(vertical: 15);
  static const h10 = EdgeInsets.symmetric(horizontal: 10);
  static const v10 = EdgeInsets.symmetric(vertical: 10);
  static const h5 = EdgeInsets.symmetric(horizontal: 5);
  static const v5 = EdgeInsets.symmetric(vertical: 5);
  static const screen = EdgeInsets.fromLTRB(20, 20, 20, 0);
}

///Wraps [SizedBox] and returns a fixed amount of spacing to use in fixable widget like [Row] and [Column].
///
class Space extends SizedBox {
  const Space.h40() : super(width: 40);
  const Space.v40() : super(height: 40);

  const Space.h30() : super(width: 30);
  const Space.v30() : super(height: 30);

  const Space.h20() : super(width: 20);
  const Space.v20() : super(height: 20);

  const Space.h15() : super(width: 15);
  const Space.v15() : super(height: 15);

  const Space.h10() : super(width: 10);
  const Space.v10() : super(height: 10);

  const Space.h8() : super(width: 8);
  const Space.v8() : super(height: 8);

  const Space.h5() : super(width: 5);
  const Space.v5() : super(height: 5);

  const Space.h2() : super(width: 2);
  const Space.v2() : super(height: 2);

  const Space.dot()
      : super(
            width: 15,
            child: const Icon(Icons.circle, size: 4, color: Colors.white60));

  Widget toSliver() {
    return SliverToBoxAdapter(child: this);
  }
}

///Get random primary material color depending on [seed].
RandomColor getRandomColor( {String seed = 'seed'}) {
  const colors = [
    RandomColor(Color(0xff002B5B), Brightness.dark),
    RandomColor(Color(0xff256D85), Brightness.dark),
    RandomColor(Color(0xff2B4865), Brightness.dark),
    RandomColor(Color(0xff5800FF), Brightness.dark),
    RandomColor(Color(0xff0096FF), Brightness.light),
    RandomColor(Color(0xff395B64), Brightness.dark),
    RandomColor(Color(0xff495C83), Brightness.dark),
    RandomColor(Color(0xff7A86B6), Brightness.light),
    RandomColor(Color(0xff90C8AC), Brightness.light),
    RandomColor(Color(0xff73A9AD), Brightness.light),
    RandomColor(Color(0xffAEDBCE), Brightness.light),
    RandomColor(Color(0xff635666), Brightness.dark),
    RandomColor(Color(0xff5B4B8A), Brightness.light),
    RandomColor(Color(0xff4C3575), Brightness.dark),
    RandomColor(Color(0xff3BACB6), Brightness.light),
    RandomColor(Color(0xff2F8F9D), Brightness.light),
    RandomColor(Color(0xff06283D), Brightness.dark),
  ];
  return colors[_stringToAscii(seed) % colors.length];
}

int _stringToAscii(String s) {
  int v = 0;
  for (var i = 0; i < s.length; i++) {
    v += s.codeUnitAt(i);
  }
  return v;
}

//Text theme
extension TextThemed on TextTheme {
  TextStyle? get bodyText3 {
    return bodyText1?.copyWith(
      fontSize: 18,
    );
  }
}

@immutable
class RandomColor {
  final Color color;
  final Brightness brightness;
  const RandomColor(this.color, this.brightness);
}
