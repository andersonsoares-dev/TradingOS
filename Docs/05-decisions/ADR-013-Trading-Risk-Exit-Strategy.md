---
id: ADR-013
title: Trading Risk & Exit Strategy — Release 1.0
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - RFC-005
  - ADR-009
  - ADR-012
related:
  - VALIDATION-001
  - EXEC-003
  - DOMAIN-001
  - DOMAIN-005
  - ROADMAP-006
last_updated: 2026-07-22
---

# ADR-013: Trading Risk & Exit Strategy — Release 1.0

## Contexto

`RFC-005` analisou alternativas de saída de posição e position sizing necessárias para o primeiro Backtest e a Primeira Execução. A decisão é operacional e não redefine o Core Domain, o contrato de `EXEC-003` nem a pendência distinta de `RFC-001` sobre `Risk Profile`.

## Decisão

Para a Release 1.0:

- a saída primária utilizará Stop baseado em ATR;
- Stop Temporal será utilizado como salvaguarda;
- o position sizing utilizará Percentual por Risco, calculado a partir da distância do stop;
- Break-even fica reservado para avaliação após o primeiro Backtest;
- Stop por Estrutura de Mercado e Trailing Stop ficam fora do MVP.

Esta decisão define a regra a ser parametrizada pelo futuro `Risk Service` (`EXEC-003`). Não implementa o serviço, não fixa valores em código e não altera seu contrato.

## Limites

Este ADR não resolve `RFC-001` (Risk Profile do Core Domain), não cria componentes e não altera `DOMAIN-001`, `DOMAIN-005`, `SPEC-001` ou `SPEC-003`.

## Consequências

- `VALIDATION-001` poderá substituir a hipótese condicional de risco por uma referência a este ADR em atualização documental futura.
- O primeiro Backtest terá uma regra determinística e compatível com o Strategy Tester do MT5.
- A implementação futura deverá manter os parâmetros configuráveis e preservar a reprodutibilidade dos testes.
- Break-even, estrutura de mercado e trailing permanecem itens de evolução posterior.

## Rastreabilidade

`RFC-005` · `VALIDATION-001` · `EXEC-003` · `ROADMAP-006` · `DOMAIN-001` · `DOMAIN-005`
