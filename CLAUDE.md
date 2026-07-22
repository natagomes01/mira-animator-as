# CLAUDE.md — mira-animator-as

Fork da Albatroz do **Mira Animator** (upstream `sandeco/mira-animator`): time de agentes de IA + templates que transforma projetos, livros e PDFs em apresentações HTML animadas (Tailwind + glassmorphism + animação vetorial em D3.js), com looping contínuo por conceito e metáfora visual animada nas ideias pesadas. Saída é um `index.html` self-contained que abre por `file://` — sem servidor, sem build.

## Licença — leia antes de publicar
Upstream é **PolyForm-Noncommercial-1.0.0**. A licença permite **monetizar o VÍDEO gerado** (o output); o que NÃO pode é revender/comercializar o próprio Mira. Ou seja: vídeo é produto, o motor não.

## Stack e conceito
- Node ≥18.20.2, ESM, bin `mira` → `bin/mira.js`. Deps: `chalk`, `inquirer`, `ora`.
- **Filosofia Reversa (fontes linkadas):** o Mira instala numa pasta de trabalho isolada e lê de **linked sources**; **nunca** escreve dentro dos projetos-fonte. Só escreve em `decks/`.
- Para `.mp4`: **ffmpeg + puppeteer** (screen-record / slide-to-video a partir do `index.html`).

## Como a Albatroz usa
- **Rodar sempre pelo FORK** (este repo), não pelo `npx mira-animator` do upstream.
- A **base conversacional** já instalada é `~/dev/albatroz-slides/` (pasta de trabalho com `mira.config.json`, `decks/`, `mira-templates/` e 6 fontes linkadas). É de lá que os decks são gerados.
- Temas da marca: **albatroz-dark** e **army**. Trilho visual: **art déco**. O front católico terá **tema bizantino** próprio.

## Estrutura
- `agents/` — as skills `mira-*` (planner, builder, animator, copywriter, visuals, 3d, chart, chart-race, svg-morph, etc.). Fonte de verdade dos comportamentos.
- `bin/` — CLI (`mira.js`, instalador). `lib/` — helpers. `templates/` — templates de deck.
- `decks/` — saídas de exemplo (nunca escrever nos projetos-fonte). `docs/` — documentação MkDocs.

## Instalação (referência upstream)
Numa pasta de slides isolada: `npx mira-animator install` — copia agentes p/ `.claude/skills/`, templates p/ `mira-templates/`, cria `decks/` e escreve `mira.config.json` + `CLAUDE.md`. (Na Albatroz isso já está feito em `albatroz-slides/`.)
