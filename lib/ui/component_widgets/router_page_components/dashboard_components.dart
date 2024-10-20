import 'package:flutter/material.dart';

import '../components.dart';

class CardStatisticsWrapper extends StatelessWidget {
  const CardStatisticsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      children: [
        CardTemplateBox(
            baseHeight: 135,
            baseWidth: 280,
            child: UpperCardTemplate(
              icon: Icons.monetization_on,
              title: 'Today Sales',
              numbers: 3000,
              percentage: 11,
            )),
        CardTemplateBox(
            baseHeight: 135,
            baseWidth: 280,
            child: UpperCardTemplate(
              icon: Icons.bar_chart,
              title: 'Today Sales',
              numbers: 3000,
              percentage: 10,
            )),
        CardTemplateBox(
            baseHeight: 135,
            baseWidth: 280,
            child: UpperCardTemplate(
              icon: Icons.shopping_cart,
              title: 'Today Sales',
              numbers: 3000,
              percentage: 10,
            )),
        CardTemplateBox(
            baseHeight: 135,
            baseWidth: 280,
            child: UpperCardTemplate(
              icon: Icons.money_off,
              title: 'Today Sales',
              numbers: 3000,
              percentage: 10,
            )),
      ],
    );
  }
}
//butu
