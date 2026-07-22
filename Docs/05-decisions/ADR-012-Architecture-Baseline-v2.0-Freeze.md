---
id: ADR-012
title: Architecture Baseline v2.0 Freeze
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - ADR-007
  - ADR-009
  - ADR-010
  - ADR-011
  - AUDIT-002
related:
  - DOMAIN-001
  - DOMAIN-002
  - DOMAIN-003
  - DOMAIN-004
  - DOMAIN-005
  - DOMAIN-006
  - ARCH-001
  - SPEC-001
  - SPEC-002
  - SPEC-003
  - SPEC-004
  - SPEC-005
  - SPEC-006
  - INFRA-001
  - INFRA-002
  - INFRA-003
  - EXEC-001
  - EXEC-002
  - EXEC-003
  - EXEC-004
  - EXEC-005
  - ROADMAP-006
last_updated: 2026-07-22
---

# ADR-012: Architecture Baseline v2.0 Freeze

## Status

Accepted

## Contexto

`AUDIT-002` (Baseline Architecture Certification) recertificou a Baseline após a consolidação promovida por `ADR-010` (Learning Domain), `ADR-011` (Evidence Lifecycle) e `ROADMAP-006` (Architecture Decision Backlog). O resultado foi **GO**, com Architecture Readiness Score de 88%: Core Domain intacto desde `ADR-007`, Learning Domain corretamente isolado, nenhuma duplicação ativa, nenhum documento órfão, nenhuma regressão terminológica residual. As únicas não conformidades encontradas (`ROADMAP-006` não referenciar `RFC-001` a `RFC-005`; gap de componentes de `Strategy` em `SPEC-001`; dependência "Account Provider" não rastreada; `RFC-005` não formalizada) foram classificadas como não bloqueantes.

Este ponto de consistência plena já está marcado pela tag `architecture-baseline-v2` (criada após o commit `c54e5ad`, que consolidou `ADR-010`/`ADR-011`/`DOMAIN-003` v2.0.0/`DOMAIN-006`/`ROADMAP-006`). Assim como `ADR-007` formalizou o congelamento da Baseline v1.0 após `AUDIT-001`/`RC-001`, este ADR formaliza o congelamento da Baseline v2.0 após `AUDIT-002`, conforme a Regra 1 do `DOCUMENT_CONTROL` ("nenhuma decisão arquitetural poderá permanecer apenas na conversa; toda decisão deverá gerar um ADR").

## Decisão

A partir da certificação de `AUDIT-002`, encontram-se congelados na Baseline v2.0:

- **Domínio**: `DOMAIN-001` a `DOMAIN-006` (inclui `DOMAIN-003` v2.0.0 — Evidence Lifecycle — e `DOMAIN-006` — Knowledge Model, primeiro documento do Learning Domain);
- **Arquitetura**: `ARCH-001` v1.3.0 (5 Bounded Contexts: Core Domain, Infrastructure, Strategy, Execution, Learning Domain);
- **Especificações**: `SPEC-001` a `SPEC-006`;
- **Infraestrutura**: `INFRA-001` a `INFRA-003`;
- **Execução**: `EXEC-001` a `EXEC-005`, com o pipeline Alternativa B (`RFC-006`/`RFC-007`, Approved) como arquitetura normativa da Release 1.0;
- **Governança do Learning Domain**: `ADR-010` (Bounded Context) e `ADR-011` (Evidence Lifecycle);
- **Backlog de decisões**: `ROADMAP-006`, com seus itens no estado registrado em `AUDIT-002`.

Tudo que já estava congelado por `ADR-007`/`ADR-009` permanece congelado; este ADR estende o congelamento aos documentos criados ou alterados desde então e já certificados por `AUDIT-002`.

Alterações a qualquer um desses documentos somente poderão ocorrer mediante:

- um novo ADR; ou
- uma RFC aprovada; ou
- correção documental sem impacto arquitetural.

O critério de reabertura de discussão arquitetural definido em `ADR-009 §8` (reabertura apenas mediante evidência de implementação/testes/Primeira Execução, não hipótese) permanece integralmente em vigor e se aplica também aos documentos do Learning Domain e ao ciclo de vida de Evidence.

As não conformidades registradas em `AUDIT-002` (NC-01 a NC-04) **não são bloqueadas por este congelamento** — são pendências de consolidação de rastreabilidade, a resolver via `ROADMAP-006` em paralelo ao trabalho de SPEC, sem exigir reabertura de nenhuma decisão já tomada.

`ROADMAP-001` a `ROADMAP-005` (planos de sprint da Release 1.0) e `VALIDATION-001`/`BACKTEST-001`/`DATA-001` (Trilha de Validação) não são alterados por este ADR — já operavam sob os congelamentos anteriores e permanecem válidos.

## Consequências

- Qualquer trabalho de especificação (SPEC) iniciado a partir de agora parte da Baseline v2.0 como base normativa.
- `RFC-001` a `RFC-005`, o gap de componentes de `Strategy` em `SPEC-001` e a dependência "Account Provider" continuam como pendências rastreáveis (recomendado consolidá-las em `ROADMAP-006`, conforme `AUDIT-002`), sem bloquear este congelamento.
- Correções puramente documentais continuam permitidas sem ADR/RFC.
- A tag `architecture-baseline-v2` (já existente) passa a ser reconhecida formalmente como o marco git correspondente a este congelamento.
- Este ADR não será revisitado até nova auditoria formal ou evidência de implementação/teste que justifique reabertura, conforme `ADR-009 §8`.
