---
id: ADR-015
title: Risk Profile Classification
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - RFC-001
  - DOMAIN-001
  - ADR-007
related:
  - DOMAIN-007
  - SPEC-003
  - ROADMAP-006
last_updated: 2026-07-22
---

# ADR-015: Risk Profile Classification

## Contexto

"Risk Profile" era citado em `DOMAIN-001` (atributo `Risk` da `Opportunity`), `DOMAIN-002` (vocabulário), `SPEC-001`/`SPEC-003` (saída declarada do `Risk Service`), sem nunca ter recebido um documento `DOMAIN-00X` próprio — divergente de todo outro conceito citado nesses mesmos documentos (`Evidence`, `Market Context`, `Decision`). Identificado em `AUDIT-001` (Finding #3) e registrado como pendência em `RFC-001`.

`ARCH-001` enumera exatamente 4 componentes no Core Domain (`Evidence`, `Market Context`, `Opportunity`, `Decision`) — `Risk Profile` nunca foi um 5º componente, e `DOMAIN-001` já o posiciona em seu diagrama de Relacionamentos como valor interno (`Opportunity → MarketContext → EvidenceSet → RiskProfile → Decision`).

## Decisão

`Risk Profile` é classificado como **Value Object**, sem identidade própria, atributo `Risk` de `Opportunity`. É produzido exclusivamente pelo `Risk Service` (`SPEC-003`, Domain Service — Entrada: `Opportunity`/`Market Context`, Saída: `Risk Profile`).

Estrutura: `Risk Score` (0.0 → 1.0), `Risk Level` (Low/Medium/High, derivado do Score), `Rationale` (estruturado), `Timestamp`. Formalizado em `DOMAIN-007`.

## Limites

Esta decisão **não** cria Bounded Context novo, **não** altera `ARCH-001` (Core Domain permanece com 4 componentes), **não** altera o contrato de `SPEC-001`/`SPEC-003` (já corretos). **Não** deve ser confundida com o Pre-Order Risk Gate (`EXEC-003`) — conceito distinto, já reconciliado por `RFC-006`/`ADR-014`.

## Consequências

- `DOMAIN-001`: atributo `Risk` passa a referenciar `DOMAIN-007` explicitamente. Nenhuma outra alteração à estrutura/BRs/ciclo de vida de `Opportunity`.
- `DOMAIN-005`: nenhum impacto estrutural.
- `SPEC-003`: nenhuma alteração de contrato.
- `RFC-001` transita de `Open` para `Approved`.
- `ROADMAP-006`: `ITEM-03` (categoria "Risk" para Evidence) e `ITEM-09` (tracking de `RFC-001`) passam a `Implemented`.

## Rastreabilidade

`RFC-001` · `DOMAIN-001` · `DOMAIN-007` · `SPEC-003` · `ARCH-001` · `ROADMAP-006`
