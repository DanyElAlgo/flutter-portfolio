import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/contact_provider.dart';
import 'widgets/contact_form.dart';
import 'widgets/contact_links_section.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  static const double _maxContentWidth = 800;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contact = ref.watch(contactProvider);
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxContentWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: contact.when(
            data: (info) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Contact me', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(
                  'Reach out through any of these, or send a message below.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                ContactLinksSection(links: info.links),
                const SizedBox(height: 32),
                ContactForm(recipientEmail: info.recipientEmail),
              ],
            ),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: Text('Could not load contact info.\n$error'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
