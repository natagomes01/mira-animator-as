# Espaçamento e UI dos slides (regra compartilhada)

Vale para todo deck que o Mira gera, em qualquer tema. Saiu da revisão do deck
`261123-jesus-deuterocanonicos` com a `/ui-ux-pro-max`, em 24/11/2026, e o Natã a fixou como
padrão em 25/11/2026. No tema `catolico-biblia` as regras já estão prontas em CSS (seção
"Componentes de argumento" do `catolico-biblia.css`). Nos outros temas, aplique o mesmo
princípio com os tokens do tema.

## 1. Medida fluida

- Toda medida fluida usa uma unidade que respeita a altura: `--u: min(1vw, 1.778vh)` (no
  `catolico-biblia` ela se chama `--cb-u`). Escreva `clamp(19px, calc(1.875 * var(--cb-u)), 36px)`,
  nunca `clamp(19px, 1.875vw, 36px)`. Com `vw` puro, janela baixa estoura o slide por baixo.
- O teto do `clamp` é o valor a 1920×1080. O piso garante leitura a 1200 de largura.
- `vw` só entra em largura máxima de bloco (`max-width: min(1300px, 70vw)`).

## 2. Escala de espaço

- Só cinco passos: `--cb-s1` (10px a 1920), `s2` (18), `s3` (32), `s4` (40), `s5` (64).
  Nenhum `px` solto em margem, gap ou padding de slide.
- Título até o bloco: `s4`. Título até barras ou passos numerados: `s5`. Entre passos numerados: `s5`.
- A reserva de rodapé (`.cb-fn-space`) só existe no slide que tem `.cb-footnotes`. Sem nota, sem
  reserva: o bloco volta ao centro óptico.

## 3. Componentes

- **Cartão de citação** (original e tradução): padding `s3 s4`, gap `s3 × .75`, filete fino entre o
  original e a tradução. Se um cartão do par tem subtítulo (ex.: "Nova Vulgata 20,32"), os dois
  rótulos ganham a mesma altura mínima, para as citações começarem na mesma linha.
- **Tabela**: cabeçalho da coluna numérica alinhado à direita, como os números. Texto longo pede
  `table-layout: fixed` e largura de coluna declarada. Tabela de poucas colunas não ocupa a tela
  inteira (`width: min(1100px, 70vw)`).
- **Barras**: o valor sai de dentro da barra e ganha coluna própria à direita. A régua de
  referência (ex.: "93%") tem o rótulo centrado na linha e nunca encosta em outro número.
- **Linha do tempo**: a linha passa pelo centro dos pontos; o ano fica acima, o evento abaixo.
  Linha cruzando o algarismo é defeito.
- **Passos numerados**: número e texto lado a lado em grade (`1.6em 1fr`), nunca empilhados.
- **Rótulo curto** (eyebrow, crédito de imagem, nota de numeração): cabe numa linha. Se quebrar,
  encurte o texto antes de reduzir a fonte.
- Texto centrado curto: `text-wrap: balance`. Corpo: `text-wrap: pretty`.

## 4. Grego

- Fonte do grego: Gentium Plus (SIL, OFL 1.1), em `var(--cb-font-greek)`. O EB Garamond desenha
  Σ, Υ, Ξ e várias ligaduras em forma cursiva, ilegível na tela.
- Offline: copie `mira-templates/vendor/fonts/gentium-*.woff2` para `assets/vendor/fonts/` do deck
  e registre o crédito no `creditos.md`.
- Transcrição de códice em maiúscula: escreva Σ impresso, não o sigma lunar Ϲ, e não use
  `text-transform: uppercase` no grego (a caixa alta automática perde acento e espírito).
  Espaçamento entre letras no máximo `.06em`.

## 5. Conferência antes de entregar

1. Abrir o deck em três janelas: 1920×1080, 1440×789 e 1200×553. Em nenhuma o conteúdo pode
   passar da moldura, nem encostar no botão "próximo" ou no rodapé.
2. Medir no navegador, não no olho: `scrollHeight > clientHeight` em cada `section` acusa estouro.
3. Contraste mínimo 4.5:1 no texto e corpo nunca abaixo de 16px na janela menor.
4. Se um slide não couber a 1200×553, diga qual e por quantos pixels. Não esconda o estouro.
