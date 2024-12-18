import 'package:flutter/material.dart';



//default template for card widget
// this widget have future build in it, for widgets that needs cloud data
class CardTemplateBox extends StatefulWidget {
  final int baseWidth;
  final int baseHeight;
  final Widget child;
  final Color color;
  final bool isCurved;
  final bool haveShadow;
  final bool useBackgroundStack;
  final bool shouldEnlarge;
  const CardTemplateBox(
      {super.key,
      required this.baseWidth,
      required this.baseHeight,
      required this.child,
      this.color = Colors.white,
      this.isCurved = true,
      this.haveShadow = false,
      this.useBackgroundStack = false,
      this.shouldEnlarge = true});

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
        scale: (_isHovering && widget.shouldEnlarge)? 1.015 : 1.0,
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
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ClipPath(
             // clipper: ,// Custom clipper to define the wavy shape
              child: Container(
               decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(137, 0, 98, 245),
              Color.fromARGB(83, 67, 70, 255),
              Color.fromARGB(181, 39, 53, 255),
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

//simpler card template if just wanting white card
class CardTemplateSimple extends StatelessWidget {
  final bool isCurved;
  final bool haveShadow;
  final double? baseWidth;
  final double? baseHeight;
  final double? padding;
  final Color color;
  final Widget child;
  const CardTemplateSimple(
      {super.key,
      this.isCurved = true,
      this.haveShadow = true,
      this.color = Colors.white,
      required this.child,
      this.baseWidth,
      this.baseHeight, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(padding ?? 0),
      height: (baseHeight != null) ? baseHeight?.toDouble() : null,
      width: (baseWidth != null) ? baseWidth?.toDouble() : null,
      decoration: BoxDecoration(
        color: color,
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
