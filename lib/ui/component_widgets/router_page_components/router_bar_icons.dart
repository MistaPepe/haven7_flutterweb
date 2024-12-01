import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../provider/provider.dart';
import '../components_and_routers.dart';

class CustomDrawerBuilder extends StatefulWidget {
  final bool? drawerForceOpen;
  const CustomDrawerBuilder({super.key, this.drawerForceOpen});

  bool get drawerOpen => drawerForceOpen ?? DrawerRouter.isDrawerOpen;

  //builder method to build a single row of router, for its icon and name if opened
  Widget routerRow(
      BuildContext context, String name, IconData icon, bool isHover) {
    List<Color> getGradientColors() {
      if (DrawerRouter.currentPage == name) {
        return [
          const Color.fromARGB(255, 132, 233, 247),
          const Color.fromARGB(255, 74, 167, 243)
        ];
      } else if (isHover) {
        return [
          const Color.fromARGB(255, 81, 120, 247),
          const Color.fromARGB(255, 21, 61, 192)
        ];
      } else {
        return [const Color.fromARGB(0, 245, 55, 55), Colors.transparent];
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Tooltip(
        waitDuration: const Duration(milliseconds: 1000),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey.withOpacity(0.8),
          border: Border.all(color: Colors.white),
        ),
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(8),
        message: name,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: getGradientColors()),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: (drawerOpen)
              ? const EdgeInsets.fromLTRB(20, 12, 0, 12)
              : const EdgeInsets.fromLTRB(16, 12, 0, 12),
          child: Row(
            children: [
              Icon(icon,
                  color: (DrawerRouter.currentPage == name)
                      ? const Color.fromARGB(255, 1, 21, 87)
                      : Colors.white,
                  size: 28),
              if (drawerOpen) const SizedBox(width: 15),
              if (drawerOpen)
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    color: (DrawerRouter.currentPage == name)
                        ? const Color.fromARGB(255, 1, 21, 87)
                        : Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

///this is only the top part, the logo and the name of the website on the top left corner
///so its kinda misleading but it is planned to have the bottom part of routers as a child
///this is the  bottom routers    |
///                               V
  Widget layoutDrawer(Widget routerList) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(
            5, 5, 5, 100), //adjust to constraint widgets inside
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: (drawerOpen)
                      ? const EdgeInsets.fromLTRB(0, 20, 10, 20)
                      : const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    width: (drawerOpen) ? 70 : 40,
                    height: (drawerOpen) ? 70 : 40,
                    child: Image.asset(
                      'lib/src/h7logo.png',
                    ),
                  ),
                ),
                if (drawerOpen)
                  Text(
                    'Haven 7',
                    style: GoogleFonts.lato(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      letterSpacing: 1.2,
                    ),
                  ),
              ],
            ),
            Expanded(flex: 7, child: routerList),
          ],
        ));
  }

  @override
  State<CustomDrawerBuilder> createState() => _CustomDrawerBuilderState();
}

class _CustomDrawerBuilderState extends State<CustomDrawerBuilder> {
  
  Widget tabControl() {
  return Navigator(
    key: GlobalKey<NavigatorState>(), // Unique key for nested navigation
    initialRoute: '/dashboard', // Default route
    onGenerateRoute: (RouteSettings settings) {
      WidgetBuilder builder;
      switch (settings.name) {
        case '/dashboard':
          builder = (BuildContext _) => const DashboardLayout();
          break;
        case '/statistics':
          builder = (BuildContext _) => const StatisticsLayout(); // Replace with actual layout
          break;
        case '/products':
          builder = (BuildContext _) => const ProductsLayout(); // Replace with actual layout
          break;
        case '/customer':
          builder = (BuildContext _) => const CustomerLayout(); // Replace with actual layout
          break;
        case '/news':
          builder = (BuildContext _) => const NewsLayout(); // Replace with actual layout
          break;
        case '/account':
          builder = (BuildContext _) => const AccountLayout(); // Replace with actual layout
          break;
        default:
          builder = (BuildContext _) => const Placeholder();
      }
      return MaterialPageRoute(builder: builder, settings: settings);
    },
  );
}
  
  Widget routerDrawer() {
    ///method to section each router, either top or bottom routers
    List<Widget> routerListMap({bool low = false}) {
      List<String> lowerPart = [
        'News',
        'Account',
      ];

      return AdminDrawer.values.asMap().entries.where((entry) {
        final String itemName = entry.value.name;
        return (low)
            ? lowerPart.contains(itemName)
            : !lowerPart
                .contains(itemName); // Skip if item name is in lowerPart
      }).map((entry) {
        final int index = entry.key;
        final AdminDrawer item = entry.value;
        return MouseRegion(
          onEnter: (_) => setState(() {
            DrawerRouter.isHovered[index] = true;
          }),
          onExit: (_) => setState(() {
            DrawerRouter.isHovered[index] = false;
          }),
          child: GestureDetector(
            onTap: () {
              setState(() {
                DrawerRouter.currentPage = item.name;
              });
            },
            child: widget.routerRow(
                context, item.name, item.icon, DrawerRouter.isHovered[index]),
          ),
        );
      }).toList();
    }

    return Column(
      children: [
        //top router like dashboard and customer
        Expanded(
          child: ListView(children: [
            const Divider(),
            ...routerListMap(),
            const Divider(),
          ]),
        ),
        //bottom router like account and news
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            const Divider(),
            ...routerListMap(low: true),
          ]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutDrawer(routerDrawer());
  }
}

class CustomAnimatedDrawer extends StatelessWidget {
  const CustomAnimatedDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: DrawerRouter.isDrawerOpen ? 250 : 75,
        height: double.infinity,
        child: CustomDrawerBuilder());
  }
}

class CustomConcealingDrawer extends StatelessWidget {
  const CustomConcealingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: const BeveledRectangleBorder(),
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 28, 41, 158),
                  Color.fromARGB(255, 0, 49, 212),
                  Color.fromARGB(255, 26, 102, 233),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            height: double.infinity,
            child: const CustomDrawerBuilder(
              drawerForceOpen: true,
            )));
  }
}


// // building block for icon and the name of the router
// //builds row to return an icon and name only individually
// mixin RouterList {
//   Widget routerRow(
//       BuildContext context, String name, IconData icon, bool isHover,
//       {bool? forceDrawerOpen}) {

//     bool drawerOpen = forceDrawerOpen ?? DrawerRouter.isDrawerOpen;
//     List<Color> getGradientColors() {
//       if (DrawerRouter.currentPage == name) {
//         return [
//           const Color.fromARGB(255, 132, 233, 247),
//           const Color.fromARGB(255, 74, 167, 243)
//         ];
//       } else if (isHover) {
//         return [
//           const Color.fromARGB(255, 81, 120, 247),
//           const Color.fromARGB(255, 21, 61, 192)
//         ];
//       } else {
//         return [const Color.fromARGB(0, 245, 55, 55), Colors.transparent];
//       }
//     }

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: Tooltip(
//         waitDuration: const Duration(milliseconds: 1000),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.blueGrey.withOpacity(0.8),
//           border: Border.all(color: Colors.white),
//         ),
//         textStyle: const TextStyle(
//           fontSize: 12,
//           color: Colors.white,
//         ),
//         padding: const EdgeInsets.all(8),
//         message: name,
//         child: Container(
//           margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: getGradientColors()),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           padding: (drawerOpen)
//               ? const EdgeInsets.fromLTRB(20, 12, 0, 12)
//               : const EdgeInsets.fromLTRB(16, 12, 0, 12),
//           child: Row(
//             children: [
//               Icon(icon,
//                   color: (DrawerRouter.currentPage == name)
//                       ? const Color.fromARGB(255, 1, 21, 87)
//                       : Colors.white,
//                   size: 28),
//               if (drawerOpen) const SizedBox(width: 15),
//               if (drawerOpen)
//                 Text(
//                   name,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: (DrawerRouter.currentPage == name)
//                         ? const Color.fromARGB(255, 1, 21, 87)
//                         : Colors.white,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // blueprint that access the admindrawer class to form drawer

// abstract class DrawerRouterList extends StatefulWidget {
//   const DrawerRouterList({super.key});

//   //widget to override
//   Widget container(Widget routerList);

//   ///method to create a child widget for the container on top which will be override by the consumer
//   ///this method also create 
//   Widget layoutDrawer(Widget routerList, {bool? forceDrawerOpen}) {
//     bool drawerOpen = forceDrawerOpen ?? DrawerRouter.isDrawerOpen;
//     return Padding(
//         padding: const EdgeInsets.fromLTRB(
//             5, 5, 5, 100), //adjust to constraint widgets inside
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: (drawerOpen)
//                       ? const EdgeInsets.fromLTRB(0, 20, 10, 20)
//                       : const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 250),
//                     curve: Curves.easeInOut,
//                     width: (drawerOpen) ? 70 : 40,
//                     height: (drawerOpen) ? 70 : 40,
//                     child: Image.asset(
//                       'lib/src/h7logo.png',
//                     ),
//                   ),
//                 ),
//                 if (drawerOpen)
//                   Text(
//                     'Haven 7',
//                     style: GoogleFonts.lato(
//                       fontSize: 25,
//                       fontWeight: FontWeight.w900,
//                       color: const Color.fromARGB(255, 255, 255, 255),
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//               ],
//             ),
//             Expanded(flex: 7, child: routerList),
//           ],
//         ));
//   }

//   @override
//   State<DrawerRouterList> createState() => _DrawerRouterListState();
// }

// class _DrawerRouterListState extends State<DrawerRouterList> with RouterList {

//   Widget routerDrawer() {
//   ///method to section each router, either top or bottom routers
//   List<Widget> routerListMap({bool low = false}) {
//     List<String> lowerPart = [
//       'News',
//       'Account',
//     ];

//     return AdminDrawer.values.asMap().entries.where((entry) {
//       final String itemName = entry.value.name;
//       return (low)
//           ? lowerPart.contains(itemName)
//           : !lowerPart.contains(itemName); // Skip if item name is in lowerPart
//     }).map((entry) {
//       final int index = entry.key;
//       final AdminDrawer item = entry.value;
//       return MouseRegion(
//         onEnter: (_) => setState(() {
//           DrawerRouter.isHovered[index] = true;
//         }),
//         onExit: (_) => setState(() {
//           DrawerRouter.isHovered[index] = false;
//         }),
//         child: GestureDetector(
//           onTap: () {
//             setState(() {
//               DrawerRouter.currentPage = item.name;
//             });
//           },
//           child: routerRow(
//               context, item.name, item.icon, DrawerRouter.isHovered[index]),
//         ),
//       );
//     }).toList();
//   }

//     return Column(
//       children: [
//         //top router like dashboard and customer
//         Expanded(
//           child: ListView(children: [
//             const Divider(),
//             ...routerListMap(),
//             const Divider(),
//           ]),
//         ),
//         //bottom router like account and news
//         Expanded(
//           child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
//             const Divider(),
//             ...routerListMap(low: true),
//           ]),
//         )
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context, ) {
//     return widget.container((routerDrawer()));
//   }
// }

// class CustomDrawerMediumAndDesktop extends DrawerRouterList {
//   final bool? drawerOpen;
//   const CustomDrawerMediumAndDesktop({super.key, this.drawerOpen});

//   @override
//   Widget container(Widget routerList) {
//     return AnimatedContainer(
//         duration: const Duration(milliseconds: 250),
//         width: DrawerRouter.isDrawerOpen ? 250 : 75,
//         height: double.infinity,
//         color: const Color.fromARGB(255, 28, 41, 158),
//         child: layoutDrawer(routerList, forceDrawerOpen: drawerOpen));
//   }
// }

// class CustomDrawerMobile extends DrawerRouterList {
//   const CustomDrawerMobile({super.key});

//   @override
//   Widget container(routerList) {
//     return Drawer(
//         shape: const BeveledRectangleBorder(),
//         child: Container(
//             height: double.infinity,
//             color: const Color.fromARGB(255, 28, 41, 158),
//             child: layoutDrawer(routerList)));
//   }
// }
//////////////////////////////////////////////
///
///
///
///
///
///
///
///
///
///
///
///



