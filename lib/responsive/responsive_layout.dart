import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
    required this.desktopLayout,
    required this.mobileLayout,
    required this.tabletLayout,
  }) : super(key: key);

  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget desktopLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 500) {
        return mobileLayout;
      } else if (constraints.maxWidth < 1100) {
        return tabletLayout;
      } else {
        return desktopLayout;
      }
    });
  }
}
