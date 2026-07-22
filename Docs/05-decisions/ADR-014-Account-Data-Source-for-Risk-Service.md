---
id: ADR-014
title: Account Data Source for Risk Service — Release 1.0
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - RFC-006
  - EXEC-003
  - EXEC-005
  - ADR-009
related:
  - ROADMAP-006
last_updated: 2026-07-22
---

# ADR-014: Account Data Source for Risk Service — Release 1.0

## Contexto

`EXEC-003` lista `Account Information` como entrada do Risk Service, mas a origem não estava formalmente esclarecida. `EXEC-005` já especifica `GetAccount()` com saída `Account Snapshot`, exatamente o dado necessário. `RFC-006` registrou essa lacuna sem criar um componente para resolvê-la.

## Decisão

Para a Release 1.0, o `Risk Service` (`EXEC-003`) consumirá diretamente o `Account Snapshot` produzido pelo `MT5 Adapter` (`EXEC-005.GetAccount()`).

Nenhum componente `Account Provider` será criado ou catalogado no `SPEC-001`.

## Limites

Esta decisão não altera os contratos de `EXEC-003` ou `EXEC-005`; apenas formaliza a proveniência de `Account Information`. Não modifica o `Position Manager`, não reabre `RFC-007` e não altera o `Risk Service` de `SPEC-003` da arquitetura-alvo de longo prazo.

## Consequências

- A dependência documental passa a ser `EXEC-003 → EXEC-005`.
- `Account Snapshot` é a fonte oficial de dados de conta para o gate operacional da Release 1.0.
- Uma abstração independente poderá ser reavaliada na Release 2.0 somente se surgir responsabilidade própria que justifique sua existência.
- `ITEM-14` do `ROADMAP-006` passa a `Implemented`.

## Rastreabilidade

`RFC-006` · `EXEC-003` · `EXEC-005` · `ROADMAP-006`
