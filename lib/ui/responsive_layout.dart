import 'package:haven7_flutterweb/ui/responsive_layouts/desktop_layout.dart';
import 'package:haven7_flutterweb/ui/responsive_layouts/medium_layout.dart';
import 'package:haven7_flutterweb/ui/responsive_layouts/mobile_layout.dart';

import 'package:flutter/material.dart';

import '../provider/provider.dart';


class Websitelayout extends StatefulWidget {
  const Websitelayout({super.key});

  @override
  State<Websitelayout> createState() => _WebsitelayoutState();
}

class _WebsitelayoutState extends State<Websitelayout> {
   @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(
        smallSize: MobileLayout(),
        mediumSize: MediumLayout(),
        largeSize: DesktopLayout(),
      ),
    );
  }
}


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
      if (screenWidth < 700) {
        DrawerRouter.isDrawerOpen = true;
        return smallSize;
      } else if (screenWidth < 1400) {
        DrawerRouter.isDrawerOpen = false;
        return mediumSize;
      } else {
        DrawerRouter.isDrawerOpen = true;
        return largeSize;
      }
    });
  }
}

