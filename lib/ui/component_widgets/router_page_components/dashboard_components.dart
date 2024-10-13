import 'package:flutter/material.dart';

import '../components.dart';

class CardStatisticsWrapper extends StatelessWidget {
  const CardStatisticsWrapper({super.key});

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

class UpperCardTemplate extends StatelessWidget {
  const UpperCardTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

