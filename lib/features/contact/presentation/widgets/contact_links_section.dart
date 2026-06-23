import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  static const double _iconSize = 28;

  final ContactLink link;

  IconData get _fallbackIcon => switch (link.type) {
        ContactLinkType.email => Icons.email_outlined,
        ContactLinkType.url => Icons.link,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: _buildIcon(theme),
      ),
      title: Text(link.label, style: theme.textTheme.bodyLarge),
      subtitle: Text(link.value, style: theme.textTheme.bodySmall),
      onTap: () => launchExternalUrl(link.uri),
    );
  }

  Widget _buildIcon(ThemeData theme) {
    final icon = link.icon;
    if (icon == null || icon.isEmpty) {
      return Icon(_fallbackIcon, color: theme.colorScheme.primary);
    }
    if (icon.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(icon, fit: BoxFit.contain);
    }
    return Image.asset(icon, fit: BoxFit.contain);
  }
}
