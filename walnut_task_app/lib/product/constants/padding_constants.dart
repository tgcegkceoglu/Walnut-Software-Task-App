import 'package:flutter/material.dart';

@immutable
class PaddingConstants {
  const PaddingConstants._();

  static EdgeInsets pageDynamicTopNormalGap(BuildContext context) {
    return EdgeInsets.fromLTRB(
      16,
      MediaQuery.of(context).padding.top + 16,
      16,
      16,
    );
  }

  static const EdgeInsets zero = EdgeInsets.zero;

  // horizontal gap
  static const EdgeInsets pageHorizontalNormal = EdgeInsets.symmetric(
    horizontal: 16,
  );

  // vertical gap
  static const EdgeInsets pageVerticalLow = EdgeInsets.symmetric(vertical: 8);

  // all gap
  static const EdgeInsets pageAllNormal = EdgeInsets.all(16);
  static const EdgeInsets pageAllLow = EdgeInsets.all(8);

  // bottom gap
  static const EdgeInsets bottomLow = EdgeInsets.all(8);

  // TRB gap
  static const EdgeInsets topTRBLow = EdgeInsets.fromLTRB(16, 8, 16, 16);

  // button gap
  static const EdgeInsets buttonLow = EdgeInsets.fromLTRB(8, 16, 8, 16);

  // item gap
  static const EdgeInsets itemNormal = EdgeInsets.symmetric(horizontal: 16,vertical: 12,);
}
