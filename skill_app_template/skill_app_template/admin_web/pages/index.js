import { useEffect, useMemo, useState } from 'react';
import { auth, db } from '../src/firebase';
import { signInWithEmailAndPassword, onAuthStateChanged, signOut } from 'firebase/auth';
import { collection, getDocs } from 'firebase/firestore';

export default function Home() {
  const [user, setUser] = useState(null);
  const [authChecking, setAuthChecking] = useState(true);
  const [email, setEmail] = useState('');
  const [pass, setPass] = useState('');
  const [skills, setSkills] = useState([]);
  const [loadingSkills, setLoadingSkills] = useState(false);
  const [skillError, setSkillError] = useState('');
  const [authLoading, setAuthLoading] = useState(false);
  const [authError, setAuthError] = useState('');

  const skillTotal = useMemo(() => skills.length, [skills]);

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, currentUser => {
      setUser(currentUser);
      setAuthChecking(false);
    });
    return unsubscribe;
  }, []);

  async function login(e) {
    e.preventDefault();
    if (authLoading) return;

    setAuthError('');
    setAuthLoading(true);

    try {
      await signInWithEmailAndPassword(auth, email.trim(), pass);
    } catch (error) {
      setAuthError('Não foi possível entrar. Verifique as credenciais e tente novamente.');
    } finally {
      setAuthLoading(false);
    }
  }

  async function loadSkills() {
    if (loadingSkills) return;

    setLoadingSkills(true);
    setSkillError('');

    try {
      const snap = await getDocs(collection(db, 'skills'));
      setSkills(snap.docs.map(d => ({ id: d.id, ...d.data() })));
    } catch (error) {
      setSkillError('Erro ao carregar as skills. Tente novamente em instantes.');
    } finally {
      setLoadingSkills(false);
    }
  }

  useEffect(() => {
    if (user) loadSkills();
  }, [user]);

  if (authChecking) {
    return (
      <main className="container">
        <div className="card notice-card">
          <p className="card-title">Carregando sessão…</p>
          <p className="muted">Verificando seu status de login. Isso pode levar alguns segundos.</p>
        </div>
      </main>
    );
  }

  if(!user){
    return (
      <main className="container">
        <div className="hero">
          <div>
            <p className="eyebrow">Skill Admin</p>
            <h1>Painel de administração</h1>
            <p className="muted">Acesse com a conta do Firebase Auth para revisar e gerenciar o conteúdo cadastrado.</p>
          </div>
          <div className="card form-card">
            <p className="card-title">Entrar</p>
            <form onSubmit={login} className="form-grid">
              <label className="field">
                <span>Email</span>
                <input
                  placeholder="admin@exemplo.com"
                  value={email}
                  type="email"
                  autoComplete="email"
                  onChange={e => setEmail(e.target.value)}
                  required
                />
              </label>
              <label className="field">
                <span>Senha</span>
                <input
                  placeholder="••••••••"
                  type="password"
                  value={pass}
                  autoComplete="current-password"
                  onChange={e => setPass(e.target.value)}
                  required
                />
              </label>
              <button type="submit" disabled={authLoading || !email.trim() || !pass}>
                {authLoading ? 'Entrando…' : 'Entrar'}
              </button>
              {authError && <p className="alert error">{authError}</p>}
            </form>
          </div>
        </div>
      </main>
    );
  }

  return (
    <main className="container">
      <header className="row page-header">
        <div>
          <p className="eyebrow">Skill Admin</p>
          <h1>Painel de administração</h1>
          <p className="muted">Visualize as skills cadastradas e confira as informações de seed.</p>
        </div>
        <button className="ghost" onClick={()=>signOut(auth)}>Sair</button>
      </header>

      <section className="cards-grid">
        <div className="card">
          <div className="card-title-row">
            <h2>Skills (Firestore)</h2>
            <span className="pill">{loadingSkills ? 'Carregando…' : `${skillTotal} registro${skillTotal === 1 ? '' : 's'}`}</span>
            <button className="ghost sm" onClick={loadSkills} disabled={loadingSkills}>
              Recarregar
            </button>
          </div>
          <p className="muted">Este template lista as skills já cadastradas.</p>
          <div className="list">
            {loadingSkills && <p className="muted">Buscando informações…</p>}
            {skillError && (
              <div className="alert error alert-row">
                <span>{skillError}</span>
                <button className="ghost sm" onClick={loadSkills} disabled={loadingSkills}>
                  Tentar novamente
                </button>
              </div>
            )}
            {!loadingSkills && skills.length === 0 && <p className="muted">Nenhuma skill encontrada no momento.</p>}
            {skills.map(s => (
              <div key={s.id} className="list-item">
                <div>
                  <p className="item-title">{s.titlePt || s.title}</p>
                  {s.subtitlePt && <p className="muted small">{s.subtitlePt}</p>}
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="card">
          <div className="card-title-row">
            <h2>Seed</h2>
            <span className="pill pill-soft">Guia</span>
          </div>
          <p className="muted">Importe o JSON em <code>docs/seed/seed_ptbr.json</code> pelo seu script ou manualmente.</p>
          <ul className="bullet-list">
            <li>Use a mesma estrutura de campos ao criar novas skills.</li>
            <li>Atualize as traduções usando os campos <code>titlePt</code> e <code>subtitlePt</code>.</li>
            <li>Após importar, recarregue a página para visualizar as entradas.</li>
          </ul>
        </div>
      </section>
    </main>
  );
}
