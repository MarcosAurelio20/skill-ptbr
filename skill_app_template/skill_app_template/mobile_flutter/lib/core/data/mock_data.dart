import '../models/category.dart';
import '../models/skill.dart';

const mockCategories = <Category>[
  Category(
    id: 'comunicacao',
    titlePt: 'Comunicação',
    order: 1,
    color: 0xFF2EC4B6,
  ),
];

const mockSkills = <Skill>[
  Skill(
    id: 'comunicacao_base',
    categoryId: 'comunicacao',
    titlePt: 'Comunicação',
    subtitlePt: 'Base para todas as habilidades sociais',
    bulletsPt: ['Clareza ao falar', 'Conexões melhores', 'Menos mal-entendidos'],
    difficulty: 'Iniciante',
    order: 1,
    color: 0xFFEF476F,
    published: true,
  ),
  Skill(
    id: 'assertiva',
    categoryId: 'comunicacao',
    titlePt: 'Comunicação Assertiva',
    subtitlePt: 'Clareza com respeito',
    bulletsPt: ['Dizer “não” sem culpa', 'Pedir o que precisa', 'Colocar limites'],
    difficulty: 'Iniciante',
    order: 2,
    color: 0xFF118AB2,
    published: true,
  ),
  Skill(
    id: 'negociacao_salarial',
    categoryId: 'comunicacao',
    titlePt: 'Negociação Salarial',
    subtitlePt: 'Ganhe com estratégia',
    bulletsPt: ['Preparar argumentos', 'Falar de valor', 'Fechar com confiança'],
    difficulty: 'Intermediário',
    order: 3,
    color: 0xFF06D6A0,
    published: true,
  ),
];
