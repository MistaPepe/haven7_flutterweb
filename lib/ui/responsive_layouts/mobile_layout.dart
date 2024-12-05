import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../component_widgets/components_and_routers.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
 bool _showAppBar = true; // Tracks the visibility of the app bar
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      // Hide AppBar on scroll down
      if (_showAppBar) setState(() => _showAppBar = false);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      // Show AppBar on scroll up
      if (!_showAppBar) setState(() => _showAppBar = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomConcealingDrawer(),
      extendBodyBehindAppBar: true, // Allows body to go behind the AppBar
      body: NestedScrollView(
        controller: _scrollController, // Attach the scroll controller
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 100.0, // Height when expanded
              floating: false,
              pinned: _showAppBar, // Toggles the AppBar visibility
              backgroundColor: Colors.transparent,
              elevation: 0, // Removes shadow
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  "HAVEN 7",
                  style: TextStyle(color: Colors.white),
                ),
                background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 70, 79, 158),
                Color.fromARGB(255, 0, 49, 212),
                Color.fromARGB(255, 26, 74, 233),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),)
              ),
            ),
          ];
        },
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 28, 41, 158),
                Color.fromARGB(255, 0, 49, 212),
                Color.fromARGB(255, 26, 74, 233),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const DashboardLayout(), // Your body content here
        ),
      ),
    );
  }
}

