# CLAUDE.md — mira-animator-as

Fork da Albatroz do **Mira Animator** (upstream `sandeco/mira-animator`): time de agentes de IA + templates que transforma projetos, livros e PDFs em apresentações HTML animadas (Tailwind + glassmorphism + animação vetorial em D3.js), com looping contínuo por conceito e metáfora visual animada nas ideias pesadas. Saída é um `index.html` self-contained que abre por `file://` — sem servidor, sem build.

## Licença — leia antes de publicar
Upstream é **PolyForm-Noncommercial-1.0.0**. A licença permite **monetizar o VÍDEO gerado** (o output); o que NÃO pode é revender/comercializar o próprio Mira. Ou seja: vídeo é produto, o motor não.

## Stack e conceito
- Node ≥18.20.2, ESM, bin `mira` → `bin/mira.js`. Deps: `chalk`, `inquirer`, `ora`.
- **Filosofia Reversa (fontes linkadas):** o Mira instala numa pasta de trabalho isolada e lê de **linked sources**; **nunca** escreve dentro dos projetos-fonte. Só escreve em `decks/`.
- Para `.mp4`: **ffmpeg + puppeteer** (screen-record / slide-to-video a partir do `index.html`).

## Como a Albatroz usa
- **Rodar sempre pelo FORK** (este repo), não pelo `npx mira-animator` do upstream. Isso está garantido por `npm link`: o `bin` daqui expõe o alias `mira-animator`, e `~/dev/albatroz-slides/node_modules/mira-animator` aponta para cá. Então `npx mira-animator ...` naquela pasta executa este repo.
- A **base conversacional** já instalada é `~/dev/albatroz-slides/` (pasta de trabalho com `mira.config.json`, `decks/`, `mira-templates/` e 6 fontes linkadas). É de lá que os decks são gerados.
- Temas da marca: **albatroz-dark** e **army**. Trilho visual: **art déco**. O front católico terá **tema bizantino** próprio.

## O que é personalização Albatroz (não perder num merge)
- `templates/themes/albatroz-dark.css`, `albatroz-army.css`, `albatroz-deco.css`, `albatroz-deco-light.css`
- `templates/decks/albatroz-deco/` (capa com a logo, 4 blocos animados)
- `templates/themes/base.css`: a linha `font-family: var(--mira-font-body, 'Inter')`, que faz os temas da marca puxarem Raleway
- `lib/commands/new.js`: `albatroz-deco` dentro de `animationOnly` (o template tem paleta própria no bloco `@MIRA:THEME`)
- `package.json`: o alias de `bin` `mira-animator`
- este `CLAUDE.md` e as specs em `docs/`

O CLI lê decks e temas do disco desde a v0.1.49, então tema ou template novo da marca **não precisa** de registro em código. Basta o arquivo em `templates/`.

## Trazer atualização do upstream
Roda sempre aqui, nunca direto na pasta de slides.

```bash
cd ~/dev/mira-animator-as
git status --porcelain            # tem que estar limpo
git branch pre-merge-$(node -p "require('./package.json').version")
git fetch upstream
git merge upstream/main
```

Conflito esperado: só onde a Albatroz encostou na lista acima. Resolvendo, confira que sobreviveram a linha `--mira-font-body` no `base.css`, o `albatroz-deco` no `animationOnly` e o alias de `bin`. Depois:

```bash
node --check bin/mira.js && node --check lib/commands/new.js
npx mira-animator status         # tem que apontar para este repo
git push origin main
cd ~/dev/albatroz-slides && npx mira-animator update
```

O update na pasta de slides preserva arquivo que você editou lá (compara SHA-256 contra `.mira/_config/files-manifest.json` e reporta quantos preservou). O remote `upstream` está com push desabilitado de propósito: `git push upstream` falha, para ninguém empurrar código Albatroz no repo do Sandeco.

## Estrutura
- `agents/` — as skills `mira-*` (planner, builder, animator, copywriter, visuals, 3d, chart, chart-race, svg-morph, etc.). Fonte de verdade dos comportamentos.
- `bin/` — CLI (`mira.js`, instalador). `lib/` — helpers. `templates/` — templates de deck.
- `decks/` — saídas de exemplo (nunca escrever nos projetos-fonte). `docs/` — documentação MkDocs.

## Instalação (referência upstream)
Numa pasta de slides isolada: `npx mira-animator install` — copia agentes p/ `.claude/skills/`, templates p/ `mira-templates/`, cria `decks/` e escreve `mira.config.json` + `CLAUDE.md`. (Na Albatroz isso já está feito em `albatroz-slides/`.)
