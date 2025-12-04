# 📁 Estrutura do Projeto DOM - Guia Completo

## 🎯 Visão Geral

O Sistema DOM usa uma arquitetura **monorepo** onde **frontend e backend coexistem no mesmo projeto**, mas com separação clara de responsabilidades.

---

## 🗂️ Estrutura de Diretórios Completa

```
dom/
│
├── 📂 src/                           ⚙️ BACKEND (TypeScript/Hono)
│   ├── index.tsx                     # Entry point - Servidor principal
│   ├── types.ts                      # Interfaces TypeScript globais
│   │
│   ├── 📂 routes/                    🔌 API ROUTES (Endpoints REST)
│   │   ├── auth.ts                   # /api/auth/* - Autenticação
│   │   ├── users.ts                  # /api/users/* - Usuários
│   │   ├── secretarias.ts            # /api/secretarias/* - Secretarias
│   │   ├── matter-types.ts           # /api/matter-types/* - Tipos
│   │   ├── matters.ts                # /api/matters/* - Matérias
│   │   ├── editions.ts               # /api/editions/* - Edições
│   │   ├── portal.ts                 # /api/portal/* - Portal público
│   │   ├── settings.ts               # /api/settings/* - Configurações
│   │   └── attachments.ts            # /api/attachments/* - Anexos
│   │
│   ├── 📂 middleware/                🛡️ MIDDLEWARES
│   │   └── auth.ts                   # Autenticação JWT
│   │
│   └── 📂 utils/                     🔧 UTILITÁRIOS DO BACKEND
│       ├── auth.ts                   # Criptografia, JWT, hash
│       ├── date.ts                   # Manipulação de datas
│       └── pdf-generator.ts          # Geração de PDF
│
├── 📂 public/                        🎨 FRONTEND (Arquivos Estáticos)
│   └── 📂 static/                    
│       ├── app-v2.js                 # 💻 FRONTEND PRINCIPAL (JavaScript)
│       ├── webgl-init.js             # Efeitos WebGL (opcional)
│       └── styles.css                # CSS customizado
│
├── 📂 migrations/                    🗄️ BANCO DE DADOS (SQL)
│   ├── 0001_initial_schema.sql
│   ├── 0002_add_matter_types.sql
│   ├── 0003_add_secretarias.sql
│   ├── 0004_add_editions.sql
│   ├── 0005_add_attachments.sql
│   ├── 0006_add_audit_logs.sql
│   ├── 0007_add_system_settings.sql
│   ├── 0008_add_calendar_config.sql
│   └── 0009_add_parent_edition.sql
│
├── 📂 dist/                          📦 BUILD OUTPUT (Gerado)
│   ├── _worker.js                    # Backend compilado
│   ├── _routes.json                  # Configuração de rotas
│   └── (static files)                # Frontend copiado
│
├── 📂 .wrangler/                     🔧 CACHE WRANGLER (Ignorado)
│   └── state/v3/d1/                  # Database local D1
│
├── 📂 node_modules/                  📦 DEPENDÊNCIAS NPM (Ignorado)
│
├── 📄 package.json                   📋 Configuração do projeto
├── 📄 package-lock.json              🔒 Lock de versões
├── 📄 tsconfig.json                  📘 Config TypeScript
├── 📄 vite.config.ts                 ⚡ Config Vite (build)
├── 📄 wrangler.jsonc                 ☁️ Config Cloudflare
├── 📄 ecosystem.config.cjs           🔄 Config PM2 (dev)
├── 📄 .gitignore                     🚫 Arquivos ignorados
│
├── 📄 README.md                      📖 Documentação principal
├── 📄 STACK_TECNOLOGICO.md          🏗️ Stack detalhado
├── 📄 TECNOLOGIAS_RESUMO.md         📊 Resumo visual
├── 📄 FERRAMENTAS_UTILIZADAS.md     🛠️ Guia de ferramentas
├── 📄 ESTRUTURA_DO_PROJETO.md       📁 Este documento
├── 📄 INSTALACAO_VM.md              💿 Guia de instalação
└── 📄 install.sh                     🚀 Script de instalação

```

---

## 🎯 Localização dos Componentes Principais

### ⚙️ **BACKEND (API)**

**Localização:** `/src`

```
src/
├── index.tsx              # ⭐ Servidor principal + HTML templates
├── types.ts               # TypeScript interfaces
├── routes/                # 🔌 Todos os endpoints da API
│   ├── auth.ts           # POST /api/auth/login, /api/auth/logout
│   ├── users.ts          # GET/POST/PUT/DELETE /api/users
│   ├── matters.ts        # GET/POST/PUT/DELETE /api/matters
│   ├── editions.ts       # GET/POST/PUT /api/editions
│   └── ...
├── middleware/
│   └── auth.ts           # JWT validation middleware
└── utils/
    ├── auth.ts           # Password hashing, JWT generation
    ├── date.ts           # Date utilities
    └── pdf-generator.ts  # PDF generation logic
```

**Tecnologia:** TypeScript + Hono Framework  
**Runtime:** Cloudflare Workers (V8)

---

### 🎨 **FRONTEND (Interface do Usuário)**

**Localização:** `/public/static`

```
public/static/
├── app-v2.js          # ⭐ TODO O CÓDIGO FRONTEND ESTÁ AQUI
│                      # - Login/Logout
│                      # - Dashboard
│                      # - CRUD de usuários
│                      # - CRUD de matérias
│                      # - CRUD de edições
│                      # - Portal público
│                      # - Axios HTTP client
│                      # - Event handlers
│
├── webgl-init.js      # Efeitos visuais WebGL (opcional)
└── styles.css         # CSS customizado adicional
```

**Tecnologia:** Vanilla JavaScript (ES6+)  
**Bibliotecas (CDN):**
- Tailwind CSS (estilização)
- Font Awesome (ícones)
- Axios (HTTP client)
- Quill.js (editor de texto)
- Chart.js (gráficos)

**⚠️ IMPORTANTE:** 
- **TODO o código JavaScript do frontend está em um único arquivo:** `app-v2.js`
- Não há React, Vue ou Angular
- Não há bundler de frontend (Webpack, Rollup)
- É JavaScript puro e direto

---

### 🔌 **API (Endpoints REST)**

**Localização:** `/src/routes/*.ts`

Cada arquivo em `src/routes/` define um conjunto de endpoints relacionados:

| Arquivo | Endpoints | Função |
|---------|-----------|--------|
| **auth.ts** | `/api/auth/login`<br>`/api/auth/logout`<br>`/api/auth/me` | Autenticação |
| **users.ts** | `/api/users`<br>`/api/users/:id` | CRUD de usuários |
| **secretarias.ts** | `/api/secretarias`<br>`/api/secretarias/:id` | CRUD de secretarias |
| **matter-types.ts** | `/api/matter-types`<br>`/api/matter-types/:id` | CRUD de tipos |
| **matters.ts** | `/api/matters`<br>`/api/matters/:id`<br>`/api/matters/:id/submit`<br>`/api/matters/:id/approve`<br>`/api/matters/:id/reject` | CRUD e workflow de matérias |
| **editions.ts** | `/api/editions`<br>`/api/editions/:id`<br>`/api/editions/:id/publish`<br>`/api/editions/:id/preview`<br>`/api/editions/:id/pdf` | CRUD e publicação de edições |
| **portal.ts** | `/api/portal/search`<br>`/api/portal/stats`<br>`/api/portal/editions`<br>`/api/portal/filters` | Portal público |
| **settings.ts** | `/api/settings`<br>`/api/settings/logo` | Configurações do sistema |
| **attachments.ts** | `/api/attachments` | Upload de anexos |

**Exemplo de Fluxo de Request:**

```
1. Usuário clica em botão no frontend (app-v2.js)
   ↓
2. JavaScript faz requisição via Axios
   ↓
3. Request chega em /api/matters (entrada)
   ↓
4. Hono roteia para src/routes/matters.ts
   ↓
5. Middleware de auth valida JWT (src/middleware/auth.ts)
   ↓
6. Controller processa a lógica de negócio
   ↓
7. Faz query no banco de dados (D1)
   ↓
8. Retorna JSON response
   ↓
9. Frontend recebe response e atualiza a tela
```

---

### 🗄️ **BANCO DE DADOS (Migrations)**

**Localização:** `/migrations/*.sql`

```
migrations/
├── 0001_initial_schema.sql        # Tabelas principais
├── 0002_add_matter_types.sql      # Tipos de matéria
├── 0003_add_secretarias.sql       # Secretarias
├── 0004_add_editions.sql          # Edições
├── 0005_add_attachments.sql       # Anexos
├── 0006_add_audit_logs.sql        # Logs de auditoria
├── 0007_add_system_settings.sql   # Configurações
├── 0008_add_calendar_config.sql   # Calendário
└── 0009_add_parent_edition.sql    # Edições suplementares
```

**Como aplicar:**
```bash
# Desenvolvimento local
wrangler d1 migrations apply dom-production --local

# Produção
wrangler d1 migrations apply dom-production --remote
```

**Principais Tabelas:**

| Tabela | Descrição | Localização da Migration |
|--------|-----------|-------------------------|
| `users` | Usuários do sistema | 0001_initial_schema.sql |
| `secretarias` | Secretarias municipais | 0003_add_secretarias.sql |
| `matter_types` | Tipos de matéria | 0002_add_matter_types.sql |
| `matters` | Matérias para publicação | 0001_initial_schema.sql |
| `editions` | Edições do diário | 0004_add_editions.sql |
| `edition_matters` | Relacionamento N:N | 0004_add_editions.sql |
| `attachments` | Anexos de matérias | 0005_add_attachments.sql |
| `audit_logs` | Logs de auditoria | 0006_add_audit_logs.sql |
| `system_settings` | Configurações | 0007_add_system_settings.sql |

---

## 🏗️ Arquitetura do Sistema

### Diagrama de Componentes

```
┌─────────────────────────────────────────────────────────────┐
│                      USUÁRIO FINAL                          │
│                    (Navegador Web)                          │
└────────────────────────┬────────────────────────────────────┘
                         │
                         │ HTTP/HTTPS
                         │
┌────────────────────────▼────────────────────────────────────┐
│                  CLOUDFLARE CDN                              │
│              (Global Edge Network)                           │
└────────────────────────┬────────────────────────────────────┘
                         │
        ┌────────────────┼────────────────┐
        │                │                │
        │                │                │
┌───────▼────┐   ┌───────▼────┐   ┌──────▼────┐
│  Frontend  │   │  Backend   │   │ Database  │
│  (Static)  │   │   (API)    │   │    (D1)   │
│            │   │            │   │           │
│ /public/   │   │   /src/    │   │ SQLite    │
│  static/   │   │  routes/   │   │ Distrib.  │
│            │   │            │   │           │
│ app-v2.js  │   │ Hono +     │   │ Replica   │
│ (Vanilla   │   │ TypeScript │   │ Global    │
│ JS + Axios)│   │            │   │           │
└────────────┘   └────────────┘   └───────────┘
```

---

## 📂 Detalhamento por Diretório

### 1️⃣ `/src` - Backend e API

**Responsabilidade:** Toda a lógica do servidor

**Conteúdo:**
- **`index.tsx`** (Entry Point)
  - Inicializa o servidor Hono
  - Define rotas principais (`/`, `/portal`)
  - Registra middlewares globais
  - Retorna HTML das páginas
  - Aplica rotas da API

- **`types.ts`** (Tipos TypeScript)
  - Interfaces globais
  - Types de contexto Hono
  - Types de bindings (DB, R2, KV)

- **`routes/`** (Módulos da API)
  - Cada arquivo é um módulo independente
  - Exporta um objeto Hono com rotas
  - Importado em `index.tsx`

**Exemplo de estrutura de uma rota:**

```typescript
// src/routes/matters.ts
import { Hono } from 'hono';
import { HonoContext } from '../types';
import { authMiddleware, requireRole } from '../middleware/auth';

const matters = new Hono<HonoContext>();

// Middleware de autenticação
matters.use('/*', authMiddleware);

// GET /api/matters - Listar todas
matters.get('/', async (c) => {
  const { results } = await c.env.DB.prepare(
    'SELECT * FROM matters'
  ).all();
  
  return c.json({ matters: results });
});

// POST /api/matters - Criar nova
matters.post('/', async (c) => {
  const body = await c.req.json();
  // ... lógica de criação
  return c.json({ success: true });
});

export default matters;
```

---

### 2️⃣ `/public/static` - Frontend

**Responsabilidade:** Interface do usuário

**Arquivo principal:** `app-v2.js` (~4.500 linhas)

**Estrutura interna do app-v2.js:**

```javascript
// ====================================
// 1. CONFIGURAÇÃO GLOBAL
// ====================================
const API_BASE = '/api';
const state = {
    user: null,
    token: localStorage.getItem('token'),
    currentPage: 'dashboard'
};

// ====================================
// 2. AXIOS HTTP CLIENT
// ====================================
const api = axios.create({ baseURL: API_BASE });

// Interceptors para autenticação
api.interceptors.request.use(config => {
    if (state.token) {
        config.headers.Authorization = `Bearer ${state.token}`;
    }
    return config;
});

// ====================================
// 3. AUTENTICAÇÃO
// ====================================
async function login(email, password) { ... }
async function logout() { ... }
async function checkAuth() { ... }

// ====================================
// 4. NAVEGAÇÃO (SPA)
// ====================================
function showPage(pageName) { ... }
function loadDashboard() { ... }
function loadUsers() { ... }
function loadMatters() { ... }
function loadEditions() { ... }

// ====================================
// 5. CRUD USUÁRIOS
// ====================================
async function loadUsers() { ... }
async function createUser() { ... }
async function updateUser() { ... }
async function deleteUser() { ... }

// ====================================
// 6. CRUD MATÉRIAS
// ====================================
async function loadMatters() { ... }
async function createMatter() { ... }
async function submitMatter() { ... }
async function approveMatter() { ... }

// ====================================
// 7. CRUD EDIÇÕES
// ====================================
async function loadEditions() { ... }
async function createEdition() { ... }
async function publishEdition() { ... }
async function previewEditionPDF() { ... }

// ====================================
// 8. PORTAL PÚBLICO
// ====================================
async function searchPortal() { ... }
async function loadPortalFilters() { ... }

// ====================================
// 9. INICIALIZAÇÃO
// ====================================
document.addEventListener('DOMContentLoaded', async () => {
    await checkAuth();
    loadDashboard();
});
```

**Características:**
- ✅ Single Page Application (SPA) simples
- ✅ Roteamento client-side (via showPage)
- ✅ Estado global (objeto `state`)
- ✅ Axios para todas as requisições HTTP
- ✅ Event listeners dinâmicos
- ✅ Manipulação direta do DOM

---

### 3️⃣ `/migrations` - Database Schema

**Responsabilidade:** Versionamento do banco de dados

**Como funciona:**
1. Cada arquivo `.sql` é uma migration numerada
2. Wrangler aplica migrations em ordem
3. Tabela `d1_migrations` rastreia o que foi aplicado
4. Migrations são **idempotentes** (podem rodar múltiplas vezes)

**Exemplo de migration:**

```sql
-- 0004_add_editions.sql
CREATE TABLE IF NOT EXISTS editions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    edition_number TEXT NOT NULL UNIQUE,
    edition_date DATE NOT NULL,
    year INTEGER NOT NULL,
    status TEXT DEFAULT 'draft',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    published_at DATETIME,
    published_by INTEGER,
    FOREIGN KEY (published_by) REFERENCES users(id)
);

CREATE INDEX IF NOT EXISTS idx_editions_status ON editions(status);
CREATE INDEX IF NOT EXISTS idx_editions_date ON editions(edition_date);
```

---

### 4️⃣ `/dist` - Build Output

**Responsabilidade:** Código compilado pronto para deploy

**Conteúdo (gerado por Vite):**
- `_worker.js` - Todo o backend compilado em um único arquivo
- `_routes.json` - Configuração de roteamento para Cloudflare Pages
- Arquivos estáticos copiados de `/public`

**Processo de build:**
```bash
npm run build
  ↓
Vite compila TypeScript → JavaScript
  ↓
Hono bundler otimiza o código
  ↓
Output em /dist
  ↓
Pronto para deploy!
```

**⚠️ Não edite arquivos em `/dist` - são gerados automaticamente!**

---

## 🔄 Fluxo de Dados Completo

### Exemplo: Criar uma Nova Matéria

```
1. FRONTEND (app-v2.js)
   ↓
   Usuário preenche formulário
   ↓
   Clica em "Salvar"
   ↓
   JavaScript captura o evento
   ↓
   
2. HTTP REQUEST
   ↓
   const data = { title, content, ... };
   await api.post('/matters', data);
   ↓
   Axios adiciona Bearer token no header
   ↓
   
3. CLOUDFLARE EDGE
   ↓
   Request chega no edge mais próximo
   ↓
   Roteado para Worker
   ↓
   
4. BACKEND (src/index.tsx)
   ↓
   Hono recebe request em /api/matters
   ↓
   Roteia para src/routes/matters.ts
   ↓
   
5. MIDDLEWARE (src/middleware/auth.ts)
   ↓
   Valida JWT token
   ↓
   Decodifica user ID
   ↓
   Adiciona user ao contexto
   ↓
   
6. CONTROLLER (src/routes/matters.ts)
   ↓
   Valida dados do request
   ↓
   Prepara SQL query
   ↓
   
7. DATABASE (Cloudflare D1)
   ↓
   INSERT INTO matters (...)
   ↓
   Retorna ID da matéria criada
   ↓
   
8. RESPONSE
   ↓
   Controller retorna JSON
   ↓
   { success: true, id: 123 }
   ↓
   
9. FRONTEND ATUALIZA
   ↓
   Axios recebe response
   ↓
   JavaScript atualiza a tabela
   ↓
   Mostra mensagem de sucesso
   ↓
   ✅ CONCLUÍDO
```

---

## 📝 Arquivos de Configuração

### **package.json** - Dependências e Scripts

```json
{
  "name": "dom",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "deploy": "npm run build && wrangler pages deploy dist",
    "db:migrate:local": "wrangler d1 migrations apply dom-production --local"
  },
  "dependencies": {
    "hono": "^4.0.0"
  },
  "devDependencies": {
    "@cloudflare/workers-types": "4.20250705.0",
    "@hono/vite-cloudflare-pages": "^0.4.2",
    "vite": "^5.0.0",
    "wrangler": "^3.78.0",
    "typescript": "^5.0.0"
  }
}
```

### **tsconfig.json** - Configuração TypeScript

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "jsx": "react-jsx",
    "jsxImportSource": "hono/jsx",
    "strict": true,
    "moduleResolution": "bundler"
  }
}
```

### **vite.config.ts** - Build Configuration

```typescript
import { defineConfig } from 'vite'
import pages from '@hono/vite-cloudflare-pages'

export default defineConfig({
  plugins: [pages()],
  build: {
    outDir: 'dist'
  }
})
```

### **wrangler.jsonc** - Cloudflare Configuration

```jsonc
{
  "$schema": "node_modules/wrangler/config-schema.json",
  "name": "dom",
  "compatibility_date": "2024-01-01",
  "pages_build_output_dir": "./dist",
  
  "d1_databases": [{
    "binding": "DB",
    "database_name": "dom-production",
    "database_id": "your-db-id"
  }],
  
  "r2_buckets": [{
    "binding": "R2",
    "bucket_name": "dom-pdfs"
  }]
}
```

### **ecosystem.config.cjs** - PM2 Configuration (Dev Only)

```javascript
module.exports = {
  apps: [{
    name: 'dom',
    script: 'npx',
    args: 'wrangler pages dev dist --ip 0.0.0.0 --port 3000',
    watch: false,
    instances: 1
  }]
}
```

---

## 🎯 Resumo Rápido

| Componente | Localização | Tecnologia | Responsabilidade |
|------------|-------------|------------|------------------|
| **Backend** | `/src` | TypeScript + Hono | Lógica de negócio, API |
| **Frontend** | `/public/static` | JavaScript + Axios | Interface do usuário |
| **API Routes** | `/src/routes/*.ts` | Hono Routers | Endpoints REST |
| **Database** | `/migrations/*.sql` | SQL (SQLite) | Schema e dados |
| **Build Output** | `/dist` | JavaScript compilado | Deploy production |
| **Config** | `package.json`, `wrangler.jsonc` | JSON | Configurações |

---

## 📋 Checklist de Navegação

Para encontrar código específico:

- ✅ **Autenticação (login/logout):** `/src/routes/auth.ts` + `/public/static/app-v2.js`
- ✅ **CRUD de Usuários:** `/src/routes/users.ts` + `app-v2.js` (função `loadUsers()`)
- ✅ **CRUD de Matérias:** `/src/routes/matters.ts` + `app-v2.js` (função `loadMatters()`)
- ✅ **CRUD de Edições:** `/src/routes/editions.ts` + `app-v2.js` (função `loadEditions()`)
- ✅ **Geração de PDF:** `/src/utils/pdf-generator.ts`
- ✅ **Portal Público:** `/src/routes/portal.ts` + `app-v2.js` (função `searchPortal()`)
- ✅ **Banco de Dados:** `/migrations/*.sql`
- ✅ **Configurações:** `/src/routes/settings.ts`

---

## 🔍 Como Encontrar Algo Específico

### **Procurar um endpoint da API:**
```bash
# Exemplo: Encontrar rota de login
grep -r "login" src/routes/

# Resultado: src/routes/auth.ts
```

### **Procurar uma função do frontend:**
```bash
# Exemplo: Encontrar função de criar usuário
grep -n "createUser" public/static/app-v2.js

# Resultado: linha 1234
```

### **Procurar uma tabela no banco:**
```bash
# Exemplo: Encontrar CREATE TABLE users
grep -r "CREATE TABLE users" migrations/

# Resultado: migrations/0001_initial_schema.sql
```

---

## 💡 Dicas de Organização

1. **Backend modular:** Cada arquivo em `/src/routes` é independente
2. **Frontend monolítico:** Todo em `app-v2.js` (proposital para simplicidade)
3. **Migrations versionadas:** Numeração sequencial (0001, 0002, ...)
4. **Build automático:** Vite cuida de tudo ao rodar `npm run build`
5. **Git tracking:** `.gitignore` configurado para ignorar `node_modules/`, `.wrangler/`, `dist/`

---

**Agora você sabe exatamente onde encontrar cada parte do sistema!** 🎯

Se precisar de mais detalhes sobre alguma pasta específica, é só perguntar! 😊
