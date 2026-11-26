---
name: save-work
description: Salva o estado do projeto ativo ao final de uma tarefa (CLAUDE.md, TODO.md, HANDOFF.md, docs/DECISIONS.md) para que uma conversa nova retome sem perder contexto. Use quando o usuário rodar /save-work ou pedir para salvar o progresso/estado do projeto antes de limpar a conversa.
---

# /save-work

Objetivo: deixar o projeto pronto para uma conversa nova (`/clear`) continuar o trabalho sem perder contexto. Escreva em português, a menos que os arquivos existentes estejam em outro idioma.

## 1. Identificar o projeto ativo

- Se a sessão já definiu um projeto ativo (ex: o usuário disse "vamos trabalhar no projeto X"), use essa pasta.
- Senão, deduza pelos arquivos lidos/editados na conversa e suba até a raiz do repositório (`git rev-parse --show-toplevel`) ou, sem git, até a pasta do projeto.
- Se o diretório de trabalho já for a raiz de um projeto, use-o.
- Se houver ambiguidade (vários projetos tocados, nenhum claro), pergunte antes de escrever.
- Nunca grave em uma pasta "guarda-chuva" que agrupa projetos (ex: `~/Work`).

Se o argumento da skill nomear um projeto (`/save-work meu-projeto`), ele tem prioridade.

## 2. Levantar o que aconteceu (fatos, não suposições)

- A conversa: o que foi pedido, feito, decidido, descartado e o que ficou pendente.
- Se for repositório git: `git status`, `git diff --stat` e `git log` recente, para confirmar o que realmente mudou.
- Os arquivos de controle atuais, lidos inteiros antes de editar.

Registre só o que aconteceu de fato. Não invente pendências nem decisões.

## 3. Atualizar os arquivos (edições mínimas)

Edite apenas o que mudou; não reescreva os arquivos do zero nem "resuma" conteúdo existente que continua válido. Crie o arquivo só se ele não existir.

### CLAUDE.md (estável, carregado em toda sessão: mantenha enxuto)
Seções: **Objetivo** (pra que serve), **Como rodar** (setup, executar, testar, build), **Estrutura** (pastas principais em poucas linhas), **Convenções**, e no fim:

```markdown
## Arquivos de controle
Antes de começar, leia HANDOFF.md e TODO.md. Decisões ficam em docs/DECISIONS.md.
```

Só altere quando algo estrutural mudou (novo comando, nova pasta, nova convenção). Nada de histórico, pendências ou log de sessão aqui.

Ao atualizar, corrija ou remova o que o trabalho da sessão tornou obsoleto (comando que mudou, pasta renomeada/removida, convenção abandonada), não apenas acrescente. Informação desatualizada aqui é pior do que ausente, porque toda sessão a trata como verdade.

### TODO.md (checklist por prioridade)
```markdown
# TODO

## P0 — Bloqueante / urgente
- [ ] Item — contexto curto (arquivo:linha se ajudar)

## P1 — Importante

## P2 — Melhorias / dívida técnica

## Concluído recentemente
- [x] Item (2026-11-05)
```
- Marque como `[x]` e mova para "Concluído recentemente" o que foi feito nesta sessão, com a data.
- Adicione pendências novas na prioridade certa; reordene se a prioridade mudou.
- Mantenha no máximo ~10 itens em "Concluído recentemente"; remova os mais antigos.

### HANDOFF.md (sobrescrito a cada vez)
```markdown
# Handoff — AAAA-MM-DD

## Onde parei
## Próximo passo
(ação concreta, por onde começar)
## Atenção
(armadilhas, coisas meio feitas, estado não commitado, comandos que falharam)
```

### docs/DECISIONS.md (apenas acrescentar)
Só se houve decisão relevante nesta sessão (arquitetura, biblioteca, abordagem, trade-off). Não reescreva entradas antigas. Se uma decisão for revertida ou substituída, adicione uma nova entrada referenciando a anterior e marque o título da antiga, sem mexer no corpo: `## ~~AAAA-MM-DD — Título~~ (substituída em AAAA-MM-DD)`.
```markdown
## AAAA-MM-DD — Título curto
**Decisão:** ...
**Por quê:** ...
**Alternativas descartadas:** ...
```

Use a data real de hoje em todas as datas.

## 4. Finalizar

- Mostre um resumo curto: quais arquivos foram criados/alterados e o essencial de cada mudança (ou o `git diff` desses arquivos, se for repo).
- Se for repositório git, pergunte se quer commitar os arquivos de controle (não commite sem confirmação).
- Termine lembrando que já pode rodar `/clear` e, na próxima conversa, dizer "vamos trabalhar no projeto <nome>".
