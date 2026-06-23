import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/paragraph_repository.dart';
import '../domain/paragraph.dart';

final paragraphRepositoryProvider = Provider<ParagraphRepository>(
  (ref) => const ParagraphRepository(),
);

final paragraphsProvider = FutureProvider<List<Paragraph>>((ref) {
  final repository = ref.watch(paragraphRepositoryProvider);
  return repository.loadParagraphs();
});
