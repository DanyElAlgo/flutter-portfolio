import 'package:flutter/material.dart';

import 'widgets/site_footer.dart';
import 'widgets/top_navbar.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            child,
            const SiteFooter(),
          ],
        ),
      ),
    );
  }
}
