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
      drawer: CustomConcealingDrawer(),
      body: Container(
        color: Color.fromARGB(255, 236, 236, 236),
        child: ListView(
          children: [
           CardStatisticsWrapper(),
            Text('butu'),
          ],
        ),
      ),
    );
  }
}

