import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/cv_repository.dart';
import '../domain/cv.dart';

final cvRepositoryProvider = Provider<CvRepository>(
  (ref) => const CvRepository(),
);

final cvProvider = FutureProvider<Cv>((ref) {
  final repository = ref.watch(cvRepositoryProvider);
  return repository.loadCv();
});
