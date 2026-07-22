---
id: RFC-002
title: Infrastructure Candidate Components (Event Dispatcher, Scheduler)
version: 2.0.0
status: Approved
owner: Product Owner
depends_on:
  - SPEC-001
  - INFRA-001
related:
  - AUDIT-001
last_updated: 2026-07-21
---

# RFC-002: Infrastructure Candidate Components

## Classificação

Requires Architectural Decision

## Contexto

Durante a elaboração de `Docs/03-architecture/INFRA-001-Infrastructure-Overview.md` (Fase 2, Entrega 01), o brief de origem solicitou listar `Event Dispatcher` e `Scheduler` entre os componentes da camada Infrastructure.

Nenhum dos dois consta no Canonical Component Catalog (`SPEC-001`), que é a única fonte oficial de nomenclatura de componentes do projeto. `AGENTS.md` (regra "Canonical Naming") proíbe introduzir componentes novos em qualquer documento fora do próprio `SPEC-001`, e `ADR-007` (Architecture Baseline v1.0 Freeze) proíbe alterar `SPEC-001` sem um ADR ou uma RFC aprovada.

Por esse motivo, `Event Dispatcher` e `Scheduler` não foram incorporados como componentes aprovados em `INFRA-001` — apenas citados como candidatos, com referência a esta RFC.

## Proposta em aberto

Esta RFC não propõe estrutura, interface ou contrato para `Event Dispatcher` ou `Scheduler` — isso seria antecipar uma decisão de catálogo fora do processo formal.

Esta RFC apenas registra que existe uma necessidade potencial, identificada no roadmap da Fase 2, de:

- um componente de despacho de eventos técnicos entre componentes de Infrastructure/Execution (`Event Dispatcher`);
- um componente de agendamento de execução periódica de rotinas técnicas (`Scheduler`).

## Encaminhamento

Caso aprovados, ambos deverão ser adicionados formalmente à categoria "Infrastructure Providers" (ou categoria nova, a decidir) do `SPEC-001`, seguindo o Documentation Validation Pipeline (`AGENTS.md`), antes de aparecerem em qualquer especificação técnica futura (`INFRA-00X`).

## Resolução

Formalizada por `ADR-016`: nenhum dos dois componentes é catalogado em `SPEC-001` nesta decisão, e nenhum dos dois é rejeitado definitivamente.

- `Event Dispatcher`: **Adiado** — necessidade potencial real, sem dependência bloqueante comprovada na sequência travada (`EXEC-001` a `EXEC-005`).
- `Scheduler`: **Adiado, com viés mais forte para rejeição futura** — necessidade já coberta informalmente por `OnTimer()` (Legacy Baseline).

Critério de reabertura (`ADR-009 §8`): apenas mediante evidência obtida durante a implementação de `ROADMAP-001` ou sprints subsequentes.

## Status

**Approved** — decisão de adiamento formalizada por `ADR-016`.
