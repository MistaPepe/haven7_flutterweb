import 'package:flutter/material.dart';

import '../components.dart';

class CardStatisticsWrapper extends StatefulWidget {
  const CardStatisticsWrapper({super.key});

  @override
  State<CardStatisticsWrapper> createState() => _CardStatisticsWrapperState();
}

class _CardStatisticsWrapperState extends State<CardStatisticsWrapper> {
 

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [CardTemplate(
                            baseWidth: 200, baseHeight: 75, child: Container()),
                        CardTemplate(
                            baseWidth: 200, baseHeight: 75, child: Container()),
                        CardTemplate(
                            baseWidth: 200, baseHeight: 75, child: Container()),
                        CardTemplate(
                            baseWidth: 200, baseHeight: 75, child: Container()),],);
  }
}