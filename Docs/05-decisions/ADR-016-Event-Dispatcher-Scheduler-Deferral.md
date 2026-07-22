---
id: ADR-016
title: Event Dispatcher & Scheduler — Deferral Decision
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - RFC-002
  - INFRA-001
  - ARCH-001
  - ADR-009
related:
  - SPEC-001
  - ROADMAP-006
last_updated: 2026-07-22
---

# ADR-016: Event Dispatcher & Scheduler — Deferral Decision

## Contexto

`RFC-002` registrou dois candidatos a componente da camada Infrastructure — `Event Dispatcher` (despacho de eventos técnicos) e `Scheduler` (agendamento de execução periódica) — citados no brief de origem de `INFRA-001`, mas nunca catalogados em `SPEC-001` (Canonical Component Catalog).

Análise técnica realizada: nenhum dos 5 componentes de Execution (`EXEC-001` a `EXEC-005`, sequência travada por `ADR-009`) declara dependência formal de `Event Dispatcher` ou `Scheduler` — cada um apenas lista seus próprios eventos publicados, sem depender de um mecanismo de despacho comum. `SPEC-002` (Interface Contracts) não define nenhum Port de eventos. `ROADMAP-001` (Sprint 1) menciona "inicializar Event Bus (caso previsto)" — condicional, não uma exigência arquitetural. A necessidade de execução periódica já é coberta informalmente pelo `OnTimer()` nativo do MQL5 (Legacy Baseline, ver `SPEC-001` — Component Lifecycle).

## Decisão

Nenhum dos dois componentes é catalogado em `SPEC-001` nesta decisão. Nenhum dos dois é rejeitado definitivamente.

- **Event Dispatcher**: **Adiado**. Existe necessidade potencial real (múltiplos componentes já publicam eventos nomeados; `ROADMAP-001` antecipa condicionalmente um Event Bus), mas nenhuma dependência bloqueante comprovada hoje.
- **Scheduler**: **Adiado, com viés mais forte para rejeição futura**. A necessidade já é coberta informalmente por `OnTimer()`; nenhuma lacuna documental identificada.

## Critério de Reabertura

Conforme `ADR-009 §8`: esta decisão só poderá ser reaberta mediante evidência obtida durante a implementação da Sprint 1 (`ROADMAP-001`) ou sprints subsequentes — não por hipótese. Se a implementação revelar necessidade real de despacho de eventos ou agendamento além do que `OnTimer()` cobre, a RFC correspondente deverá ser reaberta com essa evidência.

## Limites

Esta decisão **não** altera `SPEC-001`, `INFRA-001`, `ARCH-001` ou qualquer arquivo de código (`.mq5`/`.mqh`). Não cria componente novo. Não fecha definitivamente a possibilidade de `Event Dispatcher`/`Scheduler` existirem no futuro — apenas posterga a decisão de catalogação até haver evidência concreta.

## Consequências

- `RFC-002` transita de `Open` para `Approved` — a decisão tomada é "adiar com critério de reabertura definido", não "aprovar componente" nem "rejeitar componente".
- `ROADMAP-006`: `ITEM-10` passa de `Awaiting RFC` para `Approved` (decisão de adiamento formalizada, sem propagação a `SPEC-001` por design).
- Nenhuma sprint da Release 1.0 é afetada — nenhum componente da sequência travada depende de `Event Dispatcher`/`Scheduler`.

## Rastreabilidade

`RFC-002` · `INFRA-001` · `ARCH-001` · `SPEC-001` · `ADR-009` · `ROADMAP-006`
