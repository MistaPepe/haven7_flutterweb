import 'package:flutter/material.dart';

class MediumLayout extends StatefulWidget {
  const MediumLayout({super.key});

  @override
  State<MediumLayout> createState() => _MediumLayoutState();
}

class _MediumLayoutState extends State<MediumLayout> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: CustomDrawer(),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          top: 0,
          left: 20, // Adjust the width as needed
          width: _isOpen ? 59 : 200,
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: Colors.grey[200],
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSideBarIcon(),
              ],
            )
            // child: ListView(
            //   children: [
            //     ListTile(
            //       leading: IconButton(
            //         icon: Icon(_isOpen ? Icons.close : Icons.menu),
            //         onPressed: () {
            //           setState(() {
            //             _isOpen = !_isOpen;
            //           });
            //         },
            //       ),
            //       title: !_isOpen ? Text('Home') : Text(''),
            //       onTap: () {
            //         // Handle navigation
            //       },
            //     ),
            //     ListTile(
            //       leading: IconButton(
            //         icon: const Icon(Icons.home),
            //         onPressed: () {
            //           setState(() {
            //             _isOpen = !_isOpen;
            //           });
            //         },
            //       ),
            //       title: !_isOpen ? Text('Home') : Text(''),
            //       onTap: () {
            //         // Handle navigation
            //       },
            //     ),
            //     // Add more ListTile items as needed
            //   ],
            // ),
          ),
        ),
      ],
    );
  }
}

class CustomSideBarIcon extends StatefulWidget {
  const CustomSideBarIcon({super.key});

  @override
  State<CustomSideBarIcon> createState() => _CustomSideBarIconState();
}

class _CustomSideBarIconState extends State<CustomSideBarIcon> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Icon(Icons.home),
          SizedBox(width: 8),
          Text('Home')
        ],
      ),
    );
  }
}
