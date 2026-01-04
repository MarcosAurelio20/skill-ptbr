const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

/**
 * Exemplo: função HTTP para teste
 */
exports.ping = functions.https.onRequest((req, res) => {
  res.json({ ok: true, ts: new Date().toISOString() });
});

/**
 * (Placeholder) Scheduler diário para push: quem não fez check-in hoje
 * Para ativar: configure Cloud Scheduler e Firebase Functions v2/cron conforme seu setup.
 */
exports.dailyNudge = functions.pubsub
  .schedule('every day 19:30')
  .timeZone('America/Sao_Paulo')
  .onRun(async () => {
    // TODO: buscar usuários e enviar push via FCM
    console.log('dailyNudge: placeholder');
    return null;
  });

/**
 * (Placeholder) Ranking semanal
 */
exports.weeklyLeaderboard = functions.pubsub
  .schedule('every monday 01:10')
  .timeZone('America/Sao_Paulo')
  .onRun(async () => {
    // TODO: agregar XP semanal e escrever em leaderboards/{category}/weeks/{YYYY-WW}
    console.log('weeklyLeaderboard: placeholder');
    return null;
  });
