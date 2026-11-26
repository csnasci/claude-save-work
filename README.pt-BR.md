# save-work — uma skill para o Claude Code

[English](README.md)

Retome um projeto numa conversa nova do Claude Code sem perder o contexto.

Ao fim de uma tarefa, rode `/save-work`. O Claude atualiza alguns arquivos de controle na raiz do projeto:

| Arquivo | Papel | Como é atualizado |
|---|---|---|
| `CLAUDE.md` | Visão geral, como rodar, estrutura, convenções | Só quando algo estrutural mudou; o que ficou obsoleto é removido |
| `TODO.md` | Checklist por prioridade (P0/P1/P2 + concluídos) | Itens marcados, adicionados, repriorizados |
| `HANDOFF.md` | Onde a sessão parou, próximo passo, armadilhas | Sobrescrito a cada vez |
| `docs/DECISIONS.md` | Registro de decisões (decisão, por quê, alternativas descartadas) | Só acrescenta |

Depois rode `/clear` e, na próxima conversa, diga "vamos trabalhar no projeto <nome>".

A skill registra só o que aconteceu de fato (confere `git status`/`git log` em repositórios), faz edições mínimas em vez de reescrever os arquivos e pergunta antes de commitar.

## Instalação

```bash
git clone https://github.com/csnasci/claude-save-work.git
cd claude-save-work
./install.sh pt-BR    # Português
./install.sh          # English
```

Ou copie `skills/pt-BR/save-work/` (ou `skills/en/save-work/`) para `~/.claude/skills/save-work/` manualmente. Rode o script de novo para atualizar; um `SKILL.md` anterior diferente é salvo como backup.

## Opcional: retomar um projeto pelo nome

A skill salva o estado. Para o Claude *ler* esse estado sozinho quando você mencionar um projeto, deixe seus projetos numa pasta só (ex: `~/Work`) e coloque as instruções de workspace num `CLAUDE.md` nessa pasta:

- Português: [`workspace/CLAUDE.pt-BR.md`](workspace/CLAUDE.pt-BR.md)
- English: [`workspace/CLAUDE.en.md`](workspace/CLAUDE.en.md)

Troque `~/Work` pela sua pasta. Abra o Claude Code nela e diga "vamos trabalhar no projeto foo": o Claude acha `~/Work/foo`, lê `CLAUDE.md`, `HANDOFF.md` e `TODO.md`, diz onde o projeto está e passa a tratá-lo como a pasta onde o `/save-work` grava.

Sem isso o `/save-work` continua funcionando; basta abrir o Claude Code dentro do projeto e pedir para ler `HANDOFF.md` e `TODO.md` (o `CLAUDE.md` gerado já instrui isso).

## Licença

[MIT](LICENSE)
