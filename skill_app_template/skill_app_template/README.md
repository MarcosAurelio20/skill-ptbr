# Skill-style App (PT-BR) — Template Completo (Mobile + Admin + Functions)

Este repositório contém uma estrutura **pronta** para você iniciar um app no estilo "cards + trilhas + aulas + progresso",
inspirado no layout do print que você enviou, porém em **Português (PT-BR)**.

## Estrutura
- `mobile_flutter/` — App Flutter (Android/iOS)
- `admin_web/` — Painel Admin (Next.js)
- `functions/` — Cloud Functions (Firebase) + Scheduler (push/ranking)
- `firestore_rules/` — Regras do Firestore e índices (placeholders)
- `docs/` — Documentação e seed de conteúdo

## Pré-requisitos
- Flutter 3.19+ (ou mais recente)
- Node 18+
- Firebase CLI: `npm i -g firebase-tools`
- Conta + projeto no Firebase

## Passo a passo (rápido)
1) Crie um projeto no Firebase (Console)
2) Ative:
   - Authentication (Google + Email/Password)
   - Firestore
   - Cloud Messaging
   - (Opcional) Storage
3) No Flutter:
   - Rode `flutter pub get`
   - Configure o Firebase (recomendado com FlutterFire):
     ```bash
     cd mobile_flutter
     dart pub global activate flutterfire_cli
     flutterfire configure
     ```
   - Rode:
     ```bash
     flutter run
     ```
4) No Admin (Next.js):
   ```bash
   cd admin_web
   npm i
   cp .env.example .env.local
   # preencha as variáveis do Firebase Web
   npm run dev
   ```
5) Functions:
   ```bash
   cd functions
   npm i
   firebase deploy --only functions
   ```

## Seed de Conteúdo
- `docs/seed/seed_ptbr.json` contém categorias e skills (cards) em PT-BR.
- Você pode importar via Admin (rota /seed no template) ou manualmente (script).

> Observação: este template vem com telas e fluxo **funcionais** com dados locais (mock) + integração Firebase preparada.
