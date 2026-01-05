import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentIndex = 0;
  int minutes = 20;

  late final Future<Set<String>> _missingAssets;

  List<_Slide> get slides => const [
        _Slide(
          asset: 'assets/images/communication_1.png',
          title: 'Pratique em poucos minutos',
          description: 'Use sessões curtas para ganhar ritmo sem sobrecarregar a rotina.',
        ),
        _Slide(
          asset: 'assets/images/communication_3.png',
          title: 'Avance por trilhas',
          description: 'Complete cards e acompanhe o progresso em cada habilidade.',
        ),
        _Slide(
          asset: 'assets/images/communication_5.png',
          title: 'Personalize o tempo',
          description: 'Escolha quantos minutos por dia quer investir e receba lembretes.',
        ),
      ];

  @override
  void initState() {
    super.initState();
    _missingAssets = _validateAssets();
  }

  Future<Set<String>> _validateAssets() async {
    final missing = <String>{};
    for (final slide in slides) {
      try {
        await rootBundle.load(slide.asset);
      } catch (_) {
        missing.add(slide.asset);
      }
    }
    return missing;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Set<String>>(
      future: _missingAssets,
      builder: (context, snapshot) {
        final missingAssets = snapshot.data ?? {};
        final checkingAssets = snapshot.connectionState == ConnectionState.waiting;

        return Scaffold(
          appBar: AppBar(title: const Text('Boas-vindas')),
          body: Column(
            children: [
              if (checkingAssets)
                const LinearProgressIndicator(
                  minHeight: 3,
                ),
              if (missingAssets.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: _MissingAssetsBanner(missingAssets: missingAssets),
                ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: slides.length,
                  onPageChanged: (index) => setState(() => _currentIndex = index),
                  itemBuilder: (_, index) {
                    final slide = slides[index];

                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Expanded(
                            child: _SlideIllustration(
                              slide: slide,
                              isMissing: missingAssets.contains(slide.asset),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            slide.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            slide.description,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < slides.length; i++)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: i == _currentIndex ? 20 : 8,
                            decoration: BoxDecoration(
                              color: i == _currentIndex
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Quantos minutos por dia você quer praticar?'),
                          DropdownButton<int>(
                            value: minutes,
                            items: const [10, 15, 20, 30, 45].map((m) {
                              return DropdownMenuItem(value: m, child: Text('$m minutos'));
                            }).toList(),
                            onChanged: (v) => setState(() => minutes = v ?? 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => context.go('/skills'),
                        child: const Text('Começar agora'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SlideIllustration extends StatelessWidget {
  const _SlideIllustration({required this.slide, required this.isMissing});

  final _Slide slide;
  final bool isMissing;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Color(0xFFF6F6F6)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isMissing
              ? _MissingAssetPlaceholder(asset: slide.asset)
              : Image.asset(
                  slide.asset,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => _MissingAssetPlaceholder(asset: slide.asset),
                ),
        ),
      ),
    );
  }
}

class _MissingAssetsBanner extends StatelessWidget {
  const _MissingAssetsBanner({required this.missingAssets});

  final Set<String> missingAssets;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ilustrações faltando',
              style: textTheme.titleMedium?.copyWith(color: Colors.orange[800]),
            ),
            const SizedBox(height: 6),
            Text(
              'Revisamos os arquivos locais e os itens abaixo não foram encontrados. Adicione as imagens ao diretório de assets ou atualize os slides para apontar para ilustrações existentes.',
              style: textTheme.bodyMedium?.copyWith(color: Colors.orange[900]),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: missingAssets
                  .map((asset) => Chip(
                        backgroundColor: Colors.orange[100],
                        label: Text(asset, style: const TextStyle(fontWeight: FontWeight.w600)),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MissingAssetPlaceholder extends StatelessWidget {
  const _MissingAssetPlaceholder({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary.withOpacity(0.08), colorScheme.primary.withOpacity(0.02)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colorScheme.primary.withOpacity(0.18)),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image_not_supported_rounded, size: 42, color: colorScheme.primary),
              const SizedBox(height: 10),
              Text(
                'Ilustração ausente',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                asset,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Slide {
  final String asset;
  final String title;
  final String description;

  const _Slide({
    required this.asset,
    required this.title,
    required this.description,
  });
}
