import 'dart:ui';

import 'package:flutter/material.dart';

class GlassyCardModel extends StatelessWidget {
  final Color backgroundColor;
  final Radius radius;
  final Color shadowColor;
  final Widget child;

  const GlassyCardModel({
    Key? key,
    required this.backgroundColor,
    this.radius = const Radius.circular(10),
    this.shadowColor = Colors.black,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backgroundColor.withOpacity(0.1), // Adjust the opacity as needed
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  backgroundColor.withOpacity(0.3), // Lighter color
                  backgroundColor.withOpacity(0.1), // Darker color
                ],
                stops: [0.0, 1.0],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
