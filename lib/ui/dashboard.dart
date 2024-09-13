import 'package:flutter/material.dart';
import 'package:haven7_flutterweb/ui/responsive_layouts/responsive_layout.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(smallSize: MobileLayout(),
      mediumSize: MediumLayout(),
      largeSize: DesktopLayout(),),
    );
}
}
