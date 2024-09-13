import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const Map<String, Icon> sideBarIcons = {
  'Home/Dashboard': Icon(Icons.home),
  'Account': Icon(Icons.account_circle),
  'Contacts': Icon(Icons.contacts),
  'News': Icon(Icons.newspaper),
  'Help': Icon(Icons.help_outline),
};

 final pieChartData = 
 [
      PieChartSectionData(
        color: Colors.blue,
        value: 25,
        title: 'Section 1',
        radius: 20,
      ),
      PieChartSectionData(
        color: Colors.green,
        value: 35,
        title: 'Section 2',
        radius: 30,
      ),
      PieChartSectionData(
        color: Colors.yellow,
        value: 40,
        title: 'Section 3',
        radius: 40,
      ),
    ];
