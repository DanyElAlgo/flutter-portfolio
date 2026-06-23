import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/project_repository.dart';
import '../domain/project.dart';

final projectsRepositoryProvider = Provider<ProjectRepository>(
  (ref) => const ProjectRepository(),
);

final projectsProvider = FutureProvider<List<Project>>((ref) {
  final repository = ref.watch(projectsRepositoryProvider);
  return repository.loadProjects();
});
