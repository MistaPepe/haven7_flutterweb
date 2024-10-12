import 'package:flutter/material.dart';
import '../component_widgets/components.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      drawer: CustomDrawerMobile(),
      body: Center(
        child: Column(
          children: [
            Stack(children: [
            ]),
            Text('butu'),
          ],
        ),
      ),
    );
  }
}

