import 'package:go_router/go_router.dart';
import '../../features/auth/login_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/skills/skills_screen.dart';
import '../../features/skills/skill_detail_screen.dart';
import '../../features/profile/profile_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/skills',
  routes: [
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    GoRoute(path: '/skills', builder: (_, __) => const SkillsScreen()),
    GoRoute(
      path: '/skill/:id',
      builder: (_, state) => SkillDetailScreen(skillId: state.pathParameters['id']!),
    ),
    GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
  ],
);
