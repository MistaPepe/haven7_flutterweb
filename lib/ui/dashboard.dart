import 'package:flutter/material.dart';
import 'package:haven7_flutterweb/ui/responsive_layouts/adpative_ui.dart';
import 'package:haven7_flutterweb/ui/responsive_layouts/desktop_layout.dart';
import 'package:haven7_flutterweb/ui/responsive_layouts/medium_layout.dart';
import 'package:haven7_flutterweb/ui/responsive_layouts/mobile_layout.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(smallSize: MobileLayout(),
    mediumSize: MediumLayout(),
    largeSize: DesktopLayout(),);
}
}
