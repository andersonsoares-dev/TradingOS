---
id: ADR-002
title: Domain Evolution
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - ADR-001
  - CONST-001
related:
  - TRACEABILITY.md
last_updated: 2026-07-21
---

# ADR-002: Domain Evolution

## Status

Accepted

## Contexto

`CONST-001` declara "Oportunidade" como objeto central do domínio. A V1 implementa esse conceito através de `MarketAssessment` (Score/Bias/Confidence) e `TradingSignal` (BUY/SELL/WAIT/NO_TRADE), nomes e estruturas que não correspondem ao modelo de domínio-alvo.

## Decisão

- A V1 utiliza `MarketAssessment` e `TradingSignal`.
- A arquitetura-alvo evolui para `MarketContext`, `Opportunity` e `Decision`.
- Não haverá renomeação retroativa de `MarketAssessment`/`TradingSignal` na V1.
- Novos componentes utilizarão o novo modelo de domínio (`Opportunity`, `Decision`).
- A migração de `MarketAssessment`/`TradingSignal` para o novo modelo ocorrerá apenas quando houver benefício real, não por conformidade isolada.

## Consequências

- Convivência temporária de dois vocabulários de domínio (V1 legado e modelo-alvo) é aceita e esperada.
- Documentação futura (`DOMAIN-*`) deve explicitar claramente a qual modelo cada componente pertence.
