import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/projects_provider.dart';
import 'widgets/project_card.dart';

class ProjectsPage extends ConsumerWidget {
  const ProjectsPage({super.key});

  static const double _maxContentWidth = 800;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxContentWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: projects.when(
            data: (items) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Projects', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(
                  'A selection of things I have built.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
                for (final project in items) ProjectCard(project: project),
              ],
            ),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: Text('Could not load projects.\n$error'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
