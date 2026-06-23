import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/contact_repository.dart';
import '../domain/contact_link.dart';

final contactRepositoryProvider = Provider<ContactRepository>(
  (ref) => const ContactRepository(),
);

final contactProvider = FutureProvider<ContactInfo>((ref) {
  final repository = ref.watch(contactRepositoryProvider);
  return repository.loadContact();
});
