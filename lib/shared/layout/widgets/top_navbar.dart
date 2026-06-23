import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';

class TopNavbar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentPath = GoRouterState.of(context).uri.path;

    return AppBar(
      backgroundColor: theme.colorScheme.inversePrimary,
      title: GestureDetector(
        onTap: () => context.go('/'),
        child: Text(
          'Portfolio',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        for (final dest in navDestinations)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TextButton(
              onPressed: () => context.go(dest.path),
              child: Text(
                dest.label,
                style: TextStyle(
                  fontWeight: currentPath == dest.path
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: currentPath == dest.path
                      ? theme.colorScheme.primary
                      : null,
                ),
              ),
            ),
          ),
        const SizedBox(width: 12),
      ],
    );
  }
}
