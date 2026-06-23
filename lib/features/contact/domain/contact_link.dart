enum ContactLinkType {
  email,
  url;

  factory ContactLinkType.fromName(String? name) {
    return ContactLinkType.values.firstWhere(
      (type) => type.name == name,
      orElse: () => ContactLinkType.url,
    );
  }
}

class ContactLink {
  const ContactLink({
    required this.label,
    required this.type,
    required this.value,
  });

  final String label;
  final ContactLinkType type;
  final String value;

  Uri get uri => switch (type) {
        ContactLinkType.email => Uri(scheme: 'mailto', path: value),
        ContactLinkType.url => Uri.parse(value),
      };

  factory ContactLink.fromJson(Map<String, dynamic> json) {
    return ContactLink(
      label: json['label'] as String? ?? '',
      type: ContactLinkType.fromName(json['type'] as String?),
      value: json['value'] as String? ?? '',
    );
  }
}

class ContactInfo {
  const ContactInfo({required this.recipientEmail, required this.links});

  final String recipientEmail;

  final List<ContactLink> links;

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    final rawLinks = json['links'] as List<dynamic>? ?? const [];
    return ContactInfo(
      recipientEmail: json['recipientEmail'] as String? ?? '',
      links: rawLinks
          .map((entry) => ContactLink.fromJson(entry as Map<String, dynamic>))
          .toList(),
    );
  }
}
