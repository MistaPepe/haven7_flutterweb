import 'package:flutter/material.dart';

import '../components.dart';


// upper card statistics, widgets to show average info
class CardStatisticsWrapper extends StatelessWidget {
  const CardStatisticsWrapper({super.key});

  static const int _baseWidth = 280;
  static const int _baseHeight = 150;
  

  static const List<Widget> _cardContent = [
    Expanded(
      child: CardTemplateBox(
          baseHeight: _baseHeight,
          baseWidth: _baseWidth,
          child: UpperCardTemplate(
            icon: Icons.monetization_on,
            title: 'Today\'s earning',
            numbers: 3000,
            percentage: 11,
          )),
    ),
    Expanded(
      child: CardTemplateBox(
          baseHeight: _baseHeight,
          baseWidth: _baseWidth,
          child: UpperCardTemplate(
            icon: Icons.bar_chart,
            title: 'Monthly Earnings',
            numbers: 3000,
            percentage: 10,
          )),
    ),
    Expanded(
      child: CardTemplateBox(
          baseHeight: _baseHeight,
          baseWidth: _baseWidth,
          child: UpperCardTemplate(
            icon: Icons.shopping_cart,
            title: 'Total Orders',
            numbers: 3000,
            percentage: 10,
          )),
    ),
    Expanded(
      child: CardTemplateBox(
          baseHeight: _baseHeight,
          baseWidth: _baseWidth,
          child: UpperCardTemplate(
            icon: Icons.money_off,
            title: 'Expenses',
            numbers: 3000,
            percentage: 10,
          )),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      buildWrap() {
        if (constraint.maxWidth > 1070) {
          return const Row(
            children: _cardContent,
          );
        } else {
          return SizedBox(
            child: Column(
              children: [
                Row(
                  children: [_cardContent[0], _cardContent[1]],
                ),
                Row(
                  children: [_cardContent[2], _cardContent[3]],
                )
              ],
            ),
          );
        }
      }

      return buildWrap();
    });
  }
}
