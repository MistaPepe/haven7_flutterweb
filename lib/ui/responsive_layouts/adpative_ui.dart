import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget smallSize;
  final Widget mediumSize;
  final Widget largeSize;
  const ResponsiveLayout(
      {super.key,
      required this.smallSize,
      required this.mediumSize,
      required this.largeSize});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double screenWidth = constraints.maxWidth;
      if (screenWidth < 600) {
        return smallSize;
      } else if (screenWidth < 1200) {
        return mediumSize;
      } else {
        return largeSize;
      }
    });
  }
}
