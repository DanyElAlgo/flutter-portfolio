import 'package:go_router/go_router.dart';

import '../features/contact/presentation/contact_page.dart';
import '../features/content/presentation/home_page.dart';
import '../features/cv/presentation/cv_page.dart';
import '../features/projects/presentation/projects_page.dart';
import '../shared/layout/app_shell.dart';

class NavDestination {
  const NavDestination({required this.label, required this.path});

  final String label;
  final String path;
}

const List<NavDestination> navDestinations = [
  NavDestination(label: 'Home', path: '/'),
  NavDestination(label: 'Projects', path: '/projects'),
  NavDestination(label: 'CV', path: '/cv'),
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
          path: '/projects',
          builder: (context, state) => const ProjectsPage(),
        ),
        GoRoute(
          path: '/cv',
          builder: (context, state) => const CvPage(),
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const ContactPage(),
        ),
      ],
    ),
  ],
);
