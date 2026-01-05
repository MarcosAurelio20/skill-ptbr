# Arquitetura (alto nível)

## Mobile (Flutter)
- UI: cards, trilhas, aulas, quiz, progresso
- Estado: Riverpod
- Rotas: go_router
- Dados: Repositórios (mock + Firestore ready)

## Admin (Next.js)
- CRUD de categorias, skills, trilhas, aulas, quizzes
- Login com Firebase Auth
- Import de seed (JSON)

## Functions
- Scheduler diário: push para quem não fez check-in
- Scheduler semanal: gerar ranking por categoria
