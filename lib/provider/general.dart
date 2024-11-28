import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

// drawer data {

class DrawerRouter {
  static bool isDrawerOpen = false;
  //XD HAHAHAHAH
  static List<bool> isHovered = [false, false, false, false, false, false];
  static String currentPage = 'Dashboard';
}

enum AdminDrawer {
  dashboard(
    name: 'Dashboard',
    router: '/',
    icon: Icons.home,
  ),
  statistics(
    name: 'Statistics',
    router: '/statistics',
    icon: Icons.leaderboard,
  ),
  products(name: 'Products', router: '/products', icon: Icons.inventory),
  customer(name: 'Customer', router: '/customer', icon: Icons.groups),
  news(name: 'News', router: '/news', icon: Icons.newspaper),

  account(name: 'Account', router: '/account', icon: Icons.person);

  const AdminDrawer(
      {required this.name, required this.router, required this.icon});

  final String name;
  final String router;
  final IconData icon;
}

// end drawer data

//screen data

class IsMouseInWidget extends Cubit<bool>{
  IsMouseInWidget() : super(false);
  

void toggleState() => emit(!state);

  ScrollPhysics get getIsMouseInAWidget {
  return (state)
      ? const NeverScrollableScrollPhysics()
      : const ClampingScrollPhysics();
}
}




double contraintOfPieChart = 0;
