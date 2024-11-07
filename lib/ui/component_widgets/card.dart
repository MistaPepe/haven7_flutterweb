import 'package:flutter/material.dart';

//default template for card widget
class CardTemplateBox extends StatefulWidget {
  final int baseWidth;
  final int baseHeight;
  final Widget child;
  final Widget? background;
  final Color color;
  final bool isCurved;
  final bool haveShadow;
  const CardTemplateBox(
      {super.key,
      required this.baseWidth,
      required this.baseHeight,
      required this.child,
      this.background,
      this.color = Colors.white,
      this.isCurved = true,
      this.haveShadow = true});

  @override
  State<CardTemplateBox> createState() => _CardTemplateBoxState();
}

class _CardTemplateBoxState extends State<CardTemplateBox> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Transform.scale(
        scale: _isHovering ? 1.015 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
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
          child: GestureDetector(
            onTap: () {
              debugPrint('Card tapped.');
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }
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
