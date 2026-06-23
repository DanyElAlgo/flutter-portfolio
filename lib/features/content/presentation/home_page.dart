import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/paragraphs_provider.dart';
import 'widgets/paragraph_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const double _maxContentWidth = 800;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paragraphs = ref.watch(paragraphsProvider);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxContentWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: paragraphs.when(
            data: (items) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Home menu", style: Theme.of(context).textTheme.headlineMedium),
                for (final paragraph in items)
                  ParagraphCard(paragraph: paragraph),
              ],
            ),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 64),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: Text('Could not load content.\n$error'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
