import 'package:flutter/material.dart';
import 'package:skill_ptbr/core/models/skill.dart';

class SkillCard extends StatelessWidget {
  final Skill skill;
  final VoidCallback? onTap;

  const SkillCard({
    super.key,
    required this.skill,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmall = width < 390;

    // 🔹 Seu model usa int (ARGB)
    final Color cardColor = Color(skill.color);

    final String imagePath = 'assets/images/${skill.imageKey}.png';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================
          // TEXTO + BOTÃO
          // =========================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // evita layout quebrado
              children: [
                Text(
                  skill.titlePt,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                ),

                const SizedBox(height: 6),

                Text(
                  skill.subtitlePt,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.95),
                      ),
                ),

                const SizedBox(height: 12),

                // Bullets PT-BR
                ...skill.bulletsPt.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: const Text(
                    'Começar',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // =========================
          // IMAGEM
          // =========================
          Opacity(
            opacity: 0.95,
            child: Image.asset(
              imagePath,
              height: isSmall ? 110 : 130,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
