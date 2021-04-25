import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SingleScrollbarView extends StatelessWidget {
  SingleScrollbarView(
      {required this.child,
      this.controller,
      this.isAlwaysShown = false,
      this.thickness,
      this.radius});

  final Widget child;
  final ScrollController? controller;
  final bool isAlwaysShown;
  final double? thickness;
  final Radius? radius;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(child: child),
        controller: controller,
        isAlwaysShown: isAlwaysShown,
        thickness: thickness,
        radius: radius);
  }
}
