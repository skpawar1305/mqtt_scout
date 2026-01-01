import 'package:flutter/material.dart';
import 'layouts/desktop_home.dart';
import 'layouts/mobile_home.dart';

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const MobileHome();
        } else {
          return const DesktopHome();
        }
      },
    );
  }
}
