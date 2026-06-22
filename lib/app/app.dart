import 'package:flutter/material.dart';

import '../features/content/presentation/home_page.dart';
import '../shared/layout/app_shell.dart';
import 'theme.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AppShell(child: HomePage()),
    );
  }
}
