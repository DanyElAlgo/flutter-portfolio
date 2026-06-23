import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../application/cv_provider.dart';
import '../data/cv_pdf_builder.dart';
import '../domain/cv.dart';
import 'widgets/cv_section.dart';

class CvPage extends ConsumerStatefulWidget {
  const CvPage({super.key});

  static const double _maxContentWidth = 800;

  @override
  ConsumerState<CvPage> createState() => _CvPageState();
}

class _CvPageState extends ConsumerState<CvPage> {
  bool _isGenerating = false;

  Future<void> _downloadPdf(Cv cv) async {
    setState(() => _isGenerating = true);
    try {
      final bytes = await buildCvPdf(cv);
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'Daniel_Penaranda_CV.pdf',
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not generate the PDF.\n$error')),
      );
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cvAsync = ref.watch(cvProvider);

    return Center(
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: CvPage._maxContentWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: cvAsync.when(
            data: (cv) => _CvContent(
              cv: cv,
              isGenerating: _isGenerating,
              onDownload: () => _downloadPdf(cv),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: Center(child: Text('Could not load the CV.\n$error')),
            ),
          ),
        ),
      ),
    );
  }
}

class _CvContent extends StatelessWidget {
  const _CvContent({
    required this.cv,
    required this.isGenerating,
    required this.onDownload,
  });

  final Cv cv;
  final bool isGenerating;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final sections = <Widget>[
      if (cv.summary.isNotEmpty)
        CvSection(
          label: 'Summary',
          child: Text(
            cv.summary,
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
          ),
        ),
      if (cv.profiles.isNotEmpty)
        CvSection(label: 'Profiles', child: _profiles(theme)),
      if (cv.education.isNotEmpty)
        CvSection(label: 'Education', child: _education(theme)),
      if (cv.projects.isNotEmpty)
        CvSection(label: 'Projects', child: _projects(theme)),
      if (cv.technologies.isNotEmpty)
        CvSection(label: 'Technologies', child: _chips(cv.technologies)),
      if (cv.tools.isNotEmpty)
        CvSection(label: 'Tools', child: _chips(cv.tools)),
      if (cv.skills.isNotEmpty)
        CvSection(label: 'Skills', child: _chips(cv.skills)),
      if (cv.certifications.isNotEmpty)
        CvSection(label: 'Certifications', child: _certifications(theme)),
      if (cv.languages.isNotEmpty)
        CvSection(label: 'Languages', child: _languages(theme)),
      if (cv.interests.isNotEmpty)
        CvSection(label: 'Interests', child: _chips(cv.interests)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _titleRow(theme),
        const SizedBox(height: 24),
        _identityHeader(theme),
        const SizedBox(height: 8),
        for (var i = 0; i < sections.length; i++) ...[
          if (i > 0) const Divider(height: 1),
          sections[i],
        ],
      ],
    );
  }

  Widget _titleRow(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Text('CV', style: theme.textTheme.headlineMedium),
        ),
        const SizedBox(width: 16),
        FilledButton.icon(
          onPressed: isGenerating ? null : onDownload,
          icon: isGenerating
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.download),
          label: Text(isGenerating ? 'Generating…' : 'Download PDF'),
        ),
      ],
    );
  }

  Widget _identityHeader(ThemeData theme) {
    final contact = cv.contact;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(cv.name, style: theme.textTheme.headlineSmall),
        if (cv.title.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            cv.title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        const SizedBox(height: 10),
        Wrap(
          spacing: 20,
          runSpacing: 6,
          children: [
            if (contact.email.isNotEmpty)
              _contactItem(
                theme,
                Icons.email_outlined,
                CvLink(text: contact.email, url: 'mailto:${contact.email}'),
              ),
            if (contact.phone.isNotEmpty)
              _contactItem(theme, Icons.phone_outlined, Text(contact.phone)),
            if (contact.location.isNotEmpty)
              _contactItem(
                theme,
                Icons.location_on_outlined,
                Text(contact.location),
              ),
          ],
        ),
      ],
    );
  }

  Widget _contactItem(ThemeData theme, IconData icon, Widget child) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 6),
        child,
      ],
    );
  }

  Widget _profiles(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final profile in cv.profiles)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: CvLink(text: profile.label, url: profile.url),
          ),
      ],
    );
  }

  Widget _education(ThemeData theme) {
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in cv.education)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.institution,
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  [entry.program, entry.location, entry.period]
                      .where((part) => part.isNotEmpty)
                      .join('  •  '),
                  style: muted,
                ),
                if (entry.url != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: CvLink(text: entry.url!, url: entry.url!),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _projects(ThemeData theme) {
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final project in cv.projects)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(project.name, style: theme.textTheme.bodyLarge),
                ),
                if (project.date.isNotEmpty) ...[
                  const SizedBox(width: 12),
                  Text(project.date, style: muted),
                ],
              ],
            ),
          ),
      ],
    );
  }

  Widget _certifications(ThemeData theme) {
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final cert in cv.certifications)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(cert.title, style: theme.textTheme.titleSmall),
                    ),
                    if (cert.date.isNotEmpty) ...[
                      const SizedBox(width: 12),
                      Text(cert.date, style: muted),
                    ],
                  ],
                ),
                if (cert.issuer.isNotEmpty) Text(cert.issuer, style: muted),
                if (cert.url != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: CvLink(text: cert.url!, url: cert.url!),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _languages(ThemeData theme) {
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final language in cv.languages)
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(
              children: [
                Text(language.name, style: theme.textTheme.titleSmall),
                if (language.level.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Text(language.level, style: muted),
                ],
              ],
            ),
          ),
      ],
    );
  }

  Widget _chips(List<String> items) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [for (final item in items) CvChip(label: item)],
    );
  }
}
