import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/skill_providers.dart';
import 'widgets/skill_card.dart';

class SkillsScreen extends ConsumerWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skills = ref.watch(skillsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunicação'),
        actions: [
          IconButton(
            onPressed: () => context.push('/profile'),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: skills.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final s = skills[index];
          return SkillCard(
            skill: s,
            onTap: () => context.push('/skill/${s.id}'),
          );
        },
      ),
    );
  }
}
