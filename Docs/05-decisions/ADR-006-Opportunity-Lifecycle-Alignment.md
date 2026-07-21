---
id: ADR-006
title: Opportunity Lifecycle Alignment
version: 1.0.0
status: Accepted
owner: Product Owner
depends_on:
  - ADR-001
  - ADR-002
  - DOMAIN-001
related:
  - DOMAIN-005
  - SPEC-005
  - ARCH-001
last_updated: 2026-07-21
---

# Contexto

Durante a evolução do modelo de domínio foi identificado que o ciclo de vida da entidade Opportunity descrevia estados pertencentes ao contexto de execução.

Estados:

Approved

↓

Executed

↓

Closed

↓

Archived

A arquitetura consolidada define:

Opportunity

↓

Decision

↓

Signal

↓

Execution

↓

Order

↓

Position

Portanto:

Execution nunca executa uma Opportunity.

Execution executa um Signal (ou posteriormente uma Order).

Esses estados representam responsabilidade do contexto de Execution e não da entidade Opportunity.

# Decisão

O ciclo de vida da entidade Opportunity será simplificado.

Opportunity termina quando origina uma Decision válida.

Execution deixa de fazer parte do ciclo de vida da Opportunity.

# Consequências

Opportunity permanece exclusivamente no Core Domain.

Execution passa a possuir ciclo de vida próprio.

SPEC-005 deixa de interpretar estados de negócio.

Nenhum documento futuro poderá recolocar estados de execução dentro de Opportunity.

Status: Accepted
