# 📚 Stack Tecnológico - Sistema DOM (Diário Oficial Municipal)

## 🎯 Visão Geral

O Sistema DOM é uma aplicação web moderna para gerenciamento de Diário Oficial Municipal, desenvolvida com tecnologias de ponta focadas em performance, escalabilidade e deployment na edge (Cloudflare).

---

## 🏗️ Arquitetura Geral

**Tipo:** Full-stack Web Application
**Arquitetura:** Frontend-Backend Separado com API REST
**Deployment:** Cloudflare Pages + Workers (Edge Computing)
**Banco de Dados:** Cloudflare D1 (SQLite distribuído)
**Armazenamento:** Cloudflare R2 (S3-compatible)

---

## 🔧 Backend Stack

### Framework Web
- **Hono** `v4.0.0+` 
  - Framework web ultrarrápido e leve para Cloudflare Workers
  - Compatível com Web Standards (Fetch API)
  - Roteamento modular e middleware system
  - Tipagem TypeScript nativa
  - **Por que?** Otimizado para edge runtime, bundle pequeno (~14KB), excelente performance

### Linguagem
- **TypeScript** `v5.0.0+`
  - Superset tipado de JavaScript
  - Type safety em desenvolvimento
  - Melhor DX (Developer Experience)
  - Compilação para JavaScript moderno

### Runtime
- **Cloudflare Workers Runtime**
  - V8 isolates (não Node.js)
  - Execução na edge (próximo ao usuário)
  - Cold start ~0ms
  - Escalabilidade automática global
  - **Limitações:** Sem acesso a Node.js APIs (fs, path, etc)

### Build Tool
- **Vite** `v5.0.0+`
  - Build tool moderno e rápido
  - HMR (Hot Module Replacement) instantâneo
  - Otimização de bundle automática
  - Plugin `@hono/vite-cloudflare-pages` para integração

### CLI e Deployment
- **Wrangler** `v3.78.0+`
  - CLI oficial da Cloudflare
  - Deploy para Pages e Workers
  - Gerenciamento de D1 databases
  - Secrets e variáveis de ambiente
  - Desenvolvimento local com `--local` mode

---

## 💾 Banco de Dados

### Database Principal
- **Cloudflare D1**
  - SQLite distribuído globalmente
  - Replicação automática em múltiplas regiões
  - Consistência eventual
  - Migrations via Wrangler
  - SQL syntax completo

### Schema Management
- **SQL Migrations**
  - Versionamento em `/migrations/*.sql`
  - Comando: `wrangler d1 migrations apply`
  - Rollback manual via SQL scripts
  - Histórico na tabela `d1_migrations`

### Desenvolvimento Local
- **SQLite Local**
  - Flag `--local` usa SQLite em `.wrangler/state/v3/d1`
  - Mesma estrutura do ambiente de produção
  - Migrations aplicadas localmente
  - Dados isolados do ambiente remoto

### Principais Tabelas
```sql
- users              # Usuários do sistema
- secretarias        # Secretarias municipais
- matter_types       # Tipos de matéria (Decreto, Portaria, etc)
- matters            # Matérias para publicação
- editions           # Edições do diário oficial
- edition_matters    # Relacionamento matérias-edições
- attachments        # Anexos de matérias
- audit_logs         # Logs de auditoria
- system_settings    # Configurações do sistema
```

---

## 📦 Armazenamento de Arquivos

### Object Storage
- **Cloudflare R2**
  - S3-compatible object storage
  - Zero egress fees (saída de dados gratuita)
  - CDN integrado
  - Armazenamento de PDFs e anexos

### Uso no Projeto
- PDFs gerados das edições
- Anexos de matérias (documentos, imagens)
- Logos e assets do sistema

---

## 🎨 Frontend Stack

### Abordagem
- **HTML Server-Side Rendering (SSR)**
  - HTML gerado pelo Hono backend
  - Templates inline em TypeScript
  - JavaScript Vanilla para interatividade

### Biblioteca JavaScript
- **Vanilla JavaScript ES6+**
  - Sem frameworks pesados (React, Vue, Angular)
  - Bundle único: `/static/app-v2.js`
  - Modular e organizado por features
  - Async/await para requisições

### HTTP Client
- **Axios** `v1.6.0` (via CDN)
  - Cliente HTTP para requisições à API
  - Interceptors para auth token
  - Error handling centralizado
  - CDN: `https://cdn.jsdelivr.net/npm/axios@1.6.0/dist/axios.min.js`

### UI Framework CSS
- **Tailwind CSS** `v3.x` (via CDN)
  - Utility-first CSS framework
  - Classes inline para estilização rápida
  - Responsivo por padrão
  - CDN: `https://cdn.tailwindcss.com`

### Ícones
- **Font Awesome** `v6.4.0` (via CDN)
  - Biblioteca de ícones vetoriais
  - 20.000+ ícones disponíveis
  - Gratuito e open-source
  - CDN: `https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.4.0/css/all.min.css`

### Rich Text Editor
- **Quill.js** `v1.3.6` (via CDN)
  - Editor WYSIWYG para conteúdo de matérias
  - Toolbar customizável
  - Output em HTML limpo
  - CDN CSS: `https://cdn.quilljs.com/1.3.6/quill.snow.css`
  - CDN JS: `https://cdn.quilljs.com/1.3.6/quill.min.js`

### Bibliotecas Utilitárias (via CDN)
- **Chart.js** - Gráficos e visualizações
- **Lodash** - Utilitários JavaScript
- **Day.js** - Manipulação de datas

---

## 🔐 Autenticação e Segurança

### Estratégia de Auth
- **JWT (JSON Web Tokens)**
  - Stateless authentication
  - Token armazenado no localStorage
  - Expiração configurável (24h padrão)
  - Refresh manual via re-login

### Criptografia
- **bcrypt** (simulado com Web Crypto API)
  - Hash de senhas com salt
  - Função customizada: `generateHash()`
  - Comparação segura de hashes

### Autorização
- **RBAC (Role-Based Access Control)**
  - Roles: `admin`, `semad`, `publisher`, `author`
  - Middleware `requireRole()` para proteção de rotas
  - Permissões granulares por endpoint

### Segurança Adicional
- **CORS configurado** via middleware Hono
- **Rate limiting** (pode ser adicionado)
- **SQL Injection protection** via prepared statements
- **XSS protection** via sanitização de inputs

---

## 📄 Geração de PDF

### Estratégia Atual
- **HTML → PDF Conversion**
  - Geração de HTML estruturado e estilizado
  - CSS print-friendly com @page rules
  - Layout responsivo e otimizado para impressão

### Estrutura do PDF
```typescript
- Cabeçalho com logo e informações da edição
- Aviso de edição suplementar (se aplicável)
- Expediente do município
- Índice organizado (Secretaria > Tipo > Matérias)
- Conteúdo das matérias com layout em colunas
- Anexos com links
- Rodapé com informações de validação
- Informações do publicador
```

### Futuras Melhorias
Para conversão real HTML→PDF em produção:
- **Puppeteer Cloud** (Browserless.io, Apify)
- **Gotenberg** (self-hosted)
- **PDFShift API**
- **Cloudflare Browser Rendering** (quando disponível)

---

## 🛠️ Ferramentas de Desenvolvimento

### Package Manager
- **npm** `v9.0.0+`
  - Gerenciamento de dependências
  - Scripts de build e deploy
  - Lockfile: `package-lock.json`

### Process Manager (Desenvolvimento)
- **PM2** `v5.x`
  - Gerenciamento de processos Node.js
  - Auto-restart em caso de crash
  - Logs centralizados
  - **Uso:** Apenas em desenvolvimento (não em produção)

### Controle de Versão
- **Git** `v2.x`
  - Versionamento de código
  - Branches: `main` (produção), `develop` (desenvolvimento)
  - `.gitignore` configurado para Node.js/TypeScript

### Editor de Código (Recomendado)
- **Visual Studio Code**
  - Extensões recomendadas:
    - ESLint
    - TypeScript Hero
    - Tailwind CSS IntelliSense
    - SQLite Viewer

---

## 📦 Dependências Principais

### Production Dependencies
```json
{
  "hono": "^4.0.0"
}
```

### Development Dependencies
```json
{
  "@cloudflare/workers-types": "4.20250705.0",
  "@hono/vite-cloudflare-pages": "^0.4.2",
  "vite": "^5.0.0",
  "wrangler": "^3.78.0",
  "typescript": "^5.0.0"
}
```

### CDN Libraries (Frontend)
```javascript
// CSS Frameworks
- Tailwind CSS v3.x
- Font Awesome v6.4.0
- Quill.js v1.3.6 (CSS)

// JavaScript Libraries
- Axios v1.6.0
- Quill.js v1.3.6
- Chart.js (latest)
- Lodash v4.17.21
- Day.js v1.11.10
```

---

## 🚀 Scripts NPM

### Desenvolvimento
```bash
npm run dev              # Vite dev server (frontend only)
npm run dev:sandbox      # Wrangler pages dev (backend + frontend)
npm run dev:d1           # Wrangler com D1 database local
```

### Build
```bash
npm run build            # Compilar TypeScript + Vite build
```

### Deploy
```bash
npm run deploy           # Build + Deploy para Cloudflare Pages
npm run deploy:prod      # Deploy para produção com project name
npm run preview          # Preview local do build
```

### Database
```bash
npm run db:migrate:local    # Aplicar migrations no D1 local
npm run db:migrate:prod     # Aplicar migrations no D1 produção
npm run db:seed             # Popular banco com dados de teste
npm run db:reset            # Resetar banco local
npm run db:console:local    # Console SQL local
npm run db:console:prod     # Console SQL produção
```

### Utilidades
```bash
npm run cf-typegen       # Gerar tipos TypeScript para bindings
npm run clean-port       # Matar processo na porta 3000
npm test                 # Testar se servidor está respondendo
```

### Git Shortcuts
```bash
npm run git:init         # Inicializar repositório Git
npm run git:commit       # Commit com mensagem
npm run git:status       # Ver status do Git
npm run git:log          # Ver log de commits
```

---

## 🌍 Ambiente de Produção

### Cloudflare Pages
- **Deployment automático** via Git integration
- **Branch deployments** (production + preview)
- **Custom domains** suportado
- **HTTPS automático** com certificado SSL
- **Global CDN** com cache inteligente

### Variáveis de Ambiente
```bash
# Desenvolvimento (.dev.vars)
DATABASE_URL=local
R2_BUCKET=local
JWT_SECRET=dev-secret-key

# Produção (Cloudflare Dashboard)
DATABASE_URL=<D1_DATABASE_ID>
R2_BUCKET=<R2_BUCKET_NAME>
JWT_SECRET=<production-secret>
```

### Secrets Management
```bash
# Adicionar secrets via Wrangler
wrangler pages secret put JWT_SECRET --project-name dom
wrangler pages secret put API_KEY --project-name dom

# Listar secrets
wrangler pages secret list --project-name dom
```

---

## 📊 Monitoramento e Logs

### Logs de Aplicação
- **Cloudflare Workers Logs**
  - Dashboard: Workers & Pages > Logs
  - Real-time via `wrangler tail`
  - Retention: 24 horas (plano Free), 7 dias (plano pago)

### Logs de Auditoria
- **Tabela `audit_logs`**
  - Todas as ações críticas registradas
  - User ID, entity type, action, IP, user agent
  - Timestamps precisos
  - Queryable via SQL

### Analytics
- **Cloudflare Analytics**
  - Requests por segundo
  - Cache hit ratio
  - Response time percentiles
  - Geographic distribution

---

## 🔄 Workflow de Desenvolvimento

### 1. Setup Inicial
```bash
# Clone do repositório
git clone <repo-url>
cd dom

# Instalar dependências
npm install

# Configurar Wrangler
wrangler login

# Criar D1 database local
wrangler d1 create dom-production --local

# Aplicar migrations
npm run db:migrate:local

# Popular com dados de teste
npm run db:seed
```

### 2. Desenvolvimento Local
```bash
# Build do projeto
npm run build

# Iniciar servidor com PM2
pm2 start ecosystem.config.cjs

# Verificar logs
pm2 logs dom --nostream

# Acessar aplicação
http://localhost:3000
```

### 3. Deploy para Produção
```bash
# Build de produção
npm run build

# Deploy para Cloudflare Pages
npm run deploy:prod

# Verificar deployment
wrangler pages deployment list --project-name dom
```

---

## 🧪 Testing

### Testes Manuais
- **Endpoints principais:** `/api/health`, `/api/auth/login`
- **Frontend:** Navegação completa pelo dashboard
- **PDF Generation:** Publicar edição e baixar PDF

### Ferramentas de Teste
- **curl** - Testes de API via linha de comando
- **Postman** - Collection de endpoints (pode ser criada)
- **Browser DevTools** - Debug de frontend

### Testes Futuros (Recomendado)
- **Vitest** - Unit tests para funções TypeScript
- **Playwright** - E2E tests para fluxos completos
- **Miniflare** - Local Workers testing

---

## 📈 Performance

### Métricas Esperadas
- **Cold Start:** < 50ms (Cloudflare Workers)
- **API Response Time:** < 100ms (média)
- **Database Query:** < 50ms (D1 local), < 150ms (D1 global)
- **Page Load:** < 1s (First Contentful Paint)
- **PDF Generation:** < 2s para edições com até 50 matérias

### Otimizações Implementadas
- CDN para todos os assets estáticos
- Lazy loading de bibliotecas JavaScript
- SQL queries otimizadas com índices
- Prepared statements para prevenção de SQL injection
- Gzip compression automático (Cloudflare)

---

## 🔧 Configurações Importantes

### wrangler.jsonc
```jsonc
{
  "$schema": "node_modules/wrangler/config-schema.json",
  "name": "dom",
  "compatibility_date": "2024-01-01",
  "pages_build_output_dir": "./dist",
  "compatibility_flags": ["nodejs_compat"],
  
  "d1_databases": [{
    "binding": "DB",
    "database_name": "dom-production",
    "database_id": "<YOUR_D1_DATABASE_ID>"
  }],
  
  "r2_buckets": [{
    "binding": "R2",
    "bucket_name": "dom-pdfs"
  }]
}
```

### vite.config.ts
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

### ecosystem.config.cjs (PM2)
```javascript
module.exports = {
  apps: [{
    name: 'dom',
    script: 'npx',
    args: 'wrangler pages dev dist --ip 0.0.0.0 --port 3000',
    env: {
      NODE_ENV: 'development',
      PORT: 3000
    },
    watch: false,
    instances: 1,
    exec_mode: 'fork'
  }]
}
```

---

## 🎓 Recursos de Aprendizado

### Documentação Oficial
- **Hono:** https://hono.dev
- **Cloudflare Workers:** https://developers.cloudflare.com/workers
- **Cloudflare D1:** https://developers.cloudflare.com/d1
- **Cloudflare R2:** https://developers.cloudflare.com/r2
- **Wrangler:** https://developers.cloudflare.com/workers/wrangler
- **Vite:** https://vitejs.dev
- **TypeScript:** https://www.typescriptlang.org

### Tutoriais Recomendados
- Hono Getting Started: https://hono.dev/getting-started
- Cloudflare Pages Functions: https://developers.cloudflare.com/pages/functions
- D1 Database Tutorial: https://developers.cloudflare.com/d1/get-started

---

## 🆘 Troubleshooting

### Problemas Comuns

**1. Porta 3000 ocupada**
```bash
# Solução
npm run clean-port
# ou
fuser -k 3000/tcp
```

**2. Build falha com TypeScript errors**
```bash
# Solução
npm install
npm run build
```

**3. D1 database não encontrado**
```bash
# Solução
wrangler d1 create dom-production
# Atualizar database_id em wrangler.jsonc
npm run db:migrate:local
```

**4. PM2 não inicia**
```bash
# Solução
pm2 delete all
pm2 start ecosystem.config.cjs
pm2 logs --nostream
```

**5. Authentication não funciona**
```bash
# Verificar se JWT_SECRET está configurado
# Login deve retornar um token válido
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@municipio.gov.br","password":"admin123"}'
```

---

## 📞 Suporte e Contato

### Repositório
- **GitHub:** (adicionar URL quando disponível)

### Documentação Interna
- `README.md` - Visão geral e quickstart
- `STACK_TECNOLOGICO.md` - Este documento
- `/migrations/*.sql` - Schema do banco de dados
- `/src/types.ts` - Interfaces TypeScript

### Cloudflare Community
- **Discord:** https://discord.cloudflare.com
- **Community Forum:** https://community.cloudflare.com

---

## 📝 Changelog de Tecnologias

### v1.0.0 (Atual)
- ✅ Hono v4.0.0
- ✅ Cloudflare D1 (SQLite)
- ✅ Cloudflare R2 (Object Storage)
- ✅ Vite v5.0.0
- ✅ TypeScript v5.0.0
- ✅ Tailwind CSS v3 (CDN)
- ✅ Quill.js v1.3.6 (CDN)

### Futuras Atualizações Planejadas
- 🔄 Testes automatizados (Vitest)
- 🔄 E2E tests (Playwright)
- 🔄 PDF real generation (Puppeteer Cloud)
- 🔄 WebSocket support para notificações real-time
- 🔄 PWA (Progressive Web App)

---

## 📜 Licença

Este projeto é proprietário e desenvolvido para uso exclusivo da Prefeitura Municipal.

---

**Última Atualização:** 03/12/2025
**Versão do Documento:** 1.0.0
**Autor:** Sistema DOM Development Team
