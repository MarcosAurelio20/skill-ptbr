class Skill {
  final String id;
  final String categoryId;
  final String titlePt;
  final String subtitlePt;
  final String imageKey;
  final List<String> bulletsPt;
  final String difficulty;
  final int order;
  final int color; // ARGB int
  final bool published;

  const Skill({
    required this.id,
    required this.categoryId,
    required this.titlePt,
    required this.subtitlePt,
    required this.bulletsPt,
    required this.difficulty,
    required this.order,
    required this.color,
    required this.published,
    required this.imageKey,
  });
}
