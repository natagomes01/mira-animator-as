#!/usr/bin/env bash
# Rotina Albatroz: trazer o upstream (sandeco/mira-animator) para este fork
# sem perder a personalizacao da marca, e depois atualizar a pasta de slides.
#
# Uso:  ./albatroz/atualizar-upstream.sh            (roda tudo, para em conflito)
#       ./albatroz/atualizar-upstream.sh --checar   (so confere o inventario Albatroz)
#
# O script para no primeiro erro (set -e). Em conflito de merge, ele imprime o
# que fazer e sai; voce resolve no editor, roda `git add`, `git commit`, e
# chama de novo com --checar antes do push.
set -euo pipefail

FORK="$(cd "$(dirname "$0")/.." && pwd)"
SLIDES="${MIRA_SLIDES:-$HOME/dev/albatroz-slides}"
cd "$FORK"

checar_inventario() {
  echo "== Inventario Albatroz =="
  local falhas=0
  grep -q "var(--mira-font-body, 'Inter')" templates/themes/base.css \
    && echo "ok  base.css: --mira-font-body" || { echo "ERRO base.css perdeu --mira-font-body"; falhas=1; }
  grep -q "'albatroz-deco'," lib/commands/new.js \
    && echo "ok  new.js: albatroz-deco no THEME_AGNOSTIC" || { echo "ERRO new.js perdeu albatroz-deco"; falhas=1; }
  grep -q '"mira-animator": "bin/mira.js"' package.json \
    && echo "ok  package.json: alias de bin" || { echo "ERRO package.json perdeu o alias mira-animator"; falhas=1; }
  ! head -n1 bin/mira.js | grep -q $'\r' \
    && echo "ok  bin/mira.js: shebang em LF" || { echo "ERRO bin/mira.js: shebang com CR (node\\r quebra no macOS)"; falhas=1; }
  grep -q "var idx = 0" templates/decks/mira-studio-demo/index.html \
    && echo "ok  mira-studio-demo: indice como estado" || { echo "AVISO mira-studio-demo perdeu o fix de navegacao (beafabb)"; }
  for t in albatroz-dark albatroz-army albatroz-deco albatroz-deco-light; do
    [ -f "templates/themes/$t.css" ] && echo "ok  tema $t" || { echo "ERRO tema $t sumiu"; falhas=1; }
  done
  [ -f templates/decks/albatroz-deco/index.html ] && echo "ok  template albatroz-deco" || { echo "ERRO template albatroz-deco sumiu"; falhas=1; }
  node --check bin/mira.js && node --check lib/commands/new.js && echo "ok  sintaxe"
  echo "== Arquivos que diferem do upstream (deve ser so Albatroz + .gitignore + docs) =="
  git diff --name-only upstream/main
  return $falhas
}

if [ "${1:-}" = "--checar" ]; then checar_inventario; exit $?; fi

# 1. Arvore limpa, senao o diff do merge fica ilegivel.
if [ -n "$(git status --porcelain)" ]; then
  echo "Arvore suja. Commite ou guarde (git stash) antes."; git status --short; exit 1
fi

# 2. Buscar o upstream e medir a distancia.
git fetch upstream
ATUAL=$(node -p "require('./package.json').version")
NOVA=$(git show upstream/main:package.json | node -p "JSON.parse(require('fs').readFileSync(0,'utf8')).version")
N=$(git rev-list --count main..upstream/main)
echo "Fork: $ATUAL | Upstream: $NOVA | Commits novos: $N"
[ "$N" = "0" ] && { echo "Nada a trazer."; exit 0; }

# 3. Ensaio: lista conflitos sem tocar na arvore.
echo "== Ensaio do merge =="
git merge-tree --write-tree HEAD upstream/main | grep CONFLICT || echo "sem conflito previsto"

# 4. Branch de seguranca com a versao atual no nome.
git branch -f "pre-merge-$ATUAL"
echo "Branch de seguranca: pre-merge-$ATUAL (voltar: git reset --hard pre-merge-$ATUAL)"

# 5. Merge de verdade.
if ! git merge upstream/main; then
  cat <<MSG

== CONFLITO. O que fazer agora ==
  git diff --name-only --diff-filter=U        # lista os arquivos em conflito
  Abra cada um, procure <<<<<<< ======= >>>>>>> e escolha.
  Conflito de arquivo inteiro (linha 1 ate a ultima) e CRLF:
    git show upstream/main:<arquivo> | grep -c \$'\\r'
    Tome a versao do upstream, reaplique a edicao Albatroz, entregue no mesmo
    fim de linha do upstream (sed 's/\$/\\r/' converte LF em CRLF).
  Depois:  git add <arquivo>  ...  git commit
  E confira:  ./albatroz/atualizar-upstream.sh --checar
  Desistir:   git merge --abort
MSG
  exit 2
fi

# 6. Conferencia, push, update na pasta de slides.
checar_inventario
echo "== Pronto para: git push origin main && cd $SLIDES && npx mira-animator update =="
echo "Revise o inventario acima. Se estiver tudo ok, rode os dois comandos."
