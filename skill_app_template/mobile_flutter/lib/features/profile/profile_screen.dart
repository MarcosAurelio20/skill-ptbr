import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Usuário: Demo'),
            const SizedBox(height: 8),
            const Text('Streak: 0 dias'),
            const Text('Nível: 1'),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Sair (demo)'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
