# Workspace ~/Work

Cada subpasta de `~/Work` é um projeto independente. Esta pasta não é um projeto: nunca grave arquivos de controle (CLAUDE.md, TODO.md, HANDOFF.md, docs/DECISIONS.md) diretamente aqui.

## Projeto ativo

Quando o usuário mencionar um projeto (pelo nome, mesmo que aproximado ou com grafia diferente):

1. Localize a pasta correspondente em `~/Work` (procure também um nível abaixo, ex: `~/Work/tries/<projeto>`). Se houver mais de um candidato ou nenhum, pergunte.
2. ANTES de qualquer outra ação, leia os arquivos de controle que existirem na raiz dela:
   - `CLAUDE.md` (visão geral, como rodar, estrutura, convenções)
   - `HANDOFF.md` (onde a última sessão parou e próximo passo)
   - `TODO.md` (pendências por prioridade)
   - `docs/DECISIONS.md` (consulte quando a tarefa tocar em algo já decidido)
3. Diga em uma ou duas linhas onde o projeto está (último ponto do HANDOFF + itens P0 do TODO) e siga.
4. Trate essa pasta como o projeto ativo da sessão: é onde o `/save-work` grava.

Se a pasta não tiver arquivos de controle, siga normalmente; o primeiro `/save-work` os cria.
