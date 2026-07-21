---
id: VALIDATION-001
title: Trading Strategy Baseline
version: 1.0.0
status: Approved
owner: Product Owner
depends_on:
  - ADR-004
  - ADR-008
related:
  - AUDIT-001
last_updated: 2026-07-21
---

# Trading Strategy Baseline

Primeiro documento da Trilha 2 — Validation (`ADR-008`). Define a estratégia a ser validada e os critérios de aceitação da validação. **Não define** gestão de risco nem critérios de saída — ver "Fora de Escopo".

---

# Objetivo

Validar, antes de qualquer escala adicional da plataforma, se a estratégia de geração de sinal já implementada na Legacy Baseline (V1) possui expectativa positiva (edge) — respondendo à pergunta central: *vale a pena continuar investindo em infraestrutura para esta estratégia, ou o sinal em si precisa mudar primeiro?*

---

# Escopo

Este documento define:

- qual estratégia será validada;
- quais critérios de entrada já existem (referência ao código, não nova regra);
- em quais ativos, período e timeframe a validação ocorre;
- qual pipeline de validação será seguido (`ADR-004`);
- quais métricas e limiares definem sucesso ou fracasso da validação.

Este documento **não** define:

- gestão de risco (position sizing, risco por operação);
- critérios de saída (stop loss, take profit, trailing);
- qualquer regra de negócio nova.

Ver "Fora de Escopo".

---

# Estratégia Inicial a Validar

A única estratégia hoje implementada e executável é a da **Legacy Baseline (V1)**, congelada desde o Sprint 0.5 (`ADR-001`, `Docs/BACKLOG.md`): `MarketService` (Trend/ATR/RSI/ADX/Session/Pivot) → `MarketAssessmentService` (Score/Bias/Confidence) → `SignalBuilderService` (`TradingSignal`).

Nenhum componente do modelo-alvo (`Opportunity`/`Decision`/`Market Context` formal) está implementado — portanto não há uma segunda estratégia disponível para validar ainda. Esta validação incide exclusivamente sobre a V1.

---

# Critérios de Entrada (já existentes — referência, não nova regra)

Conforme `SignalBuilderService` (código já implementado, Legacy Baseline):

- **BUY/SELL**: exige as 4 confirmações (`TrendConfirmed`, `ADXConfirmed`, `RSIConfirmed`, `SessionConfirmed`) e `ConfidenceLevel` = HIGH.
- **WAIT**: exige bias definido (`MarketAssessment.Bias` ≠ NEUTRAL) e ao menos 2 das 4 confirmações.
- **NO_TRADE**: qualquer outro caso.

Este documento não altera esses critérios — apenas os referencia como o objeto de estudo da validação.

---

# Parâmetros da Validação

Valores propostos abaixo, com base em evidência já registrada no projeto (RC1, `Docs/BACKLOG.md`). Marcados **(proposto)** onde ainda dependem de confirmação do Product Owner antes do primeiro backtest.

## Ativos

- EURUSD, USDJPY — já validados manualmente no RC1 (Dashboard funcional, matemática do Pivot conferida). **(proposto como primeira rodada)**
- GBPUSD, XAUUSD — citados no RC1 como "não testados"; candidatos para uma segunda rodada, após resultado da primeira. **(proposto)**

## Período Histórico

Mínimo recomendado: 2 a 3 anos de histórico, cobrindo diferentes regimes de volatilidade. **(proposto — período exato pendente de confirmação e disponibilidade de dados no MT5)**

## Timeframe

H4, H1, M15 — os mesmos três timeframes já consumidos internamente por `MarketContext`/`MarketService` na Legacy Baseline. Não introduz timeframe novo.

## Expectativa Mínima (critério de aceitação)

Profit Factor > 1,0 e expectativa por operação estatisticamente positiva (maior que zero, líquida de custos de spread/comissão) — como limiar mínimo para considerar que a estratégia possui edge digno de mais investimento em plataforma. **(proposto — limiar exato pendente de confirmação)**

## Drawdown Máximo Aceitável (critério de aceitação da validação, não regra operacional)

Um teto de drawdown (ex.: 20–30% do capital simulado) é usado aqui **apenas como critério de aceite do relatório de validação** — para decidir se a estratégia passou ou não no teste. Isto é diferente de uma regra de gestão de risco aplicada durante a operação ao vivo (position sizing, stop por operação), que está fora do escopo deste documento (ver "Fora de Escopo"). **(proposto — limiar exato pendente de confirmação)**

## Métricas de Sucesso

- Profit Factor;
- Win Rate;
- Expectativa por operação (líquida de custos);
- Drawdown máximo (critério de aceite da validação, conforme acima);
- Número de operações (tamanho de amostra suficiente para significância);
- Sharpe/Sortino, quando viável calcular sobre a amostra.

---

# Pipeline de Validação

Este documento não cria um pipeline novo — mapeia diretamente para os estágios já definidos em `ADR-004`:

| Estágio (ADR-004) | Documento futuro desta trilha |
|---|---|
| Static Analysis | (já coberto pelo processo de desenvolvimento existente) |
| Compilation | (já praticado — MetaEditor CLI, 0 erros/0 avisos) |
| Strategy Tester / Historical Simulation | `BACKTEST-001` |
| Walk Forward | `WALKFORWARD-001` |
| Demo Validation | `FORWARDTEST-001` |
| — (consolidação) | `EDGE-REPORT-001` |
| Production Validation | fora do escopo desta trilha, até edge comprovado |

---

# Fora de Escopo

Explicitamente **não** tratados neste documento — deverão ser objeto de RFC/ADR próprios antes de qualquer implementação:

- **Gestão de risco**: position sizing, risco máximo por operação, exposição por ativo. Associado a `Risk Service` (`SPEC-001`, status `Planned`) e `REQ-009` (não atendido).
- **Critérios de saída**: stop loss, take profit, trailing stop, tempo máximo em posição. Não existe hoje em nenhum `DOMAIN`/`SPEC` — precisará ser definido por decisão de produto própria, não inferido aqui.

A separação é intencional (`ADR-008`): validação, arquitetura e regras de negócio permanecem em documentos e processos de aprovação distintos.

---

# Rastreabilidade

- `ADR-004` (Validation Strategy — pipeline oficial de validação, mapeado acima).
- `ADR-008` (Roadmap Restructuring — origem desta trilha).
- `AUDIT-001` (Coverage Matrix — Testing, ponto de partida ~15%).
- `SPEC-001` (Risk Service, status Planned — referência para o item "Fora de Escopo").

---

# Próximos Documentos

`BACKTEST-001`, `WALKFORWARD-001`, `FORWARDTEST-001`, `EDGE-REPORT-001` — conforme "Pipeline de Validação" acima.
