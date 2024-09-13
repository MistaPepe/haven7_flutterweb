export 'package:haven7_flutterweb/ui/responsive_layouts/desktop_layout.dart';
export 'package:haven7_flutterweb/ui/responsive_layouts/medium_layout.dart';
export 'package:haven7_flutterweb/ui/responsive_layouts/mobile_layout.dart';

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
      } else if (screenWidth < 1400) {
        return mediumSize;
      } else {
        return largeSize;
      }
    });
  }
}
