import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final Widget? largeScreen;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    this.largeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (ResponsiveBreakpoints.of(context).isMobile) {
          return mobile;
        } else if (ResponsiveBreakpoints.of(context).isTablet) {
          return tablet;
        } else if (ResponsiveBreakpoints.of(context).isDesktop) {
          return desktop;
        } else {
          return largeScreen ?? desktop;
        }
      },
    );
  }
}
