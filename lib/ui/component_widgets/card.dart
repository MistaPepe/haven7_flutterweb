import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

//default template for card widget
class CardTemplateBox extends StatefulWidget {
  final int baseWidth;
  final int baseHeight;
  final Widget child;
  final Color color;
  final bool isCurved;
  final bool haveShadow;
  final bool useBackgroundStack;
  const CardTemplateBox(
      {super.key,
      required this.baseWidth,
      required this.baseHeight,
      required this.child,
      this.color = Colors.white,
      this.isCurved = true,
      this.haveShadow = false,
      this.useBackgroundStack = false});

  @override
  State<CardTemplateBox> createState() => _CardTemplateBoxState();
}

class _CardTemplateBoxState extends State<CardTemplateBox> {
  bool _isHovering = false;

  layoutCard() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Transform.scale(
        scale: _isHovering ? 1.015 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: (widget.useBackgroundStack!)
                ? Colors.transparent
                : widget.color,
            borderRadius: (widget.isCurved) ? BorderRadius.circular(10) : null,
            boxShadow: (widget.haveShadow)
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 0), // Changes the shadow position
                    )
                  ]
                : null,
          ),
          width: widget.baseWidth.toDouble(),
          height: widget.baseHeight.toDouble(),
          child: (widget.useBackgroundStack)
              ? useStack()
              : GestureDetector(
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: widget.child,
                ),
        ),
      ),
    );
  }

  useStack() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: ClipPath(
              // Custom clipper to define the wavy shape
              child: Container(
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
              ),
            ),
          ),
          // Top Wave

          GestureDetector(
            onTap: () {
              debugPrint('Card tapped.');
            },
            child: widget.child,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return layoutCard();
  }
}

class WaveClipper extends CustomClipper<Path> {
  final int number;
  WaveClipper(this.number);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40); // Start point
    path.quadraticBezierTo(size.width / 4, size.height, size.width / 2,
        size.height - 40); // First curve
    path.quadraticBezierTo(3 * size.width / 4, size.height - 80, size.width,
        size.height - 40); // Second curve
    path.lineTo(size.width, 0); // Close path to top-right corner
    path.close(); // Close the shape
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CardTemplateSimple extends StatelessWidget {
  final bool isCurved;
  final bool haveShadow;
  final int? baseWidth;
  final int? baseHeight;
  final Color? color;
  final Widget child;
  const CardTemplateSimple(
      {super.key,
      this.isCurved = true,
      this.haveShadow = true,
      this.color = Colors.white,
      required this.child,
      this.baseWidth,
      this.baseHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (baseHeight != null) ? baseHeight?.toDouble() : null,
      width: (baseWidth != null) ? baseWidth?.toDouble() : null,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: (isCurved) ? BorderRadius.circular(10) : null,
        boxShadow: (haveShadow)
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 0), // Changes the shadow position
                )
              ]
            : null,
      ),
      child: GestureDetector(
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: child,
      ),
    );
  }
}
