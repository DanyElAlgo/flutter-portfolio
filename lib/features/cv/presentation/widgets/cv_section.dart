import 'package:flutter/material.dart';

import '../../../../shared/utils/url_launcher_helper.dart';

class CvSection extends StatelessWidget {
  const CvSection({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  static const double _wideBreakpoint = 700;
  static const double _labelWidth = 140;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelWidget = Text(
      label,
      style: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= _wideBreakpoint) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: _labelWidth, child: labelWidget),
                const SizedBox(width: 24),
                Expanded(child: child),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWidget,
              const SizedBox(height: 8),
              child,
            ],
          );
        },
      ),
    );
  }
}

class CvChip extends StatelessWidget {
  const CvChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}

class CvLink extends StatelessWidget {
  const CvLink({super.key, required this.text, required this.url});

  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => launchExternalUrl(Uri.parse(url)),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
