# 🔍 TESTE DE DIAGNÓSTICO - Edição de Usuário

## 🎯 Objetivo
Identificar exatamente ONDE os campos `name` e `role` estão sendo perdidos.

## 📋 Instruções para Teste

### 1️⃣ Preparação
- Acesse: https://3000-iulmtf85zcwx4g6bfvptm-cc2fbc16.sandbox.novita.ai
- Faça login normalmente
- Abra o **Console do Navegador** (F12 → aba Console)
- Limpe o console (botão 🚫 ou Ctrl+L)

### 2️⃣ Limpar TUDO
**IMPORTANTE: Precisamos garantir que não há nenhum cache:**

```javascript
// Cole no console e pressione Enter:
localStorage.clear();
sessionStorage.clear();
location.reload(true);
```

Depois que recarregar, **faça login novamente**.

### 3️⃣ Abrir Ferramentas de Rede
- Vá em **F12 → aba Network (Rede)**
- ✅ Marque a opção **"Disable cache"**
- ✅ Marque a opção **"Preserve log"**

### 4️⃣ Executar o Teste
1. Vá em **"Gerenciar Usuários"** no menu lateral
2. Clique em **"Editar"** no usuário "felipe falcão"
3. Você verá **1º ALERT**: "✅ Usando código NOVO (app-v2.js)"
4. **Altere o nome** para algo diferente (ex: "Felipe Falcão TESTE")
5. **Altere o perfil** se quiser (ex: de "Secretaria" para "Admin")
6. Clique em **"Salvar"**

### 5️⃣ Observar os Alerts
Você verá **3 ALERTS em sequência**:

**Alert 1:** `🔥 SUBMIT V2! Nome: [valor] | Role: [valor]`
- Mostra o que foi capturado do DOM

**Alert 2:** `📤 ENVIANDO: {"name":"...","email":"...","role":"...","cpf":"...","secretaria_id":...,"active":...}`
- Mostra o objeto JavaScript completo que DEVERIA ser enviado

**Alert 3:** `🌐 AXIOS INTERCEPTOR: {"name":"...","email":"...","role":"...","cpf":"...","secretaria_id":...,"active":...}`
- Mostra o que o Axios VAI realmente enviar

### 6️⃣ Capturar Evidências
Após os alerts, **TIRE SCREENSHOTS** de:

1. **Console completo** mostrando todas as mensagens
2. **Aba Network → procure a requisição PUT /api/users/[número]**
   - Clique nela
   - Vá em **"Payload"** ou **"Request"**
   - Mostre o JSON que foi REALMENTE enviado

## 🔬 O Que Estamos Testando

### Cenário A: Alerts mostram valores CORRETOS
Se os 3 alerts mostrarem `name` e `role`:
- ✅ Frontend está correto
- ❌ Problema está na REDE ou SERVIDOR
- Possíveis causas: proxy, CDN, middleware do Cloudflare

### Cenário B: Alert 1 e 2 corretos, Alert 3 INCORRETO
Se primeiro e segundo alert têm `name`/`role`, mas terceiro não:
- ❌ Problema no Axios ou interceptor
- Bug no código JavaScript que modifica dados

### Cenário C: Nenhum alert aparece
Se nenhum alert aparecer:
- ❌ Código antigo ainda está sendo executado
- Service worker ou cache muito agressivo
- Solução: clear completo de cache do navegador

## 📸 O Que Enviar
1. Screenshot dos 3 alerts (pode ser 3 fotos separadas)
2. Screenshot do console completo
3. Screenshot da aba Network mostrando o Payload da requisição PUT

## ⚡ Ações Extras (se possível)

### Ver todos os event listeners do formulário:
```javascript
// Cole no console DEPOIS que o modal abrir:
const form = document.getElementById('userForm');
if (form) {
    console.log('Form element:', form);
    
    // Chrome DevTools pode mostrar listeners:
    getEventListeners(form);
}
```

### Verificar se há Service Workers:
```javascript
// Cole no console:
navigator.serviceWorker.getRegistrations().then(registrations => {
    console.log('Service Workers ativos:', registrations);
    if (registrations.length > 0) {
        console.log('⚠️ HÁ SERVICE WORKERS! Isso pode estar causando cache.');
    }
});
```

## 🎯 Resultado Esperado
Com essas informações, vamos saber EXATAMENTE onde os dados estão sendo perdidos e poderemos corrigir definitivamente.
