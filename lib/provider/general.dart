import 'package:flutter/material.dart';

// drawer data {

class DrawerRouter {
  static bool isDrawerOpen = false;
  //XD HAHAHAHAH
  static List<bool> isHovered = [false, false, false, false, false];
  static String currentPage = 'Account';
}


enum AdminDrawer {
  dashboard(
    name: 'Dashboard',
    router: '/',
    icon: Icons.home,
  ),
  account(name: 'Account', router: '/account', icon: Icons.person),
  portfolio(
    name: 'Portfolio',
    router: '/portfolio',
    icon: Icons.leaderboard,
  ),
  customer(name: 'Customer', router: '/customer', icon: Icons.groups),
  news(name: 'News', router: '/news', icon: Icons.newspaper);

  const AdminDrawer(
      {required this.name, required this.router, required this.icon});

  final String name;
  final String router;
  final IconData icon;
}



// end drawer data
