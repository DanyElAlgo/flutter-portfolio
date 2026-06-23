import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../features/contact/application/contact_provider.dart';
import '../../../features/contact/domain/contact_link.dart';
import '../../utils/url_launcher_helper.dart';

class SiteFooter extends ConsumerWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final year = DateTime.now().year;
    final contactLinks = ref.watch(contactProvider).maybeWhen(
          data: (info) => info.links,
          orElse: () => const <ContactLink>[],
        );

    return Container(
      width: double.infinity,
      color: theme.colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 48,
              runSpacing: 24,
              children: [
                _FooterColumn(
                  title: 'Navigation',
                  children: [
                    for (final dest in navDestinations)
                      _FooterLink(
                        label: dest.label,
                        onTap: () => context.go(dest.path),
                      ),
                  ],
                ),
                _FooterColumn(
                  title: 'Contact',
                  children: [
                    for (final link in contactLinks)
                      _FooterLink(
                        label: link.label,
                        onTap: () => launchExternalUrl(link.uri),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Divider(color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 12),
          Text(
            '© $year Portfolio. All rights reserved.',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: InkWell(
        onTap: onTap,
        child: Text(label, style: theme.textTheme.bodyMedium),
      ),
    );
  }
}
