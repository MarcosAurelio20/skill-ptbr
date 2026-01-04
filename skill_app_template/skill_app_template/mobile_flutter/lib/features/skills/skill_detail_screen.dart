import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/skill_providers.dart';

class SkillDetailScreen extends ConsumerWidget {
  final String skillId;
  const SkillDetailScreen({super.key, required this.skillId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skill = ref.watch(skillByIdProvider(skillId));

    if (skill == null) {
      return const Scaffold(body: Center(child: Text('Skill não encontrada.')));
    }

    return Scaffold(
      appBar: AppBar(title: Text(skill.titlePt)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(skill.subtitlePt, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 14),
            const Text('Trilha (exemplo):'),
            const SizedBox(height: 8),
            _LessonTile(title: 'Aula 1 — Fundamentos', subtitle: '10 min • +20 XP'),
            _LessonTile(title: 'Aula 2 — Exercícios práticos', subtitle: '12 min • +25 XP'),
            _LessonTile(title: 'Quiz rápido', subtitle: '5 min • +15 XP'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Aqui você abre a aula / plano diário.')),
                  );
                },
                child: const Text('Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const _LessonTile({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
