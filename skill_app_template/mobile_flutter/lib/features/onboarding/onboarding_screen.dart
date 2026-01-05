import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int minutes = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Quantos minutos por dia você quer praticar?'),
            const SizedBox(height: 12),
            DropdownButton<int>(
              value: minutes,
              items: const [10, 15, 20, 30, 45].map((m) {
                return DropdownMenuItem(value: m, child: Text('$m minutos'));
              }).toList(),
              onChanged: (v) => setState(() => minutes = v ?? 20),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.go('/skills'),
                child: const Text('Finalizar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
