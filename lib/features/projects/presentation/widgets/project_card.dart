import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/utils/url_launcher_helper.dart';
import '../../domain/project.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});

  static const String _githubIconAsset =
      'assets/icons/GitHub_Invertocat_Black.svg';

  final Project project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final repoUrl = project.repoUrl;
    final deployedUrl = project.deployedUrl;
    final hasLinks = repoUrl != null || deployedUrl != null;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.title, style: theme.textTheme.headlineSmall),
                    const SizedBox(height: 12),
                    Text(
                      project.description,
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                    ),
                    if (hasLinks) ...[
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          if (repoUrl != null)
                            IconButton(
                              tooltip: 'View source',
                              onPressed: () =>
                                  launchExternalUrl(Uri.parse(repoUrl)),
                              icon: SvgPicture.asset(
                                _githubIconAsset,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          if (deployedUrl != null)
                            IconButton(
                              tooltip: 'Open site',
                              color: theme.colorScheme.primary,
                              onPressed: () =>
                                  launchExternalUrl(Uri.parse(deployedUrl)),
                              icon: const Icon(Icons.language),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: project.imagePath != null
                  ? SizedBox.expand(
                      child: Image.asset(
                        project.imagePath!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox.expand(),
            ),
          ],
        ),
      ),
    );
  }
}
