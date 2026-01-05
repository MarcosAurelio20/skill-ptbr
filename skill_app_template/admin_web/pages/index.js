import { useEffect, useState } from 'react';
import { auth, db } from '../src/firebase';
import { signInWithEmailAndPassword, onAuthStateChanged, signOut } from 'firebase/auth';
import { collection, getDocs } from 'firebase/firestore';

export default function Home() {
  const [user, setUser] = useState(null);
  const [email, setEmail] = useState('');
  const [pass, setPass] = useState('');
  const [skills, setSkills] = useState([]);

  useEffect(() => onAuthStateChanged(auth, setUser), []);

  async function login(e){
    e.preventDefault();
    await signInWithEmailAndPassword(auth, email, pass);
  }

  async function loadSkills(){
    const snap = await getDocs(collection(db, 'skills'));
    setSkills(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  useEffect(() => { if(user) loadSkills(); }, [user]);

  if(!user){
    return (
      <main className="container">
        <h1>Painel Admin</h1>
        <p>Faça login (Email/Senha) no Firebase Auth.</p>
        <form onSubmit={login} className="card">
          <input placeholder="email" value={email} onChange={e=>setEmail(e.target.value)} />
          <input placeholder="senha" type="password" value={pass} onChange={e=>setPass(e.target.value)} />
          <button type="submit">Entrar</button>
        </form>
      </main>
    );
  }

  return (
    <main className="container">
      <header className="row">
        <h1>Painel Admin</h1>
        <button onClick={()=>signOut(auth)}>Sair</button>
      </header>

      <section className="card">
        <h2>Skills (Firestore)</h2>
        <p>Este template lista as skills já cadastradas.</p>
        <ul>
          {skills.map(s => (
            <li key={s.id}><b>{s.titlePt || s.title}</b> — {s.subtitlePt || ''}</li>
          ))}
        </ul>
      </section>

      <section className="card">
        <h2>Seed</h2>
        <p>Importe o JSON em <code>docs/seed/seed_ptbr.json</code> pelo seu script ou manualmente.</p>
      </section>
    </main>
  );
}
