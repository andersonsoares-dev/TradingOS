---
id: ADR-001
title: Legacy Baseline
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - CONST-001
  - ENG-000
related:
  - TRACEABILITY.md
last_updated: 2026-07-21
---

# ADR-001: Legacy Baseline

## Status

Accepted

## Contexto

O protocolo de governança (`.project-rules/DOCUMENT_CONTROL.md`, `CLAUDE.md`, `AGENTS.md`, `CONST-001`, `ENG-000`) foi adotado em 2026-07-21, após a implementação completa da V1 do TradingOS (`TrendService`, `ATRService`, `RSIService`, `ADXService`, `SessionService`, `PivotService`, `MarketAssessmentService`, `SignalBuilderService`, `Dashboard`, `PivotRenderer`). Esse código não foi construído seguindo a arquitetura formal agora exigida (Adapters, DDD completo, rastreabilidade REQ → DOMAIN → ARCH → SPEC).

## Decisão

- Todo código existente até esta data compõe a **Legacy Baseline (V1)**.
- A V1 não será refatorada apenas para aderir à arquitetura oficial.
- Novos componentes deverão seguir integralmente a arquitetura definida na governança.
- Refatorações na V1 ocorrerão apenas quando agregarem valor funcional, de manutenção ou desempenho — nunca somente por conformidade documental.
- A Legacy Baseline passa a ser referência histórica do projeto.

## Consequências

- `TRACEABILITY.md` documenta os componentes da Legacy Baseline sem rastreabilidade formal completa.
- Nenhuma ação de refatoração é exigida como consequência direta deste ADR.
- Divergências entre a Legacy Baseline e a governança atual deixam de ser tratadas como pendências bloqueantes.
