import 'package:go_router/go_router.dart';

import '../features/contact/presentation/contact_page.dart';
import '../features/content/presentation/about_page.dart';
import '../features/content/presentation/home_page.dart';
import '../shared/layout/app_shell.dart';

class NavDestination {
  const NavDestination({required this.label, required this.path});

  final String label;
  final String path;
}

const List<NavDestination> navDestinations = [
  NavDestination(label: 'Home', path: '/'),
  NavDestination(label: 'About', path: '/about'),
  NavDestination(label: 'Contact', path: '/contact'),
];

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutPage(),
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const ContactPage(),
        ),
      ],
    ),
  ],
);
