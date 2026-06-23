import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../domain/cv.dart';

const PdfColor _primary = PdfColor.fromInt(0xFF3F51B5);
const PdfColor _chipBackground = PdfColor.fromInt(0xFFE8EAF6);
const PdfColor _divider = PdfColor.fromInt(0xFFE0E0E0);
const PdfColor _text = PdfColor.fromInt(0xFF212121);
const PdfColor _muted = PdfColor.fromInt(0xFF616161);

Future<Uint8List> buildCvPdf(Cv cv) async {
  final document = pw.Document(
    title: '${cv.name} - CV',
    author: cv.name,
  );

  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 36),
      build: (context) => [
        _header(cv),
        pw.SizedBox(height: 16),
        if (cv.summary.isNotEmpty)
          _section('Summary', pw.Text(cv.summary, style: _body())),
        if (cv.profiles.isNotEmpty) _section('Profiles', _profiles(cv.profiles)),
        if (cv.education.isNotEmpty)
          _section('Education', _education(cv.education)),
        if (cv.projects.isNotEmpty) _section('Projects', _projects(cv.projects)),
        if (cv.technologies.isNotEmpty)
          _section('Technologies', _chips(cv.technologies)),
        if (cv.tools.isNotEmpty) _section('Tools', _chips(cv.tools)),
        if (cv.skills.isNotEmpty) _section('Skills', _chips(cv.skills)),
        if (cv.certifications.isNotEmpty)
          _section('Certifications', _certifications(cv.certifications)),
        if (cv.languages.isNotEmpty)
          _section('Languages', _languages(cv.languages)),
        if (cv.interests.isNotEmpty) _section('Interests', _chips(cv.interests)),
      ],
    ),
  );

  return document.save();
}

pw.Widget _header(Cv cv) {
  final contactParts = [
    cv.contact.email,
    cv.contact.phone,
    cv.contact.location,
  ].where((part) => part.isNotEmpty).join('   |   ');

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.Text(
        cv.name,
        style: pw.TextStyle(
          fontSize: 24,
          fontWeight: pw.FontWeight.bold,
          color: _text,
        ),
      ),
      if (cv.title.isNotEmpty) ...[
        pw.SizedBox(height: 2),
        pw.Text(cv.title, style: pw.TextStyle(fontSize: 13, color: _muted)),
      ],
      if (contactParts.isNotEmpty) ...[
        pw.SizedBox(height: 6),
        pw.Text(contactParts, style: pw.TextStyle(fontSize: 10, color: _muted)),
      ],
    ],
  );
}

pw.Widget _section(String label, pw.Widget content) {
  return pw.Container(
    padding: const pw.EdgeInsets.only(bottom: 10),
    margin: const pw.EdgeInsets.only(bottom: 10),
    decoration: const pw.BoxDecoration(
      border: pw.Border(bottom: pw.BorderSide(color: _divider, width: 0.5)),
    ),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 96,
          child: pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
              color: _primary,
            ),
          ),
        ),
        pw.SizedBox(width: 14),
        pw.Expanded(child: content),
      ],
    ),
  );
}

pw.Widget _profiles(List<Profile> profiles) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      for (final profile in profiles)
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 4),
          child: pw.RichText(
            text: pw.TextSpan(
              children: [
                pw.TextSpan(
                  text: '${profile.label}: ',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: _text,
                  ),
                ),
                pw.WidgetSpan(child: _link(profile.url)),
              ],
            ),
          ),
        ),
    ],
  );
}

pw.Widget _education(List<Education> entries) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      for (final entry in entries)
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 6),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                entry.institution,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                  color: _text,
                ),
              ),
              pw.Text(
                [entry.program, entry.location, entry.period]
                    .where((part) => part.isNotEmpty)
                    .join('   |   '),
                style: _bodyMuted(),
              ),
              if (entry.url != null) _link(entry.url!),
            ],
          ),
        ),
    ],
  );
}

pw.Widget _projects(List<CvProject> projects) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      for (final project in projects)
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 4),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(child: pw.Text(project.name, style: _body())),
              if (project.date.isNotEmpty) ...[
                pw.SizedBox(width: 8),
                pw.Text(project.date, style: _bodyMuted()),
              ],
            ],
          ),
        ),
    ],
  );
}

pw.Widget _certifications(List<Certification> certifications) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      for (final cert in certifications)
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 6),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Text(
                      cert.title,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        color: _text,
                      ),
                    ),
                  ),
                  if (cert.date.isNotEmpty) ...[
                    pw.SizedBox(width: 8),
                    pw.Text(cert.date, style: _bodyMuted()),
                  ],
                ],
              ),
              if (cert.issuer.isNotEmpty)
                pw.Text(cert.issuer, style: _bodyMuted()),
              if (cert.url != null) _link(cert.url!),
            ],
          ),
        ),
    ],
  );
}

pw.Widget _languages(List<Language> languages) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      for (final language in languages)
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 2),
          child: pw.RichText(
            text: pw.TextSpan(
              children: [
                pw.TextSpan(
                  text: language.name,
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: _text,
                  ),
                ),
                if (language.level.isNotEmpty)
                  pw.TextSpan(
                    text: '  ${language.level}',
                    style: pw.TextStyle(fontSize: 10, color: _muted),
                  ),
              ],
            ),
          ),
        ),
    ],
  );
}

pw.Widget _chips(List<String> items) {
  return pw.Wrap(
    spacing: 6,
    runSpacing: 6,
    children: [
      for (final item in items)
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: pw.BoxDecoration(
            color: _chipBackground,
            borderRadius: pw.BorderRadius.circular(4),
          ),
          child: pw.Text(
            item,
            style: pw.TextStyle(fontSize: 9.5, color: _primary),
          ),
        ),
    ],
  );
}

pw.Widget _link(String url) {
  return pw.UrlLink(
    destination: url,
    child: pw.Text(
      url,
      style: pw.TextStyle(
        fontSize: 9.5,
        color: _primary,
        decoration: pw.TextDecoration.underline,
      ),
    ),
  );
}

pw.TextStyle _body() => pw.TextStyle(fontSize: 10.5, color: _text, height: 1.4);

pw.TextStyle _bodyMuted() => pw.TextStyle(fontSize: 10, color: _muted);
