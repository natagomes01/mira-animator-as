# WA26: três Reels animados com mira-studio

**Data:** 2026-07-29
**Autor:** Natã Gomes (design validado em conversa)
**Status:** aprovado, pronto para implementação
**Onde implementa:** `~/dev/albatroz-slides/` (a base conversacional do Mira), com a skill `/mira-studio`

## O que é

Três Reels verticais 9:16 sobre a mudança de cobrança da API Oficial do WhatsApp em outubro de 2026,
para o perfil do Natã. Cada Reel vira um deck do Mira em que o Natã aparece ao vivo dentro do slide
(webcam via `mira-camera.js`), com metáfora animada em D3 ao lado da fala e um fecho que mostra a tela
do guia publicado em `albatroz.studio/guia-whatsapp-2026`. A chamada de todos é a palavra **WA26** nos
comentários, que dispara a automação do Manychat.

O Natã fala a partir de tópicos, sem roteiro marcado. O teleprompter carrega os tópicos e fica fora
do vídeo.

## Conteúdo de origem

| O quê | Onde |
|---|---|
| Legendas, ganchos, nuvem de SEO e checklist dos 3 Reels | `~/dev/nata/content/posts/260717-ig-wapp-api-oficial2026/reel-{1,2,3}-*.md` |
| Tabela de tarifas publicada pela Meta | mesma pasta, `ref/260717-wapp-BRL.csv` |
| Exemplo de custo do agente de IA da Meta | mesma pasta, `ref/01-meta-non-template-messages.md` e `ref/03-meta-ai-providers.md` |
| Guia completo (o artigo que o Reel manda o espectador buscar) | `~/dev/studio-site/src/pages/guia-whatsapp-2026.astro` |

**Todo número dito em tela sai dessas fontes.** Nada de arredondar para efeito, nada de número novo.

## Decisões travadas

1. **Formato:** deck `mira-studio` 9:16 com câmera embutida, gravado na tecla R (gravador nativo, sem OBS).
   O teleprompter é excluído do vídeo por Element Capture, que só funciona no gravador nativo.
2. **Três decks separados, três temas.** Um Reel travado não bloqueia os outros, e cada tema serve ao argumento:

   | Deck | Tema | Por quê |
   |---|---|---|
   | `decks/wa26-reel-1-conta-outubro/` | `albatroz-dark` | laranja `#F04500` quente, cor de conta chegando |
   | `decks/wa26-reel-2-ia-meta/` | `albatroz-deco` | bronze e esmeralda: o que é caro tem cara de caro |
   | `decks/wa26-reel-3-aberta-oficial/` | `albatroz-army` | oliva institucional, cor de diagnóstico sóbrio |

3. **Tela do guia por screenshot real animado.** Capturas em PNG da página buildada, com pan e zoom
   dentro do slide. Roda por `file://`, sem servidor na hora da gravação.
4. **Ritmo:** 60 a 75 segundos, seis slides, no arranjo `camera · split · split · full · split · full`.

## Estrutura de cada Reel

Os seis slides seguem o mesmo esqueleto nos três. Muda a metáfora.

### Reel 1: a conta chega em outubro (`albatroz-dark`)

Gancho de CRENÇA. Todo mundo fala da cobrança; ninguém fala da isenção do tráfego.

| # | Layout | Animação | Dados em tela |
|---|---|---|---|
| 1 | camera | nenhuma, só a fala | |
| 2 | split | **Taxímetro de conversa.** Balões de mensagem descem numa coluna. Em setembro acendem frios com o contador travado em R$ 0,00. O mês vira, os balões acendem laranja e cada um pinga +R$ 0,035 num contador que sobe. Loop: o mês vira de novo | R$ 0,035 por mensagem |
| 3 | split | **A régua do volume.** Três barras crescem em sequência. A terceira estoura a moldura e o número roda num odômetro | 5 msgs = R$ 0,175 · 10 msgs = R$ 0,35 · 30.000 msgs = R$ 1.050/mês |
| 4 | full | **As duas portas.** Coluna esquerda: cliente que chega sozinho, cada mensagem acende com custo. Coluna direita: cliente que chega por anúncio, entra num túnel marcado 72h e as mensagens passam apagadas. Placar embaixo | R$ 1.050 contra R$ 0,00 · janela de 72h |
| 5 | split | **O painel cego.** Sistema com todos os mostradores apagados ao lado de um painel Albatroz onde três agulhas acendem | de onde o cliente veio · custo da conversa · janela aberta |
| 6 | full | Tela do guia: pan pela seção "A conta em R$" e zoom na linha dos R$ 1.050. Selo "comenta WA26" | |

### Reel 2: o agente da Meta é a conta mais cara (`albatroz-deco`)

Gancho de AUTORIDADE. Bastidor de decisão: por que o engenheiro não usa a IA da própria Meta.

| # | Layout | Animação | Dados em tela |
|---|---|---|---|
| 1 | camera | nenhuma, só a fala | |
| 2 | split | **A fatura de uma frase.** "Que horas vocês abrem?" é digitada, quatro balões respondem, e um mostrador déco em bronze gira até quase R$ 1,00 | 4 mensagens ≈ R$ 0,98 (US$ 0,16 a 0,20, câmbio ~5,1) |
| 3 | split | **A releitura.** A conversa é uma pilha de folhas. A cada pergunta nova, uma varredura desce a pilha inteira desde a primeira folha, e a pilha engorda a cada volta. O custo abre em leque déco junto | |
| 4 | full | **A balança.** Um prato com a IA da Meta e sua gordura visível, outro com o sistema implantado, magro. A mesma resposta sai dos dois lados, com peso dez vezes diferente | a entrega custa igual nos dois; a gordura, não |
| 5 | split | **O motor próprio.** Engrenagem déco montada peça por peça, com o nome da empresa gravado, contra uma caixa-preta genérica lacrada | |
| 6 | full | Tela do guia: seção "A IA da Meta: cara, e ainda engessada". Selo "comenta WA26" | |

**Trava de linguagem deste Reel:** proibido dizer "token" ou "prompt" em tela. A expressão é
"quantidade de texto que a máquina processa". O multiplicador de 2,5x do Brasil **não** se aplica aqui:
a tarifa do agente é global e flat.

### Reel 3: API aberta contra oficial (`albatroz-army`)

Gancho de CRENÇA. Posição contrária ao que o mercado grita, sustentada pela carteira real.

**Posição obrigatória:** a API aberta é caminho legítimo e é onde a maioria dos clientes está. A oficial
entra por volume ou por histórico. Nunca pintar a aberta como risco, nunca recomendar migração geral,
nunca citar Evolution ou Baileys pelo nome.

| # | Layout | Animação | Dados em tela |
|---|---|---|---|
| 1 | camera | nenhuma, só a fala | |
| 2 | split | **A manada.** Setas oliva correm todas para o mesmo lado. Três nós ficam parados e acesos | |
| 3 | split | **A carteira real.** Três cartões entram um a um, cada um com medidor de estabilidade cheio, todos marcados "aberta" | imobiliária (imóvel acima de R$ 1 milhão, brasileiro em Dubai) · clínica de cirurgia plástica · academia de 50 mensagens/dia |
| 4 | full | **O divisor de volume.** Escala vertical sobe: 20 a 40 atendimentos por dia na faixa da aberta; no topo, 600 mil mensagens, e a faixa vira oficial. As duas faixas em cores legítimas, sem vermelho em nenhuma | 20 a 40/dia · 600 mil |
| 5 | split | **As duas perguntas.** Duas chaves giram e destravam caminhos diferentes | seu volume · por onde seu cliente entra |
| 6 | full | Tela do guia: seção "API oficial ou API aberta". Selo "comenta WA26" | |

## Teleprompter

Cada slide recebe de 3 a 5 tópicos no `SCRIPT[]`, no osso, com os números prontos para ler. Nada de
frase escrita para ser recitada. Exemplo do slide 3 do Reel 1:

```
· 5 mensagens = R$ 0,175
· 10 mensagens = R$ 0,35
· 100 conversas/dia no mês = R$ 1.050
· "não é o fim do mundo por mensagem, mas some no volume"
```

O painel `#mira-prompter` (tecla T) fica na margem cinza, fora da coluna, e some durante a gravação.
O overlay `#tp-ov-wrap` é filho direto de `body`, fora das `<section>`, para o Element Capture excluir.

## Regras herdadas (não reinventar)

- **Regra Zero:** toda animação tem loop interno infinito com generation counter (`window.__slugGen`,
  onde `slug` é o identificador do slide), que impede a animação de um slide vazar no outro.
- **Fonte mínima:** nada renderiza abaixo de 13px. Em SVG com `W = 960`, `font-size >= 24`.
- **Idioma:** `agents/_shared/idioma.md`. Proibido travessão em texto visível.
- **Slides `split`:** animação num quadrado 1:1 (padrão `mira-squared`), pensada para o radial ou orbital.
- **Slides `full`:** animação com eixo dominante vertical (padrão `mira-vertical`), título em no máximo 2 linhas.
- **Cinco módulos** em `mira/`, nesta ordem antes de `</body>`: `mira-edit.js`, `mira-edit-free.js`,
  `mira-draw.js`, `mira-camera.js`, `mira-record.js`.
- **Transição dissolve** aplicada, com `view-transition-name` na UI fixa, incluindo prompter e overlay.

## O que já foi feito nesta sessão

1. **Temas sincronizados.** `albatroz-deco.css` e `albatroz-deco-light.css` copiados de
   `mira-animator-as/templates/themes/` para `albatroz-slides/mira-templates/themes/`, mais o deck
   `albatroz-deco` para `mira-templates/decks/`. Conferido com `diff -rq`: em sincronia.
2. **Telas do guia capturadas** em `albatroz-slides/assets/wa26/`, a partir de
   `studio-site/dist/guia-whatsapp-2026/` servido em localhost, com Chrome em largura 1080 e
   `deviceScaleFactor: 2`:

   | Arquivo | Pixels | Uso |
   |---|---|---|
   | `guia-topo.png` | 2160x2700 | plano de estabelecimento, opcional |
   | `guia-reel1-conta-em-reais.png` | 2160x3656 | slide 6 do Reel 1 |
   | `guia-reel2-ia-da-meta.png` | 2160x3504 | slide 6 do Reel 2 |
   | `guia-reel3-aberta-ou-oficial.png` | 2160x3222 | slide 6 do Reel 3 |

   O script que gerou as capturas está em `assets/wa26/_tools/capture-guia.mjs`. Rodar de novo só se a
   página mudar: `node assets/wa26/_tools/capture-guia.mjs` (exige `studio-site` buildado e usa o Chrome
   do sistema, porque o Chromium que vem com o puppeteer não sobe neste Mac).

## Critérios de aceite

Por deck:

- [ ] Abre por `file://` sem erro de console e sem pedir servidor.
- [ ] Seis `<section>` com `data-layout` declarado na ordem `camera · split · split · full · split · full`.
- [ ] Tema correto carregado (confere a variável `--mira-primary` do `:root`).
- [ ] Toda animação continua se mexendo depois da entrada, em loop, sem vazar entre slides.
- [ ] Nenhum texto abaixo de 13px renderizados.
- [ ] Nenhum travessão em texto visível.
- [ ] Câmera viva nas `.cam-area`, ou o fallback verde `#00FF00` quando não houver permissão.
- [ ] Teleprompter (tecla T) carregado com os tópicos e fora da coluna.
- [ ] Tecla R grava e o MP4 sai 1080x1920.
- [ ] Números conferidos contra `ref/260717-wapp-BRL.csv` e contra as legendas.
- [ ] Reel 3: a API aberta nunca aparece em cor de alerta nem como risco.

## Riscos conhecidos

- **Element Capture** exclui o teleprompter só no gravador nativo. No OBS ele apareceria, porque o OBS
  grava os pixels da janela. Se o Natã preferir OBS, usar apenas o painel lateral.
- **A tarifa de R$ 0,035 ainda não tem carimbo formal** na tabela da Meta, prometido até 1º de setembro
  de 2026. O guia já diz isso por escrito. Se a Meta publicar valor diferente antes da gravação, os
  slides 2 e 3 do Reel 1 precisam ser refeitos.
- **Gravação em `file://`** desliga o "salvar direto no disco" (File System Access), e o mux volta a ser
  em memória, com parada automática perto de 512 MB (uns 6 minutos a 12 Mbps). Para Reels de 70
  segundos, sobra folga.
