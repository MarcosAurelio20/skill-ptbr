import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_data.dart';
import '../models/skill.dart';

final skillsProvider = Provider<List<Skill>>((ref) {
  final list = [...mockSkills]..sort((a, b) => a.order.compareTo(b.order));
  return list.where((s) => s.published).toList();
});

final skillByIdProvider = Provider.family<Skill?, String>((ref, id) {
  return ref.watch(skillsProvider).where((s) => s.id == id).cast<Skill?>().firstOrNull;
});

extension _FirstOrNullExt<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
