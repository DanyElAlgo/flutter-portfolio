class Cv {
  const Cv({
    required this.name,
    required this.title,
    required this.contact,
    required this.summary,
    required this.profiles,
    required this.education,
    required this.projects,
    required this.technologies,
    required this.tools,
    required this.skills,
    required this.certifications,
    required this.languages,
    required this.interests,
  });

  final String name;
  final String title;
  final CvContact contact;
  final String summary;
  final List<Profile> profiles;
  final List<Education> education;
  final List<CvProject> projects;
  final List<String> technologies;
  final List<String> tools;
  final List<String> skills;
  final List<Certification> certifications;
  final List<Language> languages;
  final List<String> interests;

  factory Cv.fromJson(Map<String, dynamic> json) {
    return Cv(
      name: json['name'] as String? ?? '',
      title: json['title'] as String? ?? '',
      contact: CvContact.fromJson(
        json['contact'] as Map<String, dynamic>? ?? const {},
      ),
      summary: json['summary'] as String? ?? '',
      profiles: _mapList(json['profiles'], Profile.fromJson),
      education: _mapList(json['education'], Education.fromJson),
      projects: _mapList(json['projects'], CvProject.fromJson),
      technologies: _stringList(json['technologies']),
      tools: _stringList(json['tools']),
      skills: _stringList(json['skills']),
      certifications: _mapList(json['certifications'], Certification.fromJson),
      languages: _mapList(json['languages'], Language.fromJson),
      interests: _stringList(json['interests']),
    );
  }
}

class CvContact {
  const CvContact({
    required this.email,
    required this.phone,
    required this.location,
  });

  final String email;
  final String phone;
  final String location;

  factory CvContact.fromJson(Map<String, dynamic> json) {
    return CvContact(
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      location: json['location'] as String? ?? '',
    );
  }
}

class Profile {
  const Profile({required this.label, required this.url});

  final String label;
  final String url;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      label: json['label'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }
}

class Education {
  const Education({
    required this.institution,
    required this.program,
    required this.location,
    required this.period,
    this.url,
  });

  final String institution;
  final String program;
  final String location;
  final String period;
  final String? url;

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      institution: json['institution'] as String? ?? '',
      program: json['program'] as String? ?? '',
      location: json['location'] as String? ?? '',
      period: json['period'] as String? ?? '',
      url: _nonEmpty(json['url'] as String?),
    );
  }
}

class CvProject {
  const CvProject({required this.name, required this.date});

  final String name;
  final String date;

  factory CvProject.fromJson(Map<String, dynamic> json) {
    return CvProject(
      name: json['name'] as String? ?? '',
      date: json['date'] as String? ?? '',
    );
  }
}

class Certification {
  const Certification({
    required this.title,
    required this.issuer,
    required this.date,
    this.url,
  });

  final String title;
  final String issuer;
  final String date;
  final String? url;

  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification(
      title: json['title'] as String? ?? '',
      issuer: json['issuer'] as String? ?? '',
      date: json['date'] as String? ?? '',
      url: _nonEmpty(json['url'] as String?),
    );
  }
}

class Language {
  const Language({required this.name, required this.level});

  final String name;
  final String level;

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['name'] as String? ?? '',
      level: json['level'] as String? ?? '',
    );
  }
}

String? _nonEmpty(String? value) {
  if (value == null || value.trim().isEmpty) return null;
  return value;
}

List<String> _stringList(Object? raw) {
  if (raw is! List) return const [];
  return raw.map((e) => e?.toString() ?? '').where((e) => e.isNotEmpty).toList();
}

List<T> _mapList<T>(Object? raw, T Function(Map<String, dynamic>) fromJson) {
  if (raw is! List) return const [];
  return raw
      .whereType<Map<String, dynamic>>()
      .map(fromJson)
      .toList(growable: false);
}
