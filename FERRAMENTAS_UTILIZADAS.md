# 🛠️ Ferramentas Utilizadas no Desenvolvimento do Sistema DOM

## 📋 Índice

1. [Ferramentas de Desenvolvimento](#-ferramentas-de-desenvolvimento)
2. [Serviços em Nuvem](#️-serviços-em-nuvem)
3. [Bibliotecas e Frameworks](#-bibliotecas-e-frameworks)
4. [Ferramentas de Build e Deploy](#-ferramentas-de-build-e-deploy)
5. [Ferramentas de Teste](#-ferramentas-de-teste)
6. [Ferramentas de Monitoramento](#-ferramentas-de-monitoramento)

---

## 💻 Ferramentas de Desenvolvimento

### 1. **Visual Studio Code** (Editor Recomendado)

**Versão:** Latest (1.85+)  
**Licença:** MIT (Open Source)  
**Website:** https://code.visualstudio.com

**Por que usar:**
- Editor leve e rápido
- Suporte nativo a TypeScript
- IntelliSense poderoso
- Extensões ricas
- Debugger integrado

**Extensões Essenciais:**

```javascript
// Instalar via VS Code Marketplace ou CLI
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension bradlc.vscode-tailwindcss
code --install-extension ms-vscode.vscode-typescript-next
code --install-extension alexcvzz.vscode-sqlite
```

**Lista de Extensões:**

| Extensão | Função | Link |
|----------|--------|------|
| **ESLint** | Linting JavaScript/TypeScript | [Marketplace](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) |
| **Prettier** | Code formatting | [Marketplace](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) |
| **Tailwind CSS IntelliSense** | Autocomplete Tailwind | [Marketplace](https://marketplace.visualstudio.com/items?itemName=bradlc.vscode-tailwindcss) |
| **TypeScript Hero** | Import management | [Marketplace](https://marketplace.visualstudio.com/items?itemName=rbbit.typescript-hero) |
| **SQLite Viewer** | Visualizar D1 database | [Marketplace](https://marketplace.visualstudio.com/items?itemName=alexcvzz.vscode-sqlite) |

**Configuração Recomendada (.vscode/settings.json):**

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "typescript.updateImportsOnFileMove.enabled": "always",
  "files.exclude": {
    "**/.wrangler": true,
    "**/node_modules": true,
    "**/dist": true
  }
}
```

---

### 2. **Git** (Controle de Versão)

**Versão:** 2.40+  
**Licença:** GPL v2  
**Website:** https://git-scm.com

**Instalação:**
```bash
# macOS (Homebrew)
brew install git

# Ubuntu/Debian
sudo apt-get install git

# Windows
# Baixar de https://git-scm.com/download/win
```

**Configuração Inicial:**
```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu.email@municipio.gov.br"
git config --global init.defaultBranch main
```

**Comandos Essenciais:**
```bash
# Inicializar repositório
git init

# Ver status
git status

# Adicionar arquivos
git add .

# Commit
git commit -m "mensagem"

# Ver histórico
git log --oneline

# Branch
git branch nome-da-branch
git checkout nome-da-branch

# Push para remoto
git push origin main
```

---

### 3. **Node.js e npm** (Runtime e Package Manager)

**Versão Node.js:** 18.x ou 20.x (LTS)  
**Versão npm:** 9.x ou 10.x  
**Licença:** MIT  
**Website:** https://nodejs.org

**Instalação:**
```bash
# macOS (Homebrew)
brew install node@20

# Ubuntu/Debian (via NodeSource)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Windows
# Baixar de https://nodejs.org
```

**Verificar Instalação:**
```bash
node --version   # Deve mostrar v20.x.x
npm --version    # Deve mostrar 10.x.x
```

**Comandos npm Úteis:**
```bash
# Instalar dependências
npm install

# Instalar pacote específico
npm install <pacote> --save
npm install <pacote> --save-dev

# Atualizar pacotes
npm update

# Verificar pacotes desatualizados
npm outdated

# Limpar cache
npm cache clean --force

# Rodar scripts
npm run <script>
```

---

### 4. **PM2** (Process Manager - Apenas Dev)

**Versão:** 5.x  
**Licença:** AGPL  
**Website:** https://pm2.keymetrics.io

**Instalação:**
```bash
npm install -g pm2
```

**Por que usar:**
- Auto-restart em caso de crash
- Logs centralizados
- Monitoramento de recursos
- Gerenciamento de múltiplos processos

**Comandos Principais:**
```bash
# Iniciar aplicação
pm2 start ecosystem.config.cjs

# Listar processos
pm2 list

# Ver logs
pm2 logs
pm2 logs dom --nostream

# Restart
pm2 restart dom

# Stop
pm2 stop dom

# Delete
pm2 delete dom

# Monitoramento
pm2 monit
```

**⚠️ Importante:** PM2 é usado apenas em **desenvolvimento**. Em produção, usamos Cloudflare Workers (serverless).

---

### 5. **Postman** ou **Insomnia** (API Testing)

**Postman**
- Website: https://www.postman.com
- Versão: Latest
- Licença: Freemium

**Insomnia**
- Website: https://insomnia.rest
- Versão: Latest
- Licença: MIT

**Por que usar:**
- Testar APIs REST
- Salvar coleções de requests
- Variáveis de ambiente
- Scripts de teste
- Documentação automática

**Alternativa CLI:**
```bash
# curl (pré-instalado em Linux/macOS)
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@municipio.gov.br","password":"admin123"}'
```

---

## ☁️ Serviços em Nuvem

### 1. **Cloudflare Workers** (Compute)

**Plano:** Free → Workers Paid ($5/mês)  
**Website:** https://workers.cloudflare.com  
**Documentação:** https://developers.cloudflare.com/workers

**Limites Free Tier:**
- 100.000 requests/dia
- 10ms CPU time por request
- 128MB memory
- 1MB script size

**Limites Paid:**
- Unlimited requests
- 30ms CPU time por request
- 128MB memory
- 10MB script size

**Por que escolhemos:**
- ⚡ Performance excepcional (cold start < 50ms)
- 🌍 Global (300+ cidades)
- 💰 Free tier generoso
- 🔐 Segurança integrada (DDoS, WAF)

---

### 2. **Cloudflare Pages** (Hosting Estático)

**Plano:** Free (ilimitado)  
**Website:** https://pages.cloudflare.com  
**Documentação:** https://developers.cloudflare.com/pages

**Features:**
- Builds automáticos via Git
- Preview deployments por branch
- Custom domains gratuitos
- HTTPS automático
- CDN global incluído

**Limites Free:**
- 500 builds/mês
- 20.000 arquivos por deploy
- 25MB por arquivo

---

### 3. **Cloudflare D1** (Database)

**Plano:** Alpha → GA  
**Website:** https://www.cloudflare.com/products/d1  
**Documentação:** https://developers.cloudflare.com/d1

**Limites (Plano Free):**
- 5 GB storage total
- 5 milhões reads/dia
- 100 mil writes/dia

**Por que escolhemos:**
- SQLite familiar e poderoso
- Replicação global automática
- Integração perfeita com Workers
- Migrations via SQL

**Comandos Wrangler D1:**
```bash
# Criar database
wrangler d1 create <nome>

# Listar databases
wrangler d1 list

# Aplicar migrations
wrangler d1 migrations apply <nome> --local
wrangler d1 migrations apply <nome> --remote

# Executar query
wrangler d1 execute <nome> --command="SELECT * FROM users"

# Executar arquivo SQL
wrangler d1 execute <nome> --file=./script.sql
```

---

### 4. **Cloudflare R2** (Object Storage)

**Plano:** Free → R2 Paid  
**Website:** https://www.cloudflare.com/products/r2  
**Documentação:** https://developers.cloudflare.com/r2

**Limites Free Tier:**
- 10 GB storage/mês
- 1 milhão Class A operations/mês (write)
- 10 milhões Class B operations/mês (read)

**Por que escolhemos:**
- Zero egress fees (saída gratuita)
- S3-compatible API
- CDN integrado
- Custo muito menor que AWS S3

**Uso no Projeto:**
- Armazenar PDFs gerados
- Anexos de matérias
- Logos e imagens

---

## 📚 Bibliotecas e Frameworks

### 1. **Hono** (Web Framework)

**Versão:** 4.0.0+  
**Licença:** MIT  
**GitHub:** https://github.com/honojs/hono  
**Documentação:** https://hono.dev

**Instalação:**
```bash
npm install hono
```

**Features:**
- ⚡ Ultrarrápido (14KB bundle)
- 🎯 Edge-first design
- 🔧 Middleware system
- 🛡️ Type-safe routing
- 🌐 Multi-runtime (Workers, Deno, Bun, Node)

**Exemplo Básico:**
```typescript
import { Hono } from 'hono'

const app = new Hono()

app.get('/', (c) => {
  return c.json({ message: 'Hello Hono!' })
})

export default app
```

---

### 2. **Vite** (Build Tool)

**Versão:** 5.0.0+  
**Licença:** MIT  
**GitHub:** https://github.com/vitejs/vite  
**Website:** https://vitejs.dev

**Instalação:**
```bash
npm install vite --save-dev
```

**Por que usar:**
- ⚡ Build instantâneo
- 🔄 HMR (Hot Module Replacement)
- 🎯 Otimização automática
- 📦 Code splitting inteligente

**Plugin para Cloudflare Pages:**
```bash
npm install @hono/vite-cloudflare-pages --save-dev
```

---

### 3. **TypeScript** (Linguagem)

**Versão:** 5.0.0+  
**Licença:** Apache 2.0  
**Website:** https://www.typescriptlang.org

**Instalação:**
```bash
npm install typescript --save-dev
```

**Configuração (tsconfig.json):**
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "lib": ["ES2020"],
    "jsx": "react-jsx",
    "jsxImportSource": "hono/jsx",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "moduleResolution": "bundler"
  }
}
```

---

### 4. **Wrangler** (Cloudflare CLI)

**Versão:** 3.78.0+  
**Licença:** MIT/Apache 2.0  
**GitHub:** https://github.com/cloudflare/workers-sdk  
**Documentação:** https://developers.cloudflare.com/workers/wrangler

**Instalação:**
```bash
npm install wrangler --save-dev
```

**Comandos Principais:**
```bash
# Login
wrangler login

# Whoami
wrangler whoami

# Dev server
wrangler pages dev dist

# Deploy
wrangler pages deploy dist --project-name dom

# D1 commands
wrangler d1 create <name>
wrangler d1 list
wrangler d1 migrations apply <name>

# KV commands
wrangler kv:namespace create <name>
wrangler kv:namespace list

# R2 commands
wrangler r2 bucket create <name>
wrangler r2 bucket list

# Secrets
wrangler pages secret put <key> --project-name dom
wrangler pages secret list --project-name dom
```

---

### 5. **Axios** (HTTP Client - Frontend)

**Versão:** 1.6.0  
**Licença:** MIT  
**GitHub:** https://github.com/axios/axios  
**CDN:** https://cdn.jsdelivr.net/npm/axios@1.6.0/dist/axios.min.js

**Por que usar:**
- Interceptors (auth token)
- Error handling centralizado
- Request/response transformation
- Timeout configuration

**Uso no Projeto:**
```javascript
// Configuração com interceptors
const api = axios.create({
  baseURL: '/api',
  timeout: 10000
});

// Request interceptor (adiciona token)
api.interceptors.request.use(config => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Response interceptor (trata erros)
api.interceptors.response.use(
  response => response,
  error => {
    if (error.response?.status === 401) {
      // Redirect to login
    }
    return Promise.reject(error);
  }
);
```

---

### 6. **Tailwind CSS** (CSS Framework)

**Versão:** 3.x  
**Licença:** MIT  
**Website:** https://tailwindcss.com  
**CDN:** https://cdn.tailwindcss.com

**Por que usar:**
- Utility-first approach
- Rapid development
- Mobile-first responsive
- Customizável

**Uso no Projeto (via CDN):**
```html
<script src="https://cdn.tailwindcss.com"></script>

<!-- Exemplo de uso -->
<div class="bg-blue-500 text-white p-4 rounded-lg hover:bg-blue-600">
  Botão estilizado com Tailwind
</div>
```

---

### 7. **Quill.js** (WYSIWYG Editor)

**Versão:** 1.3.6  
**Licença:** BSD  
**Website:** https://quilljs.com  
**CDN:** https://cdn.quilljs.com/1.3.6/

**Por que usar:**
- Editor rico e poderoso
- Output HTML limpo
- Toolbar customizável
- API JavaScript simples

**Uso no Projeto:**
```html
<!-- CSS -->
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">

<!-- JavaScript -->
<script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>

<script>
// Inicialização
const quill = new Quill('#editor', {
  theme: 'snow',
  modules: {
    toolbar: [
      ['bold', 'italic', 'underline'],
      [{ 'list': 'ordered'}, { 'list': 'bullet' }],
      ['link', 'image']
    ]
  }
});

// Obter HTML
const html = quill.root.innerHTML;
</script>
```

---

## 🔨 Ferramentas de Build e Deploy

### 1. **npm Scripts** (Task Runner)

**Localização:** `package.json`

**Scripts Principais:**
```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "deploy": "npm run build && wrangler pages deploy dist",
    "db:migrate:local": "wrangler d1 migrations apply dom-production --local",
    "test": "curl http://localhost:3000/api/health"
  }
}
```

**Uso:**
```bash
npm run build    # Compilar projeto
npm run deploy   # Deploy para produção
npm test         # Testar se servidor está up
```

---

### 2. **Git Hooks** (Automação)

**Ferramenta:** Husky (opcional)  
**Website:** https://typicode.github.io/husky

**Instalação:**
```bash
npm install husky --save-dev
npx husky install
```

**Exemplo (pre-commit hook):**
```bash
#!/bin/sh
# .husky/pre-commit

npm run build
npm test
```

---

## 🧪 Ferramentas de Teste

### 1. **curl** (CLI HTTP Client)

**Pré-instalado:** Linux, macOS  
**Windows:** Baixar de https://curl.se

**Comandos Úteis:**
```bash
# GET request
curl http://localhost:3000/api/health

# POST com JSON
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@municipio.gov.br","password":"admin123"}'

# Com auth token
curl http://localhost:3000/api/users \
  -H "Authorization: Bearer <token>"

# Salvar resposta
curl http://localhost:3000/api/editions/1/pdf -o edition.html
```

---

### 2. **Browser DevTools** (Debug Frontend)

**Navegadores Suportados:**
- Google Chrome (recomendado)
- Firefox Developer Edition
- Microsoft Edge

**Principais Ferramentas:**
- **Console:** Debug JavaScript, ver logs
- **Network:** Monitorar requests HTTP
- **Application:** Inspecionar localStorage, cookies
- **Performance:** Análise de performance
- **Lighthouse:** Audit de performance e acessibilidade

**Atalhos:**
- `F12` - Abrir DevTools
- `Ctrl+Shift+C` - Inspect Element
- `Ctrl+Shift+J` - Console

---

### 3. **Vitest** (Unit Testing - Futuro)

**Versão:** Latest  
**Licença:** MIT  
**Website:** https://vitest.dev

**Instalação (quando implementar):**
```bash
npm install vitest --save-dev
```

**Exemplo de Teste:**
```typescript
// auth.test.ts
import { describe, it, expect } from 'vitest'
import { generateHash, verifyPassword } from './auth'

describe('Auth Utils', () => {
  it('should hash password', async () => {
    const hash = await generateHash('senha123')
    expect(hash).toBeDefined()
    expect(hash).not.toBe('senha123')
  })
  
  it('should verify correct password', async () => {
    const hash = await generateHash('senha123')
    const isValid = await verifyPassword('senha123', hash)
    expect(isValid).toBe(true)
  })
})
```

---

## 📊 Ferramentas de Monitoramento

### 1. **Cloudflare Analytics** (Built-in)

**Localização:** Dashboard Cloudflare > Analytics

**Métricas Disponíveis:**
- Total de requests
- Bandwidth usado
- Status codes (2xx, 3xx, 4xx, 5xx)
- Cache hit ratio
- Response time percentiles
- Geographic distribution

**Acesso:**
https://dash.cloudflare.com

---

### 2. **PM2 Monitoring** (Dev Only)

**Comando:**
```bash
pm2 monit
```

**Informações:**
- CPU usage
- Memory usage
- Process uptime
- Restart count
- Logs em tempo real

---

### 3. **Wrangler Tail** (Production Logs)

**Comando:**
```bash
wrangler pages deployment tail --project-name dom
```

**Features:**
- Logs em tempo real
- Filtros por status code
- Export para arquivo

---

## 🎨 Ferramentas de Design (Opcional)

### 1. **Figma** (UI/UX Design)

**Website:** https://www.figma.com  
**Plano:** Free tier disponível

**Uso:**
- Mockups de telas
- Protótipos interativos
- Design system
- Colaboração em equipe

---

### 2. **Excalidraw** (Diagramas)

**Website:** https://excalidraw.com  
**Licença:** MIT (Open Source)

**Uso:**
- Diagramas de arquitetura
- Fluxogramas
- Wireframes rápidos

---

## 📋 Checklist de Instalação

### Setup Completo para Novo Desenvolvedor

```bash
# 1. Instalar Node.js
# Baixar de https://nodejs.org (versão 20 LTS)

# 2. Instalar Git
# Baixar de https://git-scm.com

# 3. Instalar VS Code
# Baixar de https://code.visualstudio.com

# 4. Clonar repositório
git clone <repo-url>
cd dom

# 5. Instalar dependências
npm install

# 6. Instalar Wrangler globalmente
npm install -g wrangler

# 7. Login no Cloudflare
wrangler login

# 8. Criar D1 database local
wrangler d1 create dom-production

# 9. Aplicar migrations
npm run db:migrate:local

# 10. Popular banco com dados de teste
npm run db:seed

# 11. Build projeto
npm run build

# 12. Iniciar servidor de desenvolvimento
pm2 start ecosystem.config.cjs

# 13. Verificar se está funcionando
npm test

# 14. Acessar aplicação
# http://localhost:3000
```

---

## 🔗 Links de Download

### Ferramentas Essenciais

| Ferramenta | Download | Documentação |
|------------|----------|--------------|
| **Node.js** | [nodejs.org](https://nodejs.org) | [Docs](https://nodejs.org/docs) |
| **Git** | [git-scm.com](https://git-scm.com) | [Docs](https://git-scm.com/doc) |
| **VS Code** | [code.visualstudio.com](https://code.visualstudio.com) | [Docs](https://code.visualstudio.com/docs) |
| **Postman** | [postman.com](https://www.postman.com/downloads) | [Docs](https://learning.postman.com) |

### Serviços Cloud

| Serviço | Website | Documentação |
|---------|---------|--------------|
| **Cloudflare** | [cloudflare.com](https://www.cloudflare.com) | [Developers](https://developers.cloudflare.com) |
| **Workers** | [workers.cloudflare.com](https://workers.cloudflare.com) | [Docs](https://developers.cloudflare.com/workers) |
| **D1** | [Cloudflare D1](https://www.cloudflare.com/products/d1) | [Docs](https://developers.cloudflare.com/d1) |
| **R2** | [Cloudflare R2](https://www.cloudflare.com/products/r2) | [Docs](https://developers.cloudflare.com/r2) |

---

## 💡 Dicas de Produtividade

### VS Code Shortcuts

```
Ctrl+P          # Quick file open
Ctrl+Shift+P    # Command palette
Ctrl+`          # Toggle terminal
Ctrl+B          # Toggle sidebar
Ctrl+/          # Comment line
Alt+Up/Down     # Move line up/down
Ctrl+D          # Select next occurrence
F2              # Rename symbol
```

### Terminal Aliases (Opcional)

Adicione ao `~/.bashrc` ou `~/.zshrc`:

```bash
# DOM Project aliases
alias dom-dev="cd ~/dom && npm run build && pm2 restart dom"
alias dom-logs="pm2 logs dom --nostream"
alias dom-deploy="cd ~/dom && npm run deploy:prod"
alias dom-db="cd ~/dom && wrangler d1 execute dom-production --local"
```

---

## 📝 Conclusão

O Sistema DOM utiliza um conjunto cuidadosamente selecionado de ferramentas modernas que priorizam:

- ⚡ **Performance** - Build rápido, execução eficiente
- 💰 **Custo** - Máximo de ferramentas gratuitas/open-source
- 🎯 **Simplicidade** - Curva de aprendizado suave
- 🔧 **Manutenção** - Ferramentas bem documentadas e suportadas
- 🌍 **Escalabilidade** - Preparado para crescer

**Total de ferramentas pagas obrigatórias:** 0 (Zero!) ✅

---

**Documento atualizado em:** 03/12/2025  
**Versão:** 1.0.0  
**Autor:** Sistema DOM Development Team
