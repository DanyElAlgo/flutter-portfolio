import 'package:flutter/material.dart';

import '../../../../shared/utils/url_launcher_helper.dart';
import '../../domain/contact_link.dart';

class ContactLinksSection extends StatelessWidget {
  const ContactLinksSection({super.key, required this.links});

  final List<ContactLink> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final link in links) ContactLinkTile(link: link),
      ],
    );
  }
}

class ContactLinkTile extends StatelessWidget {
  const ContactLinkTile({super.key, required this.link});

  final ContactLink link;

  IconData get _icon => switch (link.type) {
        ContactLinkType.email => Icons.email_outlined,
        ContactLinkType.url => Icons.link,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(_icon, color: theme.colorScheme.primary),
      title: Text(link.label, style: theme.textTheme.bodyLarge),
      subtitle: Text(link.value, style: theme.textTheme.bodySmall),
      onTap: () => launchExternalUrl(link.uri),
    );
  }
}
